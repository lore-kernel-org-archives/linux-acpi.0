From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhns-devel] Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Date: Thu, 13 May 2004 15:35:10 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040513153510.77f2d582.tokunaga.keiich@jp.fujitsu.com>
References: <20040510202036.64794519.tokunaga.keiich@jp.fujitsu.com>
 <ORSMSX407ZDgC81Tbdk000000aa@orsmsx407.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <ORSMSX407ZDgC81Tbdk000000aa-sBd4vmA9Se5zLByeVOV5+bfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hotplug-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 11 May 2004 11:51:53 -0700
Rajesh <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, May 10, 2004 at 04:20:36AM -0700, Keiichiro Tokunaga wrote: 
> >
> >On Mon, 10 May 2004 11:12:40 +0900 (JST)
> >Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org> wrote:
> >
> >> From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> >> 
> >> I've not looking closely into the code, but why do you use "PNP0A05"
> >> for container device?
> >> "PNP0A05" is defined as "Generic ISA devie" in the ACPI spec.
> >> 
> >> I think "module device (ACPI0004)"  sounds more suitable for the
> >
> >Yes.  ACPI0004 could be used as well.  Actually, PNP0A05 is
> 
> I think the code should work regardless of whether the ACPI firmware
> issues the Notify() on the ACPI0004 or PNP0A05 container object.
> That is, it should register for Notify() on both container objects.

That makes more sense.
 
> >> Also, assuming devices that have _PXM are nodes sounds a bit too
> 
> In addition, we should not assume that proximity (ACPI _PXM) implies 
> a unit of hot-plug. ACPI already requires that all hot-pluggable 
> objects must have the _EJ0 method. We can use the scope of _EJ0 to 
> determine what is ejectable.

This is right.  Referring to _PXM doesn't work...

> >> Device(\_SB) {
> >>   Processor(CPU0...) {
> >>      Name(_PXM, 0)
> >>   }
> >>   Processor(CPU1...) {
> >>      Name(_PXM, 1)
> >>   }
> >> 
> >>   Device(PCI0) {
> >>      Name(_PXM, 0)
> >>   }
> >>   Device(PCI1) {
> >>      Name(_PXM,1)
> >>   }
> >> }
> >> 
> >> (I don't know if such an implementation exists, but from the spec,
> >> it is possible)
> >> In this case, OS has to group devices by same number.
> >> Please don't assume specific ACPI AML implementatin as a generic
> >> rule.
> >
> >If ACPI ASL is written that way, LHNS cannot do anything since
> >there is no container device (this is not ACPI term here) in the
> >system.  LHNS's target is a container *device* (again, not ACPI
> >term:) and hotplugs it physically (of course, the device needs to
> 
> To clarify: the scope of LHNS may be restricted to supporting ACPI
> based hot-plug of resources within an ACPI container only. However,
> we are also working on supporting ACPI Notify() issued directly to
> the processor and memory device objects, so this will also be
> supported.

That'll be nice :)

> The overall ACPI hot-plug solution must not require the
> user (administrator, kernel builder) to know the details of whether
> the ACPI firmware issues a Notify() directly on the processor/memory
> object or on a container object that includes processor and/or
> memory objects.
> Note: I am moving this discussion to acpi-devel list and away from
> lkml. We are really discussing extending the current ACPI hot-plug
> code to trigger CPU and memory hot-plug (similar to ACPI glue code
> that helps PCI hot-plug). LHNS is not trying to define
> the correct way to write the kernel code that actually implements CPU 
> or memory hot-plug. Obviously, we will need to make sure that hot-plug
> triggered by ACPI plays well with hot-plug triggered by non-ACPI means.

Thank you for coordinating.  

Thanks,
Kei


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
