# Object Diff
An object diff framework in Pharo.

## Motivation

Assertions failing in SUnit are sometimes difficult to dig into. In particular, those comparing two long and almost identical strings.

## Design

Object Diff injects extension methods into certain classes to compute the differences with arbitrary instances.
It uses double-dispatch to properly compare classes according to their semantics. As last resort, it relies on instVar comparisions.

## Usage

Just call `yourInstance odDiff: anotherInstance`. It will return a specific instance of the classes of the package *Object-Diff*. You'll be able to ask if they are `identical`, or to display the differences in a custom format.

## Work in progress

- Support more reciprocal diffs (Dictionary vs Number, Array vs String, etc.).
- Add Glamorous Toolkit visualizations.
- Support for files.
- Improve String vs String differences.

## Credits
- Background of the Pharo image by <a href="https://pixabay.com/users/jobischpeuchet-4390049/">JoBischPeuchet</a> from <a href="https://pixabay.com/">Pixabay</a>.
