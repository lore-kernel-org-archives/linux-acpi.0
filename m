From: Jean-Marc Valin <jean-marc.valin-ZbDpfo6ompS0w+vkrfm4Cg@public.gmane.org>
Subject: Re: Crash on boot with latest ACPI versions
Date: Sun, 25 May 2003 00:17:30 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053836250.2654.1.camel@localhost>
References: <1053758126.4072.9.camel@localhost>
 <1053836025.4322.1.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-kuoou6z9PIkrRixAvDuq";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1053836025.4322.1.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-kuoou6z9PIkrRixAvDuq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Actually, I think it's a dsdt bug. I tried an updated one and it works
fine now (2.4.20 with APIC on). I guess the case is closed?

	Jean-Marc

Le dim 25/05/2003 =E0 00:13, S=E9rgio Monteiro Basto a =E9crit :
> Have you try disable apic?=20
> I many presarios 7xx=20
>=20
> On Sat, 2003-05-24 at 07:35, Jean-Marc Valin wrote:=20
> > Hi,
> >=20
> > I've been experiencing crashes while booting with the latest ACPI
> > driver. Since I can't use a screendump program, I tried to take a
> > picture instead (sorry, bad quality):
> > http://www.xiph.org/~jm/acpi_crash.jpg
> >=20
> > I'm using a Compaq Presario 1720CA laptop (PIII 1 GHz) under 2.4.20. Th=
e
> > stock kernel ACPI doesn't crash (though battery status doesn't work),
> > but the latest ACPI drivers (all versions less than 6-10 months old)
> > crash on boot every time.
> >=20
> > 	Jean-Marc
> >=20
> > --=20
> > Jean-Marc Valin, M.Sc.A.
> > LABORIUS (http://www.gel.usherb.ca/laborius)
> > Universit=E9 de Sherbrooke, Qu=E9bec, Canada
> >=20
> --=20
> S=E9rgio Basto
> Technology Project Manager
> onevision design studios
> TECMAIA - Parque de Ci=EAncia e Tecnologia da Maia
> Rua Frederico Ulrich, 2650
> 4470-605 MOREIRA DA MAIA
> tel. + 351 22 091 5410
> fax. + 351 22 091 5419
> email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
> web: http://www.onevision-design.com
--=20
Jean-Marc Valin, M.Sc.A.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada


--=-kuoou6z9PIkrRixAvDuq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+0EPadXwABdFiRMQRAgq+AJ9E3xdu+B/9Qt7q1b9Fop5CGYdYvACgkVQe
s12B8g2FuzfIzcb9O/bufqg=
=8AjH
-----END PGP SIGNATURE-----

--=-kuoou6z9PIkrRixAvDuq--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
