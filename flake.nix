{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs

  outputs =
    { self, ... }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );

      /*
        Change this value ({major}.{min}) to
        update the Python virtual-environment
        version. When you do this, make sure
        to delete the `.venv` directory to
        have the hook rebuild it for the new
        version, since it won't overwrite an
        existing one. After this, reload the
        development shell to rebuild it.
        You'll see a warning asking you to
        do this when version mismatches are
        present. For safety, removal should
        be a manual step, even if trivial.
      */
      version = "3.13";
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        let
          concatMajorMinor =
            v:
            pkgs.lib.pipe v [
              pkgs.lib.versions.splitVersion
              (pkgs.lib.sublist 0 2)
              pkgs.lib.concatStrings
            ];

          python = pkgs."python${concatMajorMinor version}";
        in
        {
          default = pkgs.mkShellNoCC {
            venvDir = ".venv";

            postShellHook = ''
              venvVersionWarn() {
              	local venvVersion
              	venvVersion="$("$venvDir/bin/python" -c 'import platform; print(platform.python_version())')"

              	[[ "$venvVersion" == "${python.version}" ]] && return

              	cat <<EOF
              Warning: Python version mismatch: [$venvVersion (venv)] != [${python.version}]
                       Delete '$venvDir' and reload to rebuild for version ${python.version}
              EOF
              }

              venvVersionWarn
            '';

            packages = with python.pkgs; [
              venvShellHook
              pip
              python-lsp-server # Python implementation of the lsp
              pkgs.basedpyright # Type checker for Python
              #
              # # Core Web Framework
              # fastapi # Web framework for building APIs
              # uvicorn # Lightning-fast ASGI server
              # httpx # Next generation HTTP client
              # python-multipart # Streaming multipart parser for Python
              #
              # # Database (Async PostgreSQL via SQLModel/SQLAlchemy)
              # sqlmodel # Module to work with SQL databases
              # sqlalchemy # Python SQL toolkit and ORM
              # alembic # Database migration tool for SQLAlchemy
              # asyncpg # Asyncio PostgreSQL driver
              # psycopg2 # PostgreSQL database adapter for Python
              #
              # # Security & Auth
              python-dotenv # Add .env support to django/flask apps in dev and deploy
              pandas
              # pydantic # Data validation and settings management using Python type hinting
              # pydantic-settings # Settings management using pydantic
              # email-validator # Email syntax and deliverability validation library
              # bcrypt # Modern password hashing for your software and server
              # pyjwt # JSON Web Token implementation in Python
              # cryptography # Package which provides cryptographic recipes and primitives
              #
              # # Testing & Dev Tools
              # pytest # Framework for writing tests
              # pytest-asyncio # Library for testing asyncio with pytest
              # pytest-mock # Thin wrapper around the mock package for easier use with pytest
              # requests # HTTP library for Python

              pkgs.ruff # Extremely fast Pytho linter and code formatter

            ];
          };
        }
      );
    };
}
