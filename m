From: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Subject: Re: [Fwd: [PATCH] ACPI poweroff fixes for 2.4.26-pre2]
Date: Fri, 12 Mar 2004 11:37:16 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040312193716.GC25056@stikine.ucs.sfu.ca>
References: <1079031999.3679.1.camel@darkstar> <20040311230047.GA20345@stikine.ucs.sfu.ca> <Pine.LNX.4.58.0403121055010.1203@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403121055010.1203-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hallo Hartwig:

thanks a million! Yes, your patch from=20

http://bugme.osdl.org/attachment.cgi?id=3D2286

indeed fixes my problem (I did install your patch in addition
to the smp patches). The machine (sual Athlon MP) now powers off as
it did under 2.4.24.

Viele Gruesse aus Vancouver,
Martin

On Fri, Mar 12, 2004 at 11:03:43AM +0100, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Martin,
> I first thought, that you went the right path, as you use a smp-system,=
 to
> apply the mentioned patches for the smp-poweroff problem.
> For my uni-processor (laptop) I had a different problem with poweroff, =
and
> a solution (patch):
> http://bugme.osdl.org/show_bug.cgi?id=3D2183
> Please do not be confused. Len thought, that it would be a dublicate to
> bug 2109, so I posted the patch there. Personally I don't think that th=
e
> problems are the same, as they did start with different versions...but =
of
> the same file...
> Ok. maybe you will have a try with my patch ("hwsleep.c revert part of
> v1.23 introduced cond. when S5") from 4th of march. I would think, that
> you will need the smp-patch anyway. But I am just guessing.
>=20
> Cheers
>   hartwig
>=20
> On Thu, 11 Mar 2004, Martin Siegert wrote:
> > I tried to combine the two patches to apply to 2.4.25 and came up
> > with
> >
> > --- linux-2.4.25/drivers/acpi/system.c.orig     Fri Nov 28 10:26:19 2=
003
> > +++ linux-2.4.25/drivers/acpi/system.c  Thu Mar 11 13:12:11 2004
> > @@ -40,6 +40,7 @@
> > @@ -95,6 +96,12 @@
> > --- 2.4.25/drivers/acpi/system.c        2004-03-08 09:29:30.925538440=
 +0800
> > +++ b/drivers/acpi/system.c     2004-03-08 09:36:19.813378040 +0800
> > @@ -40,6 +40,7 @@
> > @@ -95,6 +96,8 @@ acpi_power_off (void)
>=20
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
> iD8DBQFAUYsF9bBoTzOf1pMRAlOZAKCvbR65c3pmiQPVfw4ZAlrg6NizZQCgiJjr
> 58hnH6PxL8IZPmf0/nNKZ+U=3D
> =3DraJH
> -----END PGP SIGNATURE-----

--=20
Martin Siegert
Manager, Research Services
WestGrid Site Manager
Academic Computing Services                        phone: (604) 291-4691
Simon Fraser University                            fax:   (604) 291-4242
Burnaby, British Columbia                          email: siegert-z1KUqvL5UUQ@public.gmane.org
Canada  V5A 1S6


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
