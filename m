From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [intel/acpi] backlight - T61
Date: Fri, 28 Nov 2008 23:50:56 +0100
Message-ID: <1227912656.17845.5.camel@hidalgo>
References: <1227854824.3477.9.camel@hidalgo>
	 <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dSHya2Y1y9w4kp2ZXdBJ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:37828 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915AbYK1Wur (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Nov 2008 17:50:47 -0500
In-Reply-To: <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.sourceforge.net, jbarnes@virtuousgeek.org, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>


--=-dSHya2Y1y9w4kp2ZXdBJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On ven, 2008-11-28 at 14:18 -0500, Len Brown wrote:
> On Fri, 28 Nov 2008, Yves-Alexis Perez wrote:
>=20
> > I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> > Intel GM965. Under X, brightness keys work fine most of the time, but i=
n
> > some case it fails (for example after a dpms force off, but not always)=
.
> > Switching to console and back to X fix the problem for a time.
>=20
> How to you invoke DPMS?

xorg.conf:
Section "ServerFlags"
  Option  "StandbyTime" "0"
  Option  "SuspendTime" "0"
  Option  "OffTime"   "5"
EndSection
>=20
> I'm running the latest 2.6.28 on top of FC9, and I find that
> if I use the hot keys to dim the screen all the way,
> and then I'm idle for a period, the screen pretends to go black.
> (X foolishly paits the pixels black, but keeps the backlight on)
> Then when I touch the mouse to wake it up, my screen unlock
> prompt is at full brightness, and so is my screen when I unlock.
> So it seems that X forgot that I set the brightness.
> (though clicking the brightness hotkey shows the widget still
>  thinks I'm at minimum brightness, so that part remembered...)
>=20
> Now the backlight is totally screwed up.
> I use the hotkeys to get to minimum brightness,
> but something thinks I'm still at maximum brightness,
> because after some idle time, the screen all by itself
> goes bright.

Well I think that gnome-power-manager might be in your way, not sure.
>=20
> > Another weird stuff is that, in single user, I have no way to control
> > the backlight. Using brightness key doesn't work,
> > and /sys/class/backlight/acpi_video0 doesn't do anything.
>=20
> There are actually two text consoles -- CTRL-ALT-F1 while X is running
> and single-user mode.
>=20
> The hot keys have never worked for either of these modes.

Yes I know, that's why I'm asking here. They are not supposed to work
atm because OpRegion needs X support. What I was asking is if there was
something in cooking for that. But what puzzles me is that even
the /sys/class/backlight/acpi_video0 doesn't work.
>=20
> I would hope that X (i915) should be able to handle brightness
> in CTRL-ALT-F1 mode the same way that it does in GUI mode,
> but that doesn't seem to be working.
>=20
> Then there is single-user-mode, where X never ran
> and the i915 may not even be loaded...
>=20
> We used to have /sys/class/backlight and /proc/acpi/video
> available and they used to work in single-user mode
> (as well as in CTRL-ALT-F1) mode.  This was due to
> there being two video devices.  Unfortunately, we deleted
> the one what works in this scenario.
>=20
> Try this patch, which brings it back.

No, I don't want to revert those patches, they are there for a reason.
But yeah there is some console support missing, which may be working on.

Cheers,
--=20
Yves-Alexis

--=-dSHya2Y1y9w4kp2ZXdBJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkwdcsACgkQTUTAIMXAW65hcwCgtWWJUuOnEkEEf+cGxDqz3Xpd
npEAn1Z3TgVqR9o1HGUJcoFCP2th5V6C
=1xxS
-----END PGP SIGNATURE-----

--=-dSHya2Y1y9w4kp2ZXdBJ--
