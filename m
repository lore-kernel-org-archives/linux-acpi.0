From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: acpi tree build failure
Date: Wed, 18 Mar 2009 14:27:38 +1100
Message-ID: <20090318142738.ae6eda7e.sfr@canb.auug.org.au>
References: <20090318115713.bafedc37.sfr@canb.auug.org.au>
	<1237338541.29562.5.camel@minggr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__18_Mar_2009_14_27_38_+1100_fQ56=2bvcZ9xbEeE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:38349 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbZCRD1s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Mar 2009 23:27:48 -0400
In-Reply-To: <1237338541.29562.5.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--Signature=_Wed__18_Mar_2009_14_27_38_+1100_fQ56=2bvcZ9xbEeE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lin,

On Wed, 18 Mar 2009 09:09:01 +0800 Lin Ming <ming.m.lin@intel.com> wrote:
>
> Please try below patch,
>=20
>=20
>     ACPI: cpufreq: use new bit register access function
>    =20
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>

That fixes the build problem - I tested it on top of just today's acpi
test branch (which is what goes into linux-next).  I don't have the
hardware ...

Compile-tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Mar_2009_14_27_38_+1100_fQ56=2bvcZ9xbEeE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknAaioACgkQjjKRsyhoI8zvfACcCFm02pUQv97qwVVUF+1cXLyf
Y1AAnRUA7YfKIxnHP0y7+a55mMKPkGa6
=+Btf
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Mar_2009_14_27_38_+1100_fQ56=2bvcZ9xbEeE--
