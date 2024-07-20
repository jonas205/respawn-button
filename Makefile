.PHONY: run zip respawn-button lsp_reference

run: respawn-button
	~/.steam/bin/steam-runtime/run.sh ~/.local/share/Steam/steamapps/common/Factorio/bin/x64/factorio

zip:
	cd lua/respawn-button && fmtk package

respawn-button:
	rsync -arvz --delete lua/respawn-button ~/.factorio/mods

lsp_reference:
	fmtk luals-addon -d ~/.local/share/Steam/steamapps/common/Factorio/doc-html/runtime-api.json -p ~/.local/share/Steam/steamapps/common/Factorio/doc-html/prototype-api.json
