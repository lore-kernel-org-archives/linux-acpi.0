From: Parrenin =?ISO-8859-1?Q?Fr=E9d=E9ric?= <parrenin-6cgPr1GgFWewRP7jdkWmCvzYAJ16yAcp@public.gmane.org>
Subject: Re: RE : ACPI on VAIO GRX516 doesn't work with klaptop
Date: 27 Dec 2002 18:03:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1041008626.2211.10.camel@lgge-pc176.obs.ujf-grenoble.fr>
References: <200212271350.gBRDoNt26133@cnes.fr>
Reply-To: Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212271350.gBRDoNt26133-9uq6Vi6nF6Y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Chemla <patrick.chemla-GILi49z+0PNQFI55V6+gNQ@public.gmane.org>
Cc: Frederic.Parrenin-Gtl4WnLjklm1lNqXp+/2b1AUjnlXr6A1@public.gmane.org, 'acpi-devel' <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

kacpi of course !

	Frederic

Le ven 27/12/2002 =E0 14:49, Patrick Chemla a =E9crit :
> Hi,
>=20
> Yes it seems to be a klaptop issue. Does anyone knows any other tool th=
at
> could replace klaptopdaemon ?
>=20
> Patrick=20
> =20
>=20
> -----Message d'origine-----
> De : Parrenin Fr=E9d=E9ric [mailto:parrenin-6cgPr1GgFWewRP7jdkWmCvzYAJ16yAcp@public.gmane.org]=20
> Envoy=E9 : vendredi 27 d=E9cembre 2002 14:42
> =C0 : Patrick Chemla
> Cc : acpi-devel
> Objet : Re: [ACPI] ACPI on VAIO GRX516 doesn't work with klaptop
>=20
> It is more a klaptop issue.
>=20
> Regards.
>=20
> 	Frederic
>=20
>=20
> Le mer 25/12/2002 =E0 13:09, Patrick Chemla a =E9crit :
> >  =20
> > Hi,
> > =20
> > I have a VAIO PCG-GRX516SP, latest SONY laptop, with P4 2Ghz, 512Mb
> memory,
> > 60Gb HD, .. A really fine laptop.
> > =20
> > I first installed a RedHat 8.0 last distribution, updated with latest
> > patches on kernel 2.4.18-8-0-18.
> > =20
> > I downloaded a 2.4.20 kernel from kernel.org, updated with last acpi
> patches
> > acpi-20021202-2.4.20.diff
> > =20
> > I build and rebuild my kernel with/out ACPI, with/out APM.
> > =20
> > Latest status is that /proc/acpi directory contains all info and even=
ts,
> > working well when I plug in/out the AC adapter, when I let the batter=
y
> > discharged, I can see battery status, but KLaptopdaemon says that ACP=
I
> seems
> > to be partially installed, info not available, no battery.
> > =20
> > It seems that the problem doesn't come from ACPI drivers themselves, =
but
> > from Kalptopdaemon. I have applied some patches on Klaptop that give =
the
> > right directory path (/proc/acpi instead of /proc/sys/acpi). Doesn't =
work.
>=20
> > =20
> > Do you have any idea ?
> > =20
> > Thanks for help.
> > =20
> >=20
> > Patrick Chemla
> > =20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
