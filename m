From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Wed, 7 Jun 2017 22:50:25 +0200
Message-ID: <201706072250.25953@pali>
References: <cover.1495862272.git.dvhart@infradead.org> <201706071939.25681@pali> <bc0dbbfcb0084f758d28b9000fa9f9e0@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13373760.eSfPYzL9aO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc0dbbfcb0084f758d28b9000fa9f9e0@ausx13mpc124.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@amacapital.net, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andriy.shevchenko@linux.intel.com, luto@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart13373760.eSfPYzL9aO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 June 2017 22:23:08 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Wednesday, June 7, 2017 12:39 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: luto@amacapital.net; dvhart@infradead.org; platform-driver-
> > x86@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > luto@kernel.org; rjw@rjwysocki.net; linux-kernel@vger.kernel.org;
> > linux-acpi@vger.kernel.org Subject: Re: [PATCH 15/16]
> > platform/x86: wmi-mof: New driver to expose embedded WMI MOF
> > metadata
> >=20
> > On Tuesday 06 June 2017 15:56:21 Pali Roh=C3=A1r wrote:
> > > On Tuesday 06 June 2017 13:46:16 Mario.Limonciello@dell.com wrote:
> > > > 2) On my system when you expand the arguments for "void DoBFn"
> > > > the source doesn't describe individual arguments like you do.
> > > > Again this might not matter to MOF parsing tools but wanted to
> > > > let you know in case it does.
> > >=20
> > > I know, this part is missing. Order of arguments are only in ID
> > > qualifier and not sorted + in/out de-duplicated.
> >=20
> > Implemented! Now arguments are correctly placed based on ID
> > qualifier.
>=20
> I think it's still off a little though.
>=20
> What I'm getting back now from bmf2mof is:
> 	void DoBFn([in, Description("Fn buf"), out] BDat Data);
>=20
> Whereas source puts Description as the last argument:
> 	void DoBFn([in, out, Description("Fn buf")] BDat Data);

In BMOF from my Latitude E6440 there are specified two parameters with=20
index 0. One with qualifiers ("in", Description("Fn buf")) and one with=20
("out", Description("Fn buf")). I think you have similar/same data in=20
BMOF.

In my bmf2mof I just combined those two parameters into one (when name,=20
type and index matches) and concatenate also qualifiers with removing=20
duplicates.

Do not know what is correct way, but I think qualifiers are just=20
unordered set. MS decompiler probably put "in" and "out" qualifiers=20
before any other for better readability.

> > > > source:
> > > > 	void DoBFn([in, out, Description("Fn buf")] BDat Data);
> > > >=20
> > > > bmf2mof:
> > > > 	void doBFn([in, Description("Fn buf"), ID(0)] BDat Data, [out,
> > > > 	Description("Fn buf"), ID(0)] BDat Data);
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart13373760.eSfPYzL9aO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk4ZxEACgkQi/DJPQPkQ1KoNgCgnkpE0iqdhdvgE0K8Fie/Lqy3
s60AnjxLxkon9s9cM11T89/dUfzoDtEK
=KDLr
-----END PGP SIGNATURE-----

--nextPart13373760.eSfPYzL9aO--
