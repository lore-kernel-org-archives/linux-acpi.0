From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: ACPI git trees and vacation
Date: Mon, 7 Jul 2008 10:03:56 +1000
Message-ID: <20080707100356.fddcce73.sfr@canb.auug.org.au>
References: <48711391.6090608@firstfloor.org>
	<20080707095659.a1b486e1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__7_Jul_2008_10_03_56_+1000_Jx1O+Uu_mAKfNJlY"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080707095659.a1b486e1.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Mon__7_Jul_2008_10_03_56_+1000_Jx1O+Uu_mAKfNJlY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Mon, 7 Jul 2008 09:56:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Sun, 06 Jul 2008 20:48:49 +0200 Andi Kleen <andi@firstfloor.org> wrote:
> >
> > The trees for the next ACPI merge are at git.kernel.org now
> > These are based on Len's branches with some additional patches.
> >=20
> > (based on Linus' tree aka 2.6.26rc9)
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git rel=
ease
> > Intended for the 2.6.27 merge
>=20
> If that is true ..
>=20
> > git://git.kernel.org/pub/scm/git/linux/kernel/ak/linux-acpi-2.6.git test
>=20
> Then why is linux-next tracking that?

So maybe I read that wrong.  It appears that the release branch is
already a subset Linus' tree and you meant that comment ("Intended for
the 2.6.27 merge") was meant to apply to the test branch.  Right?

> > (based on Linux next for patches with dependencies)
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-next-acpi.git
>=20
> Is there something we can do about those dependencies?

This is still a valid question as I have been trying to push trivial
dependencies into Linus' tree ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_10_03_56_+1000_Jx1O+Uu_mAKfNJlY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxXWwACgkQjjKRsyhoI8xMKACgvGY/t0Pe4RrD70uPsIue230l
zkEAn1/uWc3d4m4ZD6wj7QIgC/CnHt6K
=e91t
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_10_03_56_+1000_Jx1O+Uu_mAKfNJlY--
