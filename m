From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for June 18
Date: Thu, 18 Jun 2009 16:47:15 +1000
Message-ID: <20090618164715.f16bb01c.sfr@canb.auug.org.au>
References: <20090618145949.d933719a.sfr@canb.auug.org.au>
	<alpine.LFD.2.00.0906180141130.8921@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__18_Jun_2009_16_47_15_+1000_6Pwdb07YZsFWLn7n"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:58933 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759276AbZFRGrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 02:47:19 -0400
In-Reply-To: <alpine.LFD.2.00.0906180141130.8921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

--Signature=_Thu__18_Jun_2009_16_47_15_+1000_6Pwdb07YZsFWLn7n
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Thu, 18 Jun 2009 01:47:06 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:
>
> > Merging acpi/test
> > CONFLICT (content): Merge conflict in drivers/platform/x86/Kconfig
> > CONFLICT (content): Merge conflict in drivers/platform/x86/toshiba_acpi=
.c
>=20
> Okay, I've dropped the toshiba_acpi branch from test, pending a refresh
>=20
> > [master 28e994e] Revert "Merge branch 'oqo-wmi-EXPECT-REFRESH' into tes=
t"
>=20
> Okay, I've dropped the oqo branch from test, pending a refresh
>=20
> > CONFLICT (content): Merge conflict in drivers/platform/x86/eeepc-laptop=
.c
>=20
> As I've sync'd my test tree with Linus' tree in preparation for
> a merge, it seems that I need a refreshed eeepc-laptop branch too:-(

Thanks for all that.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__18_Jun_2009_16_47_15_+1000_6Pwdb07YZsFWLn7n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko54vMACgkQjjKRsyhoI8yWowCggAs8RJdgKYUk4kNAeLCes1g3
18IAnjZ25HDB0lcwBh1ZpOU0YJ/AIO26
=NACl
-----END PGP SIGNATURE-----

--Signature=_Thu__18_Jun_2009_16_47_15_+1000_6Pwdb07YZsFWLn7n--
