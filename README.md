# Immich Screensaver

**What is it?** A utility for creating symlinks to pictures stored in [Immich](https://github.com/immich-app/immich).

## Usage
Currently, the utility only works on MacOS 13.0+ with a Swift runtime.

1. Define your Immich API settings
Create a file named `immichAPI.pkl` as follows:
```pkl
amends "../ImmichAPI.pkl"

key = "[YOUR IMMICH API KEY]"
endpoint = "http://[YOUR IMMICH URL]/api"
```
Both values are required.

2. Define your search options
Create a file named `options.pkl` with the desired options:
```pkl
amends "../ImmichScreensaverOptions.pkl"

/*
  Optional.
  Immich albums to be included in the output.
  Joined with `includeFaces` as an OR operation.
*/
includeAlbums = new {
    "My Awesome Trip"
    "Best Doggo"
}
/*
  Optional.
  Immich albums to be excluded in the output.
  If set, these albums will never appear in the output.
  Takes precedence over `includeAlbums`:
    if a picture exists both in an included
    and excluded album, it will not appear.
*/
excludeAlbums = new {
    "Boring things..."
}

/*
  Optional.
  Names of people to be included in the output.
  Joined with `includeAlbums` as an OR operation.
*/
includePeople = new {
    "Steve Jobs"
    "Linus Torvalds"
}
/*
  Optional.
  Names of people to be excluded in the output.
  If set, these people will never appear in the output.
  Takes precedence over `includePeople`:
    if a picture contains both an included
    and excluded person, it will not appear.
*/
excludePeople = new {
    "Bill Gates"
}

/*
   Optional.
   Date from which to start looking for pictures.
*/
startDate = new {
    day = 1
    month = 1
    year = 2000
}

/*
   Optional.
   Date on which to stop looking for pictures.
*/
startDate = new {
    day = 31
    month = 12
    year = 2099
}

/*
   If true, will not display pictures that have been archived.   
*/
excludeArchived = true

/*
   Tell script where to find original photos.
   Also used for output.
*/
uploadLocation = "Same as Immich's UPLOAD_LOCATION environment variable"
```

## Development
```sh
./pkl-gen-swift pkl/ImmichAPI.pkl -o Sources/Generated
./pkl-gen-swift pkl/ImmichScreensaverOptions.pkl -o Sources/Generated
```

```sh
swift build -c release
cp .build/release/ImmichScreensaver .
```

## To-do
- [ ] Include Albums
- [ ] Exclude Albums
- [x] Include People
- [ ] Exclude People
- [ ] Start Date
- [ ] End Date
- [ ] Exclude Archived
