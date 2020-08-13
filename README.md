# mono-surveyor
Tooling for scalable Flutter and Dart monorepos.

## How?
### Structure
Dependencies between packages in a monorepo are detected by scraping the `path` dependencies in the `pubspec.yaml` of each package and figuring out what depends on what. Directories without a `pubspec.yaml` in their root are not considered when finding packages and resolving dependencies. Nested packages may cause problems with change detection, are a violation of the [package layout conventions](https://dart.dev/tools/pub/package-layout) and will break Flutter's hot-reload when debugging an app which depends on nested packages. mono-surveyor assumes that packages will exist in `packages` and `apps` and will follow directory trees if packages are grouped into other folders.

### Surveys
mono-surveyor detects changes at the package level, as compared to the default branch of the repositories remote. That is, any changes on the local repository or the current branch, when compared to the default branch on the remote. Actions are taken based on changes through the use of `surveys`. Each package in a monorepo decides independently how to respond to (or ignore) `surveys` through the use of a `surveys.json` defined in each package root.   
For example each package in the template https://github.com/chgibb/mono-surveyor-demo has the following `surveys.json`:
```JSON
{
    "surveys": {
        "lint": [
            "flutter analyze"
        ],
        "format":[
            "flutter format lib"
        ]
    }
}
```
Each key in `surveys` is an array of strings. Each string represents a command (or survey step) that will be run in the given order in the root of the package. If a survey step returns anything other than `0`, the survey for the package will be aborted and any pending surveys for other packages will also be aborted. Packages can ignore specific surveys by specifying an empty array of steps for the survey to be ignored. It is an error for a package to not provide at least an empty array of steps for a survey that is being performed on it.

### Running Surveys
Activate `mono_surveyor` first with
```
flutter pub global activate -sgit https://github.com/chgibb/mono-surveyor
```
To run a survey on the monorepo, invoke
```
flutter pub global run mono_surveyor:run_survey --survey=<survey_name>
```
By default, `run_survey` will determine the minimal set of packages to survey. The flag `--no-just-affected` can be provided to survey every package in a monorepo as if they've all been changed.

Surveys are completely customizable per package. They are executed step by step in the root of each package. This means packages can optionally provide their own  shell scripts, `npm` commands or other executables without any thought given to other packages in the monorepo. The names of surveys themselves are completely arbitrary as long as they do not contain whitespace and are also valid JSON strings. i.e. `build-release-android-qa`, `build_release_ios_app_store` are both valid survey names.

### IDE Integration
See `.vscode/launch.json` in https://github.com/chgibb/mono-surveyor-demo for an example of how to setup the usual Flutter debugging experience in VSCode for apps in a monorepo.
See `.vscode/tasks.json` in https://github.com/chgibb/mono-surveyor-demo for an example integration with VSCode's task runner to run surveys on changed packages.

### Other Utilities
`mono_surveyor:collect_packages` can be run to analyze a monorepo and print a crude layout of each package and it's dependencies.  
`mono_surveyor:determine_changed_packages` can be run to show packages that have been directly modified and all packages that will be affected through any of their transitive dependencies having been modified. This is the same resolution algorithm used by survey running.

### Further Work
- Surveys are run serially and without regard to dependency order. That means library packages which build and distribute some artifacts or other files as Flutter `assets` 
may not work.
- Each package in a monorepo is wholly separate from each other. Tooling to enforce or at least point out packages with the same `hosted` or `git` dependencies with different or conflicting versions should be developed.