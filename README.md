# PkgUp

A simple Crystal CLI tool to update system packages and Flatpak apps on Debian-based Linux systems.  
Automatically detects whether to use `doas` or `sudo` for privilege escalation, and prefers `nala` if installed, falling back to `apt`.

## Features

- Update system packages (`apt` or `nala`)
- Update Flatpak applications
- Choose to update system packages, Flatpak, or both
- Uses `doas` if available, otherwise `sudo`

## Requirements

- Crystal programming language installed (for building from source)
- Debian-based Linux (Ubuntu, Debian, etc.)
- Optional: `doas` or `sudo`
- Optional: `nala` package manager
- Flatpak installed (if updating Flatpak apps)

## Installation

### Option 1: Use the Precompiled Binary

1. Download the `pkgup` binary from the [Releases](#) section.
2. Move it to a directory in your `PATH` (e.g., `/usr/local/bin`):

   ```bash
   sudo mv pkgup /usr/local/bin/
   sudo chmod +x /usr/local/bin/pkgup
   ```

### Option 2: Build from Source

1. Clone this repository or download the `pkgup.cr` file.
2. Compile the program:

   ```bash
   crystal build pkgup.cr --release -o pkgup
   ```

3. (Optional) Move the compiled binary to your `PATH`:

   ```bash
   sudo mv pkgup /usr/local/bin/
   ```

## Usage

Run the program:

```bash
./pkgup
```

You will be prompted to select which updates to perform:

```
Would you like to update [sys]pkgs, [flatpak]pkgs, or [both]:
```

Enter one of:

- `sys` — update system packages only
- `flatpak` — update Flatpak applications only
- `both` — update both system packages and Flatpak apps

## Example

```bash
$ ./pkgup
Would you like to update [sys]pkgs, [flatpak]pkgs, or [both]: sys
Updating System Programs...
System update complete!
```

## License

MIT License

---

*Created with Crystal 💎 by roguehashrate*  