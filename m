From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Fri, 03 Feb 2012 16:24:41 +0100
Message-ID: <2560725.o9gzJOnNC7@pali>
References: <3123346.jTQFjj4kVk@pali-elitebook> <1327030139.15960.84.camel@linux-s257.site> <2085914.rvJjIXUC3h@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1342636.kuLzqCoOp4"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <2085914.rvJjIXUC3h@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--nextPart1342636.kuLzqCoOp4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday 20 January 2012 17:55:57 Pali Roh=C3=A1r wrote:
> On Friday 20 January 2012 11:28:59 joeyli wrote:
> > =E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 11:12 +0800=EF=BC=8C=
joeyli =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Pali,
> > >=20
> > > Sorry for I am late reply you.
> > >=20
> > > =E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 +0100=EF=BC=
=8CPali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > On Wednesday 21 December 2011 12:45:07 Pali Roh=C3=A1r wrote:
> > > > > Hello,
> > > > >=20
> > > > > I tried to boot with all 3 strings in acpi_os_name, but nothi=
ng was
> > > > > changed. I'm attaching dmesg outputs, one from BIOS mode, one=
 from
> > > > > UEFI mode. Both are with "Microsoft Windows NT".
> > > >=20
> > > > Did you looked at my logs?
> > >=20
> > > I checked your dmesg log, found the acpi_os_name kernel parameter=
 is :
> > >=20
> > > [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.0-4-generi=
c
> > > root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro pcie_aspm=3D=
force
> > > acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF "acpi_os_nam=
e=3DMicrosoft
> > > Windows NT" splash vt.handoff=3D7
> > >=20
> > > We still need by-pass the os name check in DSDT when test functio=
n key,
> > >=20
> > > please help to feed:
> > > =09acpi_os_name=3D"Windows 2009"
> > >=20
> > > And,
> > > looks like the acpi debug level not enough, please kindly change =
acpi
> > >=20
> > > debug parameter to:
> > > =09acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_l=
en=3D5M
> > >=20
> > > summary:
> > > =09acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_l=
en=3D5M
> > > =09acpi_os_name=3D"Windows 2009"
> >=20
> > Forgot remind,
> > please remember press brightness function key a couple of times bef=
ore
> > you dump the dmesg and messages log.
> >=20
> >=20
> > Thanks a lot!
> > Joey Lee
>=20
> Hello,
>=20
> there was no acpi log, so I recompiled ubuntu kernel with
> CONFIG_ACPI_DEBUG=3Dy and CONFIG_ACPI_DEBUG_FUNC_TRACE. Then I starte=
d kernel
> with your params.
>=20
> Now I'm attaching very long debug output. I belive it will be now use=
full.
>=20
> Pressing brightness keys did not show anything in log.
>=20
> After writing 0 to /sys/class/backlight/acpi_video0/brightness in log=

> appear: [   57.675070] [ACPI Debug]  Integer 0x000000000000000B
> ...
>=20
> And after writing 10:
> [   99.865208] [ACPI Debug]  Integer 0x0000000000000048
> [   99.865295]   evmisc-0120 [4294967289] ev_queue_notify_reques:
> Dispatching Notify on [DGFX] Node ffff880136246c80 Value 0xD0 (**Devi=
ce
> Specific**) [   99.865350]    video-1474 [4294967289] video_bus_notif=
y    =20
> : Unsupported event [0xd0]

Do you need more logs? Or is this enought?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart1342636.kuLzqCoOp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk8r/DkACgkQi/DJPQPkQ1KsbgCgnqhyuGTyxcRSELBEGemxRtCe
/ygAn1voQ7b7sjq2YZB20btfwYdLOAbh
=VrYp
-----END PGP SIGNATURE-----

--nextPart1342636.kuLzqCoOp4--
