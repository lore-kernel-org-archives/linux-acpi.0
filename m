From: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Subject: RE: [patch] 2.4.x ACPI updates
Date: Sat, 23 Aug 2003 14:26:07 -0300 (BRT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.55L.0308231426010.19711@freak.distro.conectiva>
References: <Pine.LNX.4.44.0308230015440.14227-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0308230015440.14227-100000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Sat, 23 Aug 2003, Marcelo Tosatti wrote:

>
>
> On Fri, 22 Aug 2003, Brown, Len wrote:
>
> > Hi Marcelo,
> > A small update to what you pulled this morning --
> > fixes config options CONFIG_ACPI_HT_ONLY and CONFIG_HOTPLUG_PCI_ACPI.
> >
> > I'm looking forward to deleting these #ifdef CONFIG_ACPI_HT_ONLY
> > When we can (again) delete acpitable.[ch] in 2.4.23.
> >
> > Please
> >
> > 	bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4.22
> >
> > This
> >
> > This will update the following files:
> >
> >  drivers/hotplug/Config.in |    5 +++--
> >  include/asm-i386/acpi.h   |    7 +++++++
> >  include/linux/acpi.h      |    6 ++++++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > through these ChangeSets:
> >
> > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/22 1.1107)
> >    linux-acpi-2.4.22.patch
>
> Len,
>
> Patch applied, thanks.
>
> Do you have any further information on the ACPI oops reports I sent you?
>
> Thanks
>
>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
