From: steup <steup-T/o0Z7lmwKpeoWH0uzbU5w@public.gmane.org>
Subject: Re: Poweroff works intermittently
Date: Tue, 6 Apr 2004 12:30:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040406123012.7264222a.steup@nerim.net>
References: <40696F10.7020009@tiscali.it>
	<40697D34.9050507@pca.it>
	<20040403140535.6f5b5a62.steup@ifrance.com>
	<Pine.LNX.4.58.0404031450190.1744@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0404031450190.1744-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

In fact after testing, your patch is not needed for me. (Vaio Z1RMP, kernel=
 2.6.4)
Just disabling local APIC from vanilla sources makes the computer shutdown =
properly.

Bye

On Sat, 3 Apr 2004 14:52:42 +0200 (CEST)
hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Steup,
> I am just curious. May you try without my patch and just with a kernel
> without APIC support.
>=20
> Cheers hartwig :-)
>=20
> On Sat, 3 Apr 2004, steup wrote:
> > > - - disable APIC/Local-APIC (at boot with 'noapic/nolapic' or in the =
kernel), in
> > >   many cases (as in mine) this solves the problem
> > >
> > > - - using Hartwig Felger's patch, other infos
> > > 	http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107842464918369&w=
=3D2
> > > 	http://bugme.osdl.org/show_bug.cgi?id=3D2109
> > >
> > > Thx, bye,
> > > Gismo / Luca
> > > ___[ Pub ]____________________________________________________________
> > > Inscrivez-vous gratuitement sur Tandaime, Le site de rencontres !
> > > http://rencontre.rencontres.com/index.php?origine=3D4
> > Hi,
> >
> > I confirm, I had the same problem on a Sony vaio Z1RMP, which is solved=
 by Hartwig Felger's patch + 'nolapic' on kernel command line.
> >
> > Bye
> >
> > ___[ Pub ]____________________________________________________________
> > Inscrivez-vous gratuitement sur Tandaime, Le site de rencontres !
> > http://rencontre.rencontres.com/index.php?origine=3D4
>=20
> Gru=DF
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - --=20
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQFAbrOf9bBoTzOf1pMRAon9AKDW6hfBsM/OtRsBAcsF8/fBmSkKgQCfZt/V
> O6I0q1bi/bqgyG4uqputpJ8=3D
> =3DjBc3
> -----END PGP SIGNATURE-----
>=20
> _____________________________________________________________________
> Envie de discuter en "live" avec vos amis ? T=E9l=E9charger MSN Messenger
> http://www.ifrance.com/_reloc/m la 1=E8re messagerie instantan=E9e de Fra=
nce


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
