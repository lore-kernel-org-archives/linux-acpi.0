From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Wed, 01 Aug 2012 09:38:27 +0200
Message-ID: <2105592.V6dJ8dm1bk@pali>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com> <5231555.Ogc4s2l7Ug@pali> <CADnq5_OszT7MkTOYNuABbNtg2Fvd7hGddrWLNAukmCXyKVh3Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3296252.jWDco5J21p"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46768 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664Ab2HAHic (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2012 03:38:32 -0400
In-Reply-To: <CADnq5_OszT7MkTOYNuABbNtg2Fvd7hGddrWLNAukmCXyKVh3Ow@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Artur Flinta <aflinta@gmail.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, joeyli <jlee@suse.com>


--nextPart3296252.jWDco5J21p
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday 31 July 2012 12:17:05 Alex Deucher wrote:
> On Tue, Jul 31, 2012 at 12:03 PM, Pali Roh=C3=A1r=20
<pali.rohar@gmail.com> wrote:
> > On Tuesday 31 July 2012 17:49:32 Luca Tettamanti wrote:
> >> I'm putting back the CC and adding Alex.
> >>=20
> >> On Tue, Jul 31, 2012 at 5:07 PM, Pali Roh=C3=A1r
> >=20
> > <pali.rohar@gmail.com> wrote:
> >> > Thanks, now working. When I write to acpi video brightness
> >> > file it change brightness and in dmesg is:
> >> >=20
> >> > [   47.200998] [drm:radeon_atif_handler], event,
> >> > device_class
> >> > =3D video, type =3D 0xd0
> >> > [   47.201102] [drm:radeon_atif_get_sbios_requests], SBIOS
> >> > pending requests: 0x80
> >> > [   47.201104] [drm:radeon_atif_handler], ATIF: 1 pending
> >> > SBIOS requests
> >> > [   47.201105] [drm:radeon_atif_handler], Changing
> >> > brightness
> >> > to 11
> >>=20
> >> Great! I'll send an updated patch to Alex soon.
> >>=20
> >> > I think that acpi only sent event about brightness key
> >> > pressed, because nothing happened when I pressed it.
> >> >=20
> >> > Also for windows is needed special HP application (hp
> >> > hotkey)
> >> > for brightness keys. Without it brightness keys not
> >> > working
> >> > too...
> >>=20
> >> I've looked at hp-wmi: the hotkey is indeed dispatched via
> >> WMI
> >> (hp-wmi) so you need something in userspace (KDE, Gnome,
> >> etc)
> >> to respond to that key press.
> >=20
> > No, when I rmmod hp-wmi brightness keys still generate
> > events.
> > And when I disable acpi then brightness keys do not generate
> > events but adjust brightness automatically (by BIOS).
> >=20
> > I think that hp-wmi on my notebook only handle bluetooth &
> > wifi rfkills and ALS switch. All button working without
> > hp-wmi too.>=20
> >> > And there is one problem with
> >> > /sys/class/backlight/radeon_bl.
> >> > When I enable Ambient Light Sensor which auto adjust
> >> > brightness based on sensor data, writing value 0 (min) or
> >> > 255 (max) to /sys/class/backlight/radeon_bl/brightness
> >> > turn
> >> > off display.
> >>=20
> >> Ok, that's weird. 0 turns off the panel by design, 255
> >> should
> >> not...
> >=20
> > But when ALS is disabled 0 did not turn display off.
>=20
> 0 only turns off the backlight, not the panel itself.  Is the
> backlight still partially on or is it just the actual panel
> (timing and image)?
>=20
> Alex

I looked at display again and 0 only turn backlight off (or=20
adjust minimum value). If I look at display correctly (in dark=20
room) I can recognize that display is still on and I can see=20
window manager decorations (but text is not readable).

Value 255 when ALS is on has same effect as 0 - adjust minimum=20
value (instead maximum).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart3296252.jWDco5J21p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlAY3PMACgkQi/DJPQPkQ1J+SACdErP1LPylYcSiX/vLmJk84KiV
fKcAnAlUkBeF9t+PsBEiIAqCMDj6QzlF
=0+Af
-----END PGP SIGNATURE-----

--nextPart3296252.jWDco5J21p--

