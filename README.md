# Object Diff
An object diff framework in Pharo.

## Motivation

Assertions failing in SUnit are sometimes difficult to dig into. In particular, those comparing two long and almost identical strings.

## Design

Object Diff injects extension methods into certain classes to compute the differences with arbitrary instances.
It uses double-dispatch to properly compare classes according to their semantics. As last resort, it relies on instVar comparisions.

## Usage

First, load it with Metacello:

``` smalltalk
Metacello new repository: 'github://rydnr/object-diff:main'; baseline: 'ObjectDiff'; load
```

Afterwards, just call `yourInstance odDiff: anotherInstance`. It will return a specific instance of the classes of the package *Object-Diff*. You'll be able to ask if they are `identical`, `incompatible`, or to display the differences in a custom format.

## Customization

By default Object-Diff uses wildcards to compare objects. For example,
``` smalltalk
'abc' odDiff: '<ANYTHING>' identical
```
returns `true`. You can disable this feature with `ODWildcards disable`, or add your own wildcards with
``` smalltalk
ODWildcards matches at: '*' put: true
```

## Work in progress

- Add Glamorous Toolkit visualization.
- Support for file diffs.
- Improve String vs String differences.

## Credits
- Background of the Pharo image by <a href="https://pixabay.com/users/jobischpeuchet-4390049/">JoBischPeuchet</a> from <a href="https://pixabay.com/">Pixabay</a>.
