From: "Lee, Jung-Ik" <jung-ik.lee-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Source patches updated (20021022)
Date: Thu, 24 Oct 2002 11:50:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF49@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Kai Germaschewski [mailto:kai-germaschewski-Q3dYeWy5uxSHXe+LvDLADg@public.gmane.org]
> 
> Well, it's possible, though I don't have any box which does. 
> Say you have 
> a PCI hotplug controller, which I think appears as bridge and 
> put a 4-port 
> tulip network card into it. These network cards are 
> implemented using a 
> PCI bridge as well, so that'd be a case where it would 
> actually happen.

And any bridge adapters hot-added will need swizzling to map irq exactly as
Kai mentioned.
We have a box that needs this. 

thanks,
J.I.



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
