# NOTER

**Noter** is a lightweight CLI app for quickly writing and reading notes.

## Installation

1. Make sure you have Ruby and `bundle` installed.

```console
gem install bundle
```

2. Clone the repository:

```console
git clone https://github.com/artemdorozhkin/noter.git
cd noter
```

3. Install dependencies:

```console
bundle install
```

4. Make the CLI executable:

```console
chmod +x bin/note
```

4. Add `bin/` to your `$PATH` for global access:

```bash
echo 'export PATH="$PATH:$(pwd)/bin"' >> ~/.bashrc
source ~/.bashrc
```

Now you can run `note` from anywhere.

## Usage

```console
note [command] [arguments]
```

| command                  | description                                                                              |
| ------------------------ | ---------------------------------------------------------------------------------------- |
| `write / w [text]`       | Appends the given text to the `.notes` file.                                             |
| `read / r [n]`           | Reads the last `n` notes from the `.notes` file. If `n` not specified, prints all notes. |
| `grep / g [word/phrase]` | Displays notes that contain the given word or phrase.                                    |
|                          | NOTE: Do **not** use quotes around the phrase.                                           |
| `del / d [n]`            | Deletes the note at line `n` (1-based index).                                            |
| `clear`                  | Deletes the `.notes` file.                                                               |
