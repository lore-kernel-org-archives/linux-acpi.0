From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Mon, 16 Aug 2010 12:43:00 +1000
Message-ID: <20100816124300.e72258c9.sfr@canb.auug.org.au>
References: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
	<AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
	<20100815133015.883c7069.akpm@linux-foundation.org>
	<AANLkTi=Ok3NH3k5EF1Da2Z3xA7uahABRtH7pEdOEuZH2@mail.gmail.com>
	<20100815182153.994179c1.akpm@linux-foundation.org>
	<AANLkTinBAgk_Ay4vCcTxTEsq-uwn=RwQpTA6O86JXGCM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__16_Aug_2010_12_43_00_+1000_P0iKKu9weEjU4+8E"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinBAgk_Ay4vCcTxTEsq-uwn=RwQpTA6O86JXGCM@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, sedat.dilek@gmail.com, Andi Kleen <ak@linux.intel.com>, len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

--Signature=_Mon__16_Aug_2010_12_43_00_+1000_P0iKKu9weEjU4+8E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Aug 2010 18:35:22 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> It's that simple. It clearly never ever saw -next, because it _cannot_
> have seen next. That particular commit can never have compiled.

Yeah, it turned up in Len's tree that I fetch over the weekend.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__16_Aug_2010_12_43_00_+1000_P0iKKu9weEjU4+8E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMaKW0AAoJEDMEi1NhKgbspAYH/ixCgkYI1G1CgASPQ3vb6DdC
85OLIAuaCDlJmncf6+mr4I6fdo8Z+9g4QPL8MzE5NRSHAlYZgWUiOk1ZcPqIEX7q
WMYnnkdnTGTqbBO2m0CUqQKHvsZ2atDFT0YRqBLizf2Minz94UU0watdPLPjZdUR
ihycQ22rVB+NsCmOR3Ab8rqe2OKEaofS3w6v8YvlFgkSDoOcW1irAiz5P/FFeodZ
dtMnpwWlEMqtG6n6r128TFA+zRUue59snzTSy4IIoxZWEjqBzgFHzHjZn6Jjp9RT
eAVZrkUx8NP+B5YeT7Fc2aMLJzaq1b0NnXe55zFFb1nrz3+j+FUBvOwFhyfVH9w=
=Yac+
-----END PGP SIGNATURE-----

--Signature=_Mon__16_Aug_2010_12_43_00_+1000_P0iKKu9weEjU4+8E--
