From: Kai Germaschewski <kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 12:23:37 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0210241221430.6574-100000@chaos.physics.uiowa.edu>
References: <20021024201518.A2708@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021024201518.A2708-ORSVBvAovxo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Oct 2002, Ville Syrj=E4l=E4 wrote:

> Yes I see the logic in that. But I don't know enough about PCI to relly
> understand how things work. Over one iteration this does exactly what m=
y
> patch did and that's what I care about :) Is it even realistic to expec=
t
> that multiple bridges are lined up so that the loop would get executed
> more than once?

Well, it's possible, though I don't have any box which does. Say you have=
=20
a PCI hotplug controller, which I think appears as bridge and put a 4-por=
t=20
tulip network card into it. These network cards are implemented using a=20
PCI bridge as well, so that'd be a case where it would actually happen.

--Kai




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
