From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Thu, 13 Nov 2008 14:29:43 +1100
Message-ID: <20081113142943.0b090fb7.sfr@canb.auug.org.au>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
	<200811081050.25477.arvidjaar@mail.ru>
	<20081108115956.GE8354@elte.hu>
	<4916B38B.7050905@redhat.com>
	<4916B4DB.90602@zytor.com>
	<20081110083938.GD22392@elte.hu>
	<20081110115732.GA30181@srcf.ucam.org>
	<20081110125630.GC28643@elte.hu>
	<20081110130029.GC30894@srcf.ucam.org>
	<alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>
	<20081112115806.GD11352@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__13_Nov_2008_14_29_43_+1100_k7yhl/Ydgvid42vE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:37723 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYKMDaE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 22:30:04 -0500
In-Reply-To: <20081112115806.GD11352@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

--Signature=_Thu__13_Nov_2008_14_29_43_+1100_k7yhl/Ydgvid42vE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Wed, 12 Nov 2008 12:58:06 +0100 Ingo Molnar <mingo@elte.hu> wrote:
>
> * Len Brown <lenb@kernel.org> wrote:
>=20
> > Ingo,
> > If you don't mind, I'd like to continue to keep a version
> > of the acpi-reset-default patch in my test tree so that
> > it is seen by linux-next.  Once I have something that
> > I think merits upstream inclusion, I'll send a request
> > to you.  Will that work?
>=20
> It's fine to me - although i'm a bit uncomfortable about keeping a=20
> known breakage in linux-next.
>=20
> linux-next is not really there to experiment around, it's there to=20
> push the known stable stuff to. linux-next has enough trouble with=20
> _unintended_ breakages.
>=20
> At least that's how i push patches to linux-next - i've Cc:-ed Stephen=20
> and Andrew if there's a clarification needed.

See my posting yesterday about procedures for linux-next.  It is really
only for integration testing.  If your code does not "merit upstream
inclusion", then it should not be in linux-next.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__13_Nov_2008_14_29_43_+1100_k7yhl/Ydgvid42vE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkbnycACgkQjjKRsyhoI8wiEwCfcw6HLTRKTuNzyYfNPZVVTJyp
9lcAoJNtzutcd1/l6CHElPJ0YwZ/mtUM
=EcQ6
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Nov_2008_14_29_43_+1100_k7yhl/Ydgvid42vE--
