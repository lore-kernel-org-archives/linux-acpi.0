From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 14:30:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF7E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: 'Kai Germaschewski' <kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Kai Germaschewski [mailto:kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org]=20
> On Thu, 24 Oct 2002, Ville Syrj=E4l=E4 wrote:
> > Yes I see the logic in that. But I don't know enough about=20
> PCI to relly
> > understand how things work. Over one iteration this does=20
> exactly what my
> > patch did and that's what I care about :) Is it even=20
> realistic to expect
> > that multiple bridges are lined up so that the loop would=20
> get executed
> > more than once?
>=20
> Well, it's possible, though I don't have any box which does.=20
> Say you have=20
> a PCI hotplug controller, which I think appears as bridge and=20
> put a 4-port=20
> tulip network card into it. These network cards are=20
> implemented using a=20
> PCI bridge as well, so that'd be a case where it would=20
> actually happen.

OK, so everyone agrees Kai's version is the way to go? ;-)

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
