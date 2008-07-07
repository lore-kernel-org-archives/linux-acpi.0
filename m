From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: ACPI git trees and vacation
Date: Mon, 7 Jul 2008 16:45:29 +1000
Message-ID: <20080707164529.8e42bd73.sfr@canb.auug.org.au>
References: <48711391.6090608@firstfloor.org>
	<20080707095659.a1b486e1.sfr@canb.auug.org.au>
	<4871B4FB.5020205@firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__7_Jul_2008_16_45_29_+1000_W90.tbRRoCiKKy/1"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4871B4FB.5020205@firstfloor.org>
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Mon__7_Jul_2008_16_45_29_+1000_W90.tbRRoCiKKy/1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Mon, 07 Jul 2008 08:17:31 +0200 Andi Kleen <andi@firstfloor.org> wrote:
>
> Stephen Rothwell wrote:
> >=20
> > On Sun, 06 Jul 2008 20:48:49 +0200 Andi Kleen <andi@firstfloor.org> wro=
te:
> >> The trees for the next ACPI merge are at git.kernel.org now
> >> These are based on Len's branches with some additional patches.
> >>
> >> (based on Linus' tree aka 2.6.26rc9)
> >> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git re=
lease
> >> Intended for the 2.6.27 merge
> >=20
> > If that is true ..
> >=20
> >> git://git.kernel.org/pub/scm/git/linux/kernel/ak/linux-acpi-2.6.git te=
st
> >=20
> > Then why is linux-next tracking that?
>=20
> It is tracking Len's tree not mine, right?

/me hits himself in the head :-)

Sorry about that.

> Or did you switch already to mine?

No, I only do what is asked of me :-)

Time I got my glasses replaced :-)

> > Is there something we can do about those dependencies?
>=20
> It's some patches from Henrique that require rfkill changes
> in the net tree. I'm also not happy about that (it complicates
> everything here), but cannot do much about it.

OK,  yeah that is a pain.

> > So what is missing, and why should we merge stuff in 2.6.27 that we don=
't
> > see until the merge window?  (Not trying to be antagonistic, just asking
> > about procedure and wondering why stuff for 2.6.27 is still not in
> > linux-next.)
>=20
> Because they're small fixes and would go in later anyways.
>=20
> And because I haven't gone through all of them yet due to time
> reasons, but I cannot say categorically I'll delay them all.

OK.  This is all not so relevant since I misread above.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_16_45_29_+1000_W90.tbRRoCiKKy/1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxu4kACgkQjjKRsyhoI8xx/gCfX8eYJfpoKveay9/+gpJBqZ/p
4eIAn2F5li58gWXOGMuBVby/mgOkCIwJ
=x765
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_16_45_29_+1000_W90.tbRRoCiKKy/1--
