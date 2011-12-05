From: Baptiste Jonglez <baptiste@jonglez.org>
Subject: [BUG] i915/intel-acpi.c: failed to get supported _DSM functions
 (was: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen stays off)
Date: Mon, 5 Dec 2011 21:56:47 +0100
Message-ID: <20111205205647.GA1757@archminux>
References: <20111204160728.GA27292@archminux>
 <1323054041.6046.79.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323054041.6046.79.camel@linux-s257.site>
Sender: linux-kernel-owner@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
Cc: joeyli <jlee@suse.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

CC-ing intel-gfx@lists.freedesktop.org (see below)

On Mon, Dec 05, 2011 at 11:00:41AM +0800, joeyli wrote:
> Add Cc. to platform-driver-x86 and linux-acpi
>=20
> Hi Baptiste
>=20
> =E6=96=BC =E6=97=A5=EF=BC=8C2011-12-04 =E6=96=BC 17:07 +0100=EF=BC=8C=
Baptiste Jonglez =E6=8F=90=E5=88=B0=EF=BC=9A
> > Hi,
> >=20
> > I've got a lot of troubles with a dual-LVDS Acer laptop (it doesn't
> > have a keyboard, but two displays with touchscreens)
> >=20
> > The Intel GPU is integrated into the Core i5-480M CPU: it's a bit
> > older than Sandybridge, as it seems to be based on the Arrandale
> > micro-architecture.
> >=20
> > In the BIOS, both displays work fine; but as soon as the kernel boo=
ts
> > up, the second display (i.e. the one where you usually find a
> > keyboard) is turned off. The main display works as expected.
> >=20
> > xrandr reports two LVDS displays: LVDS1, which is connected, and
> > LVDS2, which is marked as "disconnected". No matter what I tried, I
> > can't bring that second display up.
> >=20
> > During the boot, just after the drm is set up, the following messag=
e
> > shows up:
> >=20
> >   [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM fu=
nctions
> >=20
> > (attached is the relevant part of dmesg [1])
> >=20
> >=20
>=20
> Have no idea for this _DSM error, need help from drm and acpi experts=
=2E

It definitely looks like an ACPI issue.
That function is defined in `drivers/gpu/drm/i915/intel_acpi.c'.
The whole file was added more than a year ago by commit 723bfd707a97
(see the relevant thread on intel-gfx@ [1]) to "add _DSM support".
One of the first comment is about "Calpella", which is exactly the
platform of my laptop (as shown by lshw)

However, I honestly don't know what is wrong with that code...
Is there anything I can provide to sort things out?

> > I then tried booting with "video=3DLVDS-2:e". The same message show=
s up
> > while booting, with these two following:
> >=20
> >   [drm:drm_crtc_helper_set_config] *ERROR* failed to set mode on [C=
RTC:4]
> >   fbcon_init: detected unhandled fb_set_par error, error code -22
> >=20
> > (attached is the relevant part of dmesg [2])
> >=20
> > With that kernel command line forcing LVDS2, the
> > "drm_crtc_helper_set_config" error shows up each time I switch tty;
> > additionally, X does not want to start anymore (spewing out the
> > aforementioned error multiple times before giving up)
> >=20
> >=20
> > I'm currently using the latest 3.2 kernel from linus' tree
> > (af968e29acd91ebeb4224e899202c46c93171ecd), but the behavior was
> > similar with a vanilla 3.1.2.
> >=20
> >=20
> > Other notes about this issue:
> >=20
> >  - with an Ubuntu 2.6.35 kernel, the second display is on but
> >    flickering (with the picture distorted like an old analog TV...)=
=2E
> >    The main display is working fine, as always.

I just bumped on bug report #29821 on freedesktop.org [2] which dates
the "flicker" bug around 2.6.35. I guess the ubuntu kernel doesn't
have the fix (and actually, the fix might be responsible for the lack
of output on the second display with later kernels.)

I'll try with an older kernel to see what it does.

> >  - with an Archlinux 2.6.37.5 kernel, the behavior is the same as w=
ith
> >    3.2, the main display is ok and the second one is off.
> >=20
> >  - I did succeed, only once and out of pure luck, to get the second
> >    screen to work with the 3.1.2 kernel. I haven't been able to
> >    reproduce that... I had booted with "video=3DLVDS-2:e" and let t=
he
> >    laptop running ; pressing a key a few hours later turned back
> >    *both* displays on (the main display had been turned off by DPMS=
,
> >    and the second, well, was off from the start, as always)
> >    While not very helpful, it shows that it's definitely possible.
> >=20
>=20
> What does Windows platform's behavior? Does there have any physical k=
ey
> that can turn on/off the second LVDS on Windows?

Actually, the first thing I did was wiping Windows out :)
=46rom what I've seen, both screens seem to work out-of-the-box on
Windows.

There are only two physical keys:
 - power-on button
 - "keyboard"-labeled button, which seems to do nothing
   hardware-related; it triggers an event caught up by acer_wmi.
   I think all it does is telling the OS: "hey, pull up the software
   virtual keyboard on the second display".

> >  - there are a some unhandled WMI events logged from the acer-wmi
> >    module [3] when closing the lid, opening it, and most importantl=
y,
> >    when the (main) screen is turned on or off by DPMS.
> >=20
>=20
> I will look at your dsdt and log from acer-wmi then try to improve
> acer-wmi.

Thanks a lot!

> > What do you think? I haven't really succeeded in nailing the source=
 of
> > the issue down, but here are a few possibilities I'm thinking of:
> >=20
> >  - the driver is not aware it can drive two LVDS displays (not very
> >    likely, and it has worked once, see above)
> >=20
> >  - there is some kind of switch that is able to turn the second scr=
een
> >    on or off (I'm thinking of something like rfkill). If so, it loo=
ks
> >    like something non-standard and undocumented. This would explain
> >    the WMI events (see the last note above)
> >=20
>=20
> What's the behavior of Windows?

I meant an internal switch that would be controlled by GPIO or
such. It doesn't seem very likely though...

> >  - buggy ACPI implementation. I tried to extract then recompile the
> >    DSDT [4], and iasl spews out 17 errors and 12 warnings. Also wor=
th
> >    noticing is that line in dmesg:
> > "pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control =
mask: 0x1d"
> >=20
> >=20
> > The Archlinux userland is:
> >  - libdrm 2.4.27
> >  - xorg-server 1.11.2
> >  - intel-dri 7.11.1
> >  - xf86-video-intel 2.17.0
> >=20
> >=20
> > Please let me know if there are any other details I should provide.
> > Regards,
> > Baptiste
> >=20
> > Attachments:
> > [1] dmesg-DSM-functions.log - drm errors when booting normally
> > [2] dmesg-video-lvds2.log - drm errors when forcing LVDS2 on the cm=
dline
> > [3] acer_wmi.log - WMI events that land in dmesg
> > [4] dsdt - /sys/firmware/acpi/tables/DSDT
>=20
> Please also attached on dmidecode log.

See [3] for dmidecode, I've also provided the dsdt [4] again.
Here is also everything related to ACPI in dmesg [5].

> Thank's a lot!
> Joey Lee

Let me know if there's anything else I can provide,
Baptiste

[1] http://lists.freedesktop.org/archives/intel-gfx/2010-October/008339=
=2Ehtml
[2] https://bugs.freedesktop.org/show_bug.cgi?id=3D29821
[3] http://zorun.tonbnc.fr/lkml/dmidecode
[4] http://zorun.tonbnc.fr/lkml/dsdt
[5] http://zorn.tonbnc.fr/lkml/dmesg-acpi.log
