From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Fri, 9 Jun 2017 23:51:32 +0200
Message-ID: <201706092351.32996@pali>
References: <cover.1495862272.git.dvhart@infradead.org> <201706072250.25953@pali> <67cc75c9e0ef4a21a168ab3b4dd1e727@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12380891.cyckeXfetz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67cc75c9e0ef4a21a168ab3b4dd1e727@ausx13mpc124.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@amacapital.net, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andriy.shevchenko@linux.intel.com, luto@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart12380891.cyckeXfetz
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 09 June 2017 17:46:12 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Wednesday, June 7, 2017 3:50 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: luto@amacapital.net; dvhart@infradead.org; platform-driver-
> > x86@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > luto@kernel.org; rjw@rjwysocki.net; linux-kernel@vger.kernel.org;
> > linux-acpi@vger.kernel.org Subject: Re: [PATCH 15/16]
> > platform/x86: wmi-mof: New driver to expose embedded WMI MOF
> > metadata
> >=20
> > On Wednesday 07 June 2017 22:23:08 Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > > > Sent: Wednesday, June 7, 2017 12:39 PM
> > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > Cc: luto@amacapital.net; dvhart@infradead.org; platform-driver-
> > > > x86@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > > > luto@kernel.org; rjw@rjwysocki.net;
> > > > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> > > > Subject: Re: [PATCH 15/16]
> > > > platform/x86: wmi-mof: New driver to expose embedded WMI MOF
> > > > metadata
> > > >=20
> > > > On Tuesday 06 June 2017 15:56:21 Pali Roh=C3=A1r wrote:
> > > > > On Tuesday 06 June 2017 13:46:16 Mario.Limonciello@dell.com
> > > > > wrote:
> > > > > > 2) On my system when you expand the arguments for "void
> > > > > > DoBFn" the source doesn't describe individual arguments
> > > > > > like you do. Again this might not matter to MOF parsing
> > > > > > tools but wanted to let you know in case it does.
> > > > >=20
> > > > > I know, this part is missing. Order of arguments are only in
> > > > > ID qualifier and not sorted + in/out de-duplicated.
> > > >=20
> > > > Implemented! Now arguments are correctly placed based on ID
> > > > qualifier.
> > >=20
> > > I think it's still off a little though.
> > >=20
> > > What I'm getting back now from bmf2mof is:
> > > 	void DoBFn([in, Description("Fn buf"), out] BDat Data);
> > >=20
> > > Whereas source puts Description as the last argument:
> > > 	void DoBFn([in, out, Description("Fn buf")] BDat Data);
> >=20
> > In BMOF from my Latitude E6440 there are specified two parameters
> > with index 0. One with qualifiers ("in", Description("Fn buf"))
> > and one with ("out", Description("Fn buf")). I think you have
> > similar/same data in BMOF.
> >=20
> > In my bmf2mof I just combined those two parameters into one (when
> > name, type and index matches) and concatenate also qualifiers with
> > removing duplicates.
> >=20
> > Do not know what is correct way, but I think qualifiers are just
> > unordered set. MS decompiler probably put "in" and "out" qualifiers
> > before any other for better readability.
>=20
> Have you tried to run it through mofcomp.exe and then decompile again
> with bmf2mof?  As long as it's coming out the same you're probably
> right.

Yes, bmf2mof+mofcomp.exe+bmf2mof gives same output as just bmf2mof.

> > > > > > source:
> > > > > > 	void DoBFn([in, out, Description("Fn buf")] BDat Data);
> > > > > >=20
> > > > > > bmf2mof:
> > > > > > 	void doBFn([in, Description("Fn buf"), ID(0)] BDat Data,
> > > > > > 	[out, Description("Fn buf"), ID(0)] BDat Data);
> > > >=20
> > > > --
> > > > Pali Roh=C3=A1r
> > > > pali.rohar@gmail.com
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart12380891.cyckeXfetz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk7GGQACgkQi/DJPQPkQ1IUrQCdHqU4uHacMAOz3oa/Z3s8hqez
7mMAn2icUy0Ub9iarxWFigepK7FsjV0q
=Nac4
-----END PGP SIGNATURE-----

--nextPart12380891.cyckeXfetz--
