From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Tue, 6 Jun 2017 00:19:26 +0200
Message-ID: <201706060019.26462@pali>
References: <cover.1495862272.git.dvhart@infradead.org> <201705271314.16241@pali> <20170605221456.GA27270@fury>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9791196.xGt1QBGLj1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170605221456.GA27270@fury>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart9791196.xGt1QBGLj1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 June 2017 00:14:56 Darren Hart wrote:
> On Sat, May 27, 2017 at 01:14:15PM +0200, Pali Roh=C3=A1r wrote:
> > > metadata. I think that Samba has tools to interpret it, but there
> > > is currently no interface to get the data in the first place.
> >=20
> > No, there is no non-ms-windows tool for interpreting those binary
> > MOF (BMF) data yet.
>=20
> Good point. Updated.

You are too late :-) Now there is my at https://github.com/pali/bmfdec=20
See my email "Binary MOF buffer in WMI is finally decoded!".

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9791196.xGt1QBGLj1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk12O4ACgkQi/DJPQPkQ1Ll1wCgsyE25YLcJQqLx5ec3km4qVsJ
kJsAnReTEdZ6yj1C9flmgsVhL/thdojl
=Zuov
-----END PGP SIGNATURE-----

--nextPart9791196.xGt1QBGLj1--
