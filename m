From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: acpi tree build failure
Date: Mon, 7 Sep 2009 23:46:12 +1000
Message-ID: <20090907234612.078bb650.sfr@canb.auug.org.au>
References: <20090901125748.fb33b2ea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__7_Sep_2009_23_46_12_+1000_uwDRFl0FO9wdFu.Z"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753357AbZIGNqS@vger.kernel.org>
In-Reply-To: <20090901125748.fb33b2ea.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Mon__7_Sep_2009_23_46_12_+1000_uwDRFl0FO9wdFu.Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Tue, 1 Sep 2009 12:57:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next build (x86_64 allmodconfig) failed like this:
>=20
> drivers/acpi/als.c: In function 'acpi_als_get_mappings':
> drivers/acpi/als.c:173: error: expected ')' before 'PREFIX'
> drivers/acpi/als.c: In function 'acpi_als_add':
> drivers/acpi/als.c:347: error: expected ')' before 'PREFIX'
>=20
> I have used the version of the acpi tree from next-20090831 for today.

This is still there ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Sep_2009_23_46_12_+1000_uwDRFl0FO9wdFu.Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqlDqQACgkQjjKRsyhoI8zmWwCeLP7SHdPhmL5wXiAmckS1pqmL
b00AoIXmUtD0/Lk8Y93ki4RAkNW0Wode
=ZjjG
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Sep_2009_23_46_12_+1000_uwDRFl0FO9wdFu.Z--
