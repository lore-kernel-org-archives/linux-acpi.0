From: joeyli <jlee@suse.com>
Subject: Re: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen
 stays off [3.2-rc4+]
Date: Mon, 05 Dec 2011 11:00:41 +0800
Message-ID: <1323054041.6046.79.camel@linux-s257.site>
References: <20111204160728.GA27292@archminux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:59666 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab1LEDEP (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Sun, 4 Dec 2011 22:04:15 -0500
In-Reply-To: <20111204160728.GA27292@archminux>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baptiste Jonglez <baptiste@jonglez.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org

Add Cc. to platform-driver-x86 and linux-acpi

Hi Baptiste

=E6=96=BC =E6=97=A5=EF=BC=8C2011-12-04 =E6=96=BC 17:07 +0100=EF=BC=8CBa=
ptiste Jonglez =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
> I've got a lot of troubles with a dual-LVDS Acer laptop (it doesn't
> have a keyboard, but two displays with touchscreens)
>=20
> The Intel GPU is integrated into the Core i5-480M CPU: it's a bit
> older than Sandybridge, as it seems to be based on the Arrandale
> micro-architecture.
>=20
> In the BIOS, both displays work fine; but as soon as the kernel boots
> up, the second display (i.e. the one where you usually find a
> keyboard) is turned off. The main display works as expected.
>=20
> xrandr reports two LVDS displays: LVDS1, which is connected, and
> LVDS2, which is marked as "disconnected". No matter what I tried, I
> can't bring that second display up.
>=20
> During the boot, just after the drm is set up, the following message
> shows up:
>=20
>   [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM func=
tions
>=20
> (attached is the relevant part of dmesg [1])
>=20
>=20

Have no idea for this _DSM error, need help from drm and acpi experts.

>=20
> I then tried booting with "video=3DLVDS-2:e". The same message shows =
up
> while booting, with these two following:
>=20
>   [drm:drm_crtc_helper_set_config] *ERROR* failed to set mode on [CRT=
C:4]
>   fbcon_init: detected unhandled fb_set_par error, error code -22
>=20
> (attached is the relevant part of dmesg [2])
>=20
> With that kernel command line forcing LVDS2, the
> "drm_crtc_helper_set_config" error shows up each time I switch tty;
> additionally, X does not want to start anymore (spewing out the
> aforementioned error multiple times before giving up)
>=20
>=20
> I'm currently using the latest 3.2 kernel from linus' tree
> (af968e29acd91ebeb4224e899202c46c93171ecd), but the behavior was
> similar with a vanilla 3.1.2.
>=20
>=20
> Other notes about this issue:
>=20
>  - with an Ubuntu 2.6.35 kernel, the second display is on but
>    flickering (with the picture distorted like an old analog TV...).
>    The main display is working fine, as always.
>=20
>  - with an Archlinux 2.6.37.5 kernel, the behavior is the same as wit=
h
>    3.2, the main display is ok and the second one is off.
>=20
>  - I did succeed, only once and out of pure luck, to get the second
>    screen to work with the 3.1.2 kernel. I haven't been able to
>    reproduce that... I had booted with "video=3DLVDS-2:e" and let the
>    laptop running ; pressing a key a few hours later turned back
>    *both* displays on (the main display had been turned off by DPMS,
>    and the second, well, was off from the start, as always)
>    While not very helpful, it shows that it's definitely possible.
>=20

What does Windows platform's behavior? Does there have any physical key
that can turn on/off the second LVDS on Windows?

>  - there are a some unhandled WMI events logged from the acer-wmi
>    module [3] when closing the lid, opening it, and most importantly,
>    when the (main) screen is turned on or off by DPMS.
>=20

I will look at your dsdt and log from acer-wmi then try to improve
acer-wmi.

>=20
>=20
> What do you think? I haven't really succeeded in nailing the source o=
f
> the issue down, but here are a few possibilities I'm thinking of:
>=20
>  - the driver is not aware it can drive two LVDS displays (not very
>    likely, and it has worked once, see above)
>=20
>  - there is some kind of switch that is able to turn the second scree=
n
>    on or off (I'm thinking of something like rfkill). If so, it looks
>    like something non-standard and undocumented. This would explain
>    the WMI events (see the last note above)
>=20

What's the behavior of Windows?

>  - buggy ACPI implementation. I tried to extract then recompile the
>    DSDT [4], and iasl spews out 17 errors and 12 warnings. Also worth
>    noticing is that line in dmesg:
> "pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control ma=
sk: 0x1d"
>=20
>=20
> The Archlinux userland is:
>  - libdrm 2.4.27
>  - xorg-server 1.11.2
>  - intel-dri 7.11.1
>  - xf86-video-intel 2.17.0
>=20
>=20
> Please let me know if there are any other details I should provide.
> Regards,
> Baptiste
>=20
> Attachments:
> [1] dmesg-DSM-functions.log - drm errors when booting normally
> [2] dmesg-video-lvds2.log - drm errors when forcing LVDS2 on the cmdl=
ine
> [3] acer_wmi.log - WMI events that land in dmesg
> [4] dsdt - /sys/firmware/acpi/tables/DSDT

Please also attached on dmidecode log.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
