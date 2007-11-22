From: "Kirill A. Shutemov" <k.shutemov@velesys.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Thu, 22 Nov 2007 12:04:27 +0200
Message-ID: <20071122100427.GB7085@localhost.localdomain>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org> <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org> <4743F8D2.2090302@linux.vnet.ibm.com> <20071121012918.eff93b22.akpm@linux-foundation.org> <64bb37e0711211133g355a808dl7c2bec7fe3789ddd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752686AbXKVKD2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64bb37e0711211133g355a808dl7c2bec7fe3789ddd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On [Wed, 21.11.2007 20:33], Torsten Kaiser wrote:
> On Nov 21, 2007 10:29 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 21 Nov 2007 14:52:26 +0530 Kamalesh Babulal <kamalesh@linux.vne=
t.ibm.com> wrote:
> >
> > > Andrew Morton wrote:
> > > > On Wed, 21 Nov 2007 11:41:23 +0530 Kamalesh Babulal <kamalesh@linux=
=2Evnet.ibm.com> wrote:
> > > >> ACPI: Core revision 20070126
> > > >> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > > >> Kernel panic - not syncing: IO-APIC + timer doesn't work! Try usin=
g the 'noapic' kernel parameter
>=20
> I seen an identical error.

This bug is also reproducible with qemu.

--=20
Regards,  Kirill A. Shutemov
 + Belarus, Minsk
 + Velesys LLC, http://www.velesys.com/
 + ALT Linux Team, http://www.altlinux.com/

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHRVQrbWYnhzC5v6oRAjiGAJ9mFEvEEpaCJlaujVRljQs8npd8jACeOynx
4XJPQveZ6Pl77c/LHODAhgE=
=oqid
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
