From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 12:35:15 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF65@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?=27Ville_Syrj=E4l=E4=27?= <syrjala-ORSVBvAovxo@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: =?ISO-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Ville Syrj=E4l=E4 [mailto:syrjala-ORSVBvAovxo@public.gmane.org]=20
> The DSDT has PCI0._PRT in which 00:01.0 (the AGP bridge) is=20
> listed. Are
> you saying that there should also be PCI1._PRT with just one entry =
for
> 01:00.0? If that were the case there wouldn't be any need to=20
> derive the
> IRQ would there?
>=20
> Either way please look at the IO-APIC code. You'll see it's almost
> identical to the ACPI code and clearly one of them is wrong.=20
> My bet goes
> to IO-APIC code being correct in which case my fix is also correct.

OK thanks for taking the time to explain. Applied.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
