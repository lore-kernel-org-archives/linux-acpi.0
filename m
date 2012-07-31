From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 31 Jul 2012 18:03:02 +0200
Message-ID: <5231555.Ogc4s2l7Ug@pali>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com> <3502295.b9B3oqyYO6@pali> <CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13307415.JfdXA8UGtd"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Artur Flinta <aflinta@gmail.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, joeyli <jlee@suse.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: linux-acpi@vger.kernel.org


--nextPart13307415.JfdXA8UGtd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday 31 July 2012 17:49:32 Luca Tettamanti wrote:
> I'm putting back the CC and adding Alex.
>=20
> On Tue, Jul 31, 2012 at 5:07 PM, Pali Roh=C3=A1r=20
<pali.rohar@gmail.com> wrote:
> > Thanks, now working. When I write to acpi video brightness
> > file it change brightness and in dmesg is:
> >=20
> > [   47.200998] [drm:radeon_atif_handler], event, device_class
> > =3D video, type =3D 0xd0
> > [   47.201102] [drm:radeon_atif_get_sbios_requests], SBIOS
> > pending requests: 0x80
> > [   47.201104] [drm:radeon_atif_handler], ATIF: 1 pending
> > SBIOS requests
> > [   47.201105] [drm:radeon_atif_handler], Changing brightness
> > to 11
>=20
> Great! I'll send an updated patch to Alex soon.
>=20
> > I think that acpi only sent event about brightness key
> > pressed, because nothing happened when I pressed it.
> >=20
> > Also for windows is needed special HP application (hp hotkey)
> > for brightness keys. Without it brightness keys not working
> > too...
> I've looked at hp-wmi: the hotkey is indeed dispatched via WMI
> (hp-wmi) so you need something in userspace (KDE, Gnome, etc)
> to respond to that key press.
>=20

No, when I rmmod hp-wmi brightness keys still generate events.=20
And when I disable acpi then brightness keys do not generate=20
events but adjust brightness automatically (by BIOS).

I think that hp-wmi on my notebook only handle bluetooth & wifi=20
rfkills and ALS switch. All button working without hp-wmi too.

> > And there is one problem with /sys/class/backlight/radeon_bl.
> > When I enable Ambient Light Sensor which auto adjust
> > brightness based on sensor data, writing value 0 (min) or
> > 255 (max) to /sys/class/backlight/radeon_bl/brightness turn
> > off display.
> Ok, that's weird. 0 turns off the panel by design, 255 should
> not...

But when ALS is disabled 0 did not turn display off.

> > All
> > other values (1-254) are OK (adjust brightness level). When I
> > turn off Ambient Light Sensor (via hp-wmi kernel module) then
> > values 0 and 255 also set brightness level (min and max). My
> > suggestion is to convert value 0 to 1 and 255 to 254 to
> > prevent this problem.
>=20
> No idea what's going on here... might be some weird vendor
> magic. The WMI code is rather obscure...
>=20
> Luca

ACPI/WMI cannot change brightness, see this what doing that ALS=20
function: http://lists.freedesktop.org/archives/dri-devel/2012-
March/020416.html

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart13307415.JfdXA8UGtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlAYAbYACgkQi/DJPQPkQ1KE+QCglgol8CbTkOb2gksfHnK5I4qk
XtwAoJkNRp6WU5IqwIn8B92FtbKacyz6
=eC0b
-----END PGP SIGNATURE-----

--nextPart13307415.JfdXA8UGtd--
