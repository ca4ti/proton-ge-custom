#!/bin/bash

    #Temporary fix for "Workaround `cannot convert ‘SteamNetworkingMessage_t*’ to ‘SteamNetworkingMessage_t* const*’ in initialization` error
    cd lsteamclient
    patch -Np1 < ../game-patches-testing/steamclient_144_workaround.patch
    cd ..

    #WINE SYSTEM PERFORMANCE PATCHES
    cd wine
    git reset --hard HEAD
    git clean -xdf

    #revert bison check for proton
    git revert --no-commit a4c93936c9493f7619e1877b522eeb809a390dfe
    git revert --no-commit 5ea4d5971bff3430c29f1da31166b0a2565347ab
    git revert --no-commit 2d27c13d5ea76ec80e2a67272c8eafe8527e6af0
    git revert --no-commit 6d4cdeb658e1cfd7c73643f674a0043006970b44

    #echo "Applying wine-staging patches..."
    ../wine-staging/patches/patchinstall.sh DESTDIR="." --all -W xaudio2-revert -W xaudio2_7-CreateFX-FXEcho -W xaudio2_7-WMA_support -W xaudio2_CommitChanges -W winex11.drv-mouse-coorrds

    #WINE GAME SPECIFIC PATCHES

    echo "fix for Skyrim Script Extender not working"
    patch -Np1 < ../game-patches-testing/f4skyrimse-fix.patch

    echo "ffxiv launcher patch"
    patch -Np1 < ../game-patches-testing/ffxiv-launcher.patch

    echo "warframe F6 screenshot button fix"
    patch -Np1 < ../game-patches-testing/warframe-f6-screenshot-fix.patch

    echo "Mech Warrior Online patch"
    patch -Np1 < ../game-patches-testing/mwo.patch

    echo "Resident Evil 4 patch"
    patch -Np1 < ../game-patches-testing/resident_evil_4_hack.patch

    echo "World of Final Fantasy patch"
    patch -Np1 < ../game-patches-testing/woff-hack.patch

    #WINE FAUDIO PATCHES

    echo "allow wine to use faudio with ffmpeg"
    patch -Np1 < ../game-patches-testing/faudio-ffmpeg.patch

    echo "add missing upstream faudio patches"
    patch -Np1 < ../game-patches-testing/faudio-proton-xact-support-1.patch
    patch -Np1 < ../game-patches-testing/faudio-proton-xact-support-2.patch
    patch -Np1 < ../game-patches-testing/faudio-proton-fix-ed05940.patch
    patch -Np1 < ../game-patches-testing/faudio-proton-fix-837f11c.patch
    patch -Np1 < ../game-patches-testing/faudio-proton-use-dxredist-x3daudio-xapofx.patch
    patch -Np1 < ../game-patches-testing/faudio-proton-configure-use-dxredist-x3daudio-xapof.patch

    #protonify
    patch -Np1 < ../game-patches-testing/proton-tkg.patch

    #applying overall game performance fixes
    patch -Np1 < ../game-patches-testing/FS_bypass_compositor.patch
    patch -Np1 < ../game-patches-testing/valve_proton_fullscreen_hack-staging.patch
    patch -Np1 < ../game-patches-testing/proton-vk-bits-4.5.patch

    patch -Np1 < ../game-patches-testing/proton-restore-unicode.patch
    patch -Np1 < ../game-patches-testing/valve-amd-ags.patch
    patch -Np1 < ../game-patches-testing/valve-gnutls.patch
    patch -Np1 < ../game-patches-testing/valve-hide-prefix-update-window.patch
    patch -Np1 < ../game-patches-testing/valve-unity-mouse-pointer-drift.patch
    patch -Np1 < ../game-patches-testing/use_clock_monotonic.patch
    patch -Np1 < ../game-patches-testing/LAA-staging.patch
    patch -Np1 < ../game-patches-testing/proton-sdl-joystick.patch
    patch -Np1 < ../game-patches-testing/valve-proton-winebus.patch

    #this is necessary for vrclient
    patch -Np1 < ../game-patches-testing/valve-wined3d-d3d11.patch

    #WINE CUSTOM PATCHES
    #add your own custom patch lines below

    #end
    cd ..

