{ pkgs }:

let
  engineLibs = pkgs.lib.makeLibraryPath [ pkgs.openssl pkgs.stdenv.cc.cc.lib ];
  engineInterp = pkgs.stdenv.cc.bintools.dynamicLinker;
in
{
  shellHook = ''
    ev="node_modules/@prisma/engines-version/package.json"
    if [ -f "$ev" ]; then
      commit="$(${pkgs.nodejs_22}/bin/node -e "console.log(require(process.cwd()+'/'+process.argv[1]).version.split('.').pop())" "$ev")"
      cache="$HOME/.cache/prisma-engines/$commit"
      base="https://binaries.prisma.sh/all_commits/$commit/debian-openssl-3.0.x"
      if [ ! -e "$cache/.ready" ]; then
        echo "prisma: fetching engines $commit (one-time)"
        mkdir -p "$cache/bin" "$cache/lib"
        _fetch() { ${pkgs.curl}/bin/curl -fsL "$1" 2>/dev/null | ${pkgs.gzip}/bin/gunzip > "$2" 2>/dev/null; [ -s "$2" ] || { rm -f "$2"; return 1; }; }
        if _fetch "$base/libquery_engine.so.node.gz" "$cache/lib/libquery_engine.node"; then
          ${pkgs.patchelf}/bin/patchelf --set-rpath "${engineLibs}" "$cache/lib/libquery_engine.node"
        fi
        for e in schema-engine migration-engine introspection-engine prisma-fmt; do
          if _fetch "$base/$e.gz" "$cache/bin/$e"; then
            chmod +x "$cache/bin/$e"
            ${pkgs.patchelf}/bin/patchelf --set-interpreter "${engineInterp}" --set-rpath "${engineLibs}" "$cache/bin/$e"
          fi
        done
        touch "$cache/.ready"
      fi
      export PRISMA_QUERY_ENGINE_LIBRARY="$cache/lib/libquery_engine.node"
      [ -f "$cache/bin/schema-engine" ]        && export PRISMA_SCHEMA_ENGINE_BINARY="$cache/bin/schema-engine"
      [ -f "$cache/bin/migration-engine" ]     && export PRISMA_MIGRATION_ENGINE_BINARY="$cache/bin/migration-engine"
      [ -f "$cache/bin/introspection-engine" ] && export PRISMA_INTROSPECTION_ENGINE_BINARY="$cache/bin/introspection-engine"
      [ -f "$cache/bin/prisma-fmt" ]           && export PRISMA_FMT_BINARY="$cache/bin/prisma-fmt"
      export PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING=1
      for n in linux-nixos debian-openssl-3.0.x debian-openssl-1.1.x; do
        for d in node_modules/.prisma/client node_modules/@prisma/client; do
          [ -d "$d" ] && ln -sf "$cache/lib/libquery_engine.node" "$d/libquery_engine-$n.so.node"
        done
      done
    fi
  '';
}
