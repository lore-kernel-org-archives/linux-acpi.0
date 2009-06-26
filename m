From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Fri, 26 Jun 2009 13:14:53 +1000
Message-ID: <20090626131453.82b5fb98.sfr@canb.auug.org.au>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
	<alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
	<alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
	<71cd59b00906190128h6de62133o9e8380e1992da59c@mail.gmail.com>
	<alpine.LFD.2.00.0906191535220.4325@localhost.localdomain>
	<alpine.LFD.2.00.0906240136300.32742@localhost.localdomain>
	<71cd59b00906232339t1d0812embd711243468be91d@mail.gmail.com>
	<alpine.LFD.2.00.0906251237490.4308@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__26_Jun_2009_13_14_53_+1000__8BoTsjBXOygBfj3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:56433 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbZFZDO4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2009 23:14:56 -0400
In-Reply-To: <alpine.LFD.2.00.0906251237490.4308@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org

--Signature=_Fri__26_Jun_2009_13_14_53_+1000__8BoTsjBXOygBfj3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Thu, 25 Jun 2009 12:42:14 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:
>
> On Wed, 24 Jun 2009, Corentin Chary wrote:
>=20
> > On Wed, Jun 24, 2009 at 7:41 AM, Len Brown<lenb@kernel.org> wrote:
>=20
> > > Unfortunately, upstream scribbed more rfkill stuff on eeepc-laptop.c
> > > I did take a swing at merging the conflicts, but got lost.
> > > So it is probably best if you refresh those last 8 eeepc-laptop.c
> > > patches and send them again.
>=20
> > Isn't that fixed by http://lkml.org/lkml/2009/6/21/169 ?

That is just showing how I resolved the conflict when I merged the
wireless tree into linux-next that day ...

> Hmm, apparently so -- I didn't receive that note.
> I suppose if Stephen signed off on it, I could have applied it
> and not dropped the tail of your patch series from rc1...

so it is not a patch that can be applied.

> Anyway, thanks for refreshing the patches,
> I've checked them in and they'll be in my -rc2 push.

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Jun_2009_13_14_53_+1000__8BoTsjBXOygBfj3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpEPS0ACgkQjjKRsyhoI8xQ/wCgi6SncNKxcYrBrRYEIDaulRS2
i4EAn3EyQTKod7ASCGCM5y9PRutlIRMF
=6qPy
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Jun_2009_13_14_53_+1000__8BoTsjBXOygBfj3--
