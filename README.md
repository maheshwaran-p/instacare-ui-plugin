# instacare-ui-plugin

Monorepo for Instacare Flutter UI plugin and demo app.

## Repository Structure

```text
instacare-ui-plugin/
  instacare_components/          # Main Flutter package
    lib/                         # Component source + exports
    example/                     # Showcase app
    android/ ios/ macos/         # Flutter plugin platform scaffolding
    test/                        # Package tests
    README.md                    # Full package documentation
  components list.png
  create-plugin.sh
```

## Main Package

- Path: `instacare_components`
- Docs: `instacare_components/README.md`
- Public import: `package:instacare_components/instacare_components.dart`

## Run Demo

```bash
cd instacare_components/example
flutter run
```
