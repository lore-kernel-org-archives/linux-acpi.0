From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: ACPI git trees and vacation
Date: Mon, 7 Jul 2008 09:56:59 +1000
Message-ID: <20080707095659.a1b486e1.sfr@canb.auug.org.au>
References: <48711391.6090608@firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__7_Jul_2008_09_56_59_+1000_=wuBq9qRdXurDYdl"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <48711391.6090608@firstfloor.org>
Sender: linux-next-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, linux-next@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Mon__7_Jul_2008_09_56_59_+1000_=wuBq9qRdXurDYdl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Sun, 06 Jul 2008 20:48:49 +0200 Andi Kleen <andi@firstfloor.org> wrote:
>
> The trees for the next ACPI merge are at git.kernel.org now
> These are based on Len's branches with some additional patches.
>=20
> (based on Linus' tree aka 2.6.26rc9)
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git relea=
se
> Intended for the 2.6.27 merge

If that is true ..

> git://git.kernel.org/pub/scm/git/linux/kernel/ak/linux-acpi-2.6.git test

Then why is linux-next tracking that?

> (based on Linux next for patches with dependencies)
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-next-acpi.git

Is there something we can do about those dependencies?

> This is not quite yet the full state intended for the merge, a few
> patches are still missing.

So what is missing, and why should we merge stuff in 2.6.27 that we don't
see until the merge window?  (Not trying to be antagonistic, just asking
about procedure and wondering why stuff for 2.6.27 is still not in
linux-next.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_09_56_59_+1000_=wuBq9qRdXurDYdl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxW8sACgkQjjKRsyhoI8x1XACfaeotm8UgEkXfgq0Ms8dG5Iy5
eMoAnjivGL79FWwneJhszj4ejHzyy0Nx
=T1Fo
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_09_56_59_+1000_=wuBq9qRdXurDYdl--
