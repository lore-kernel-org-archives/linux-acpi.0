From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Sun, 18 Dec 2011 11:59:13 +0100
Message-ID: <6900186.lBeFrD3GRB@pali-elitebook>
References: <3123346.jTQFjj4kVk@pali-elitebook> <1323442149.20114.93.camel@linux-s257.site> <3404497.1txogKB5v8@pali-elitebook>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1736533.BRSnUUAxKP"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <3404497.1txogKB5v8@pali-elitebook>
Sender: platform-driver-x86-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--nextPart1736533.BRSnUUAxKP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday 09 December 2011 16:46:29 Pali Roh=C3=A1r wrote:
> On Friday 09 December 2011 22:49:09 joeyli wrote:
> > Hi Pali,
> >=20
> > =E6=96=BC =E4=BA=94=EF=BC=8C2011-12-09 =E6=96=BC 22:36 +0800=EF=BC=8C=
Li Joey =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > ---------- Forwarded message ----------
> > > From: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > Date: 2011/7/15
> > > Subject: Brightness on HP EliteBook 8460p
> > > To: linux-acpi@vger.kernel.org
> > >=20
> > >=20
> > > Hello,
> > >=20
> > > on my HP EliteBook 8460p is not possible to set display brightnes=
s
> > > when ACPI
> > > is enabled in kernel. Entries in sysfs is properly created withou=
t
> > > errors. But
> > > when I try write any value
> > > to /sys/class/backlight/acpi_video0/brightness
> > > nothing happened (and no error is in dmesg). When I press Fn key =
for
> > > chaining
> > > display brightness kernel send correct key event (tested with xev=
)
> > > but
> > > nothing
> > > happened too.
> > >=20
> > > When I disabled ACPI (acpi=3Doff in kernel command line) all Fn k=
eys
> > > are
> > > broken
> > > and not working (no events in xev). But brightness keys working (=
I
> > > think on HW
> > > level, because xev does not see it) - increase and decrease displ=
ay
> > > brightness.
> > >=20
> > > So what can I do with my notebook? I think that there is error/bu=
g
> > > in
> > > BIOS or
> > > ACPI because with disabled ACPI brightness working. But with
> > > disabled
> > > ACPI is
> > > notebook unuseable (no battery info, no Fn keys, no WIFI rfkill,
> > > ...).
> > > Can
> > > somebody help me with this problem?
> > >=20
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >=20
> > You can try to put kernel parameter:
> > =09acpi_osi=3D"!Windows 2009"
> >=20
> > to /boot/grub/menu.lst, then reboot look at maybe better.
> >=20
> > And,
> > could you please kindly share DSDT and dmidecode to me?
> >=20
> > Plesae login by root then:
> > =09% acpidump > acpidump.dat
> > =09% dmidecode > dmidecode.log
> >=20
> > Thanks a lot!
> > Joey Lee
>=20
> Hello,
>=20
> adding any acpi_osi values did not changed anything (also tried other=
 osi
> strings from decompiled DSDT table). Brightness problem is in both BI=
OS and
> UEFI boot mode.
>=20
> I attached acpidump and dmidecode output from bios and uefi mode too.=


Did you find way how to control display brightness?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart1736533.BRSnUUAxKP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk7tx4EACgkQi/DJPQPkQ1JdZACbBD+Ced6qxNUSJy1PtB65lJVN
jYoAoJN67NoT+LvvpEgmkxqFY0o7QtLn
=MA7C
-----END PGP SIGNATURE-----

--nextPart1736533.BRSnUUAxKP--
