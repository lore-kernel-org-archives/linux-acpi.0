From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI 20030916 for 2.4.23-pre4
Date: 16 Sep 2003 18:38:47 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1063762727.13038.34.camel@linux.local>
References: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet>
	 <1063759840.13038.23.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1063759840.13038.23.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

ACPI 20030916 for 2.4.22 and 2.4.23-pre4 is available here:

http://linux-acpi.bkbits.net/linux-acpi-release-2.4.22 
http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

The corresponding plain patches are available here:

http://sourceforge.net/project/showfiles.php?group_id=36832

The corresponding 2.6 update will be out shortly...

thanks,
-Len


On Tue, 2003-09-16 at 17:50, Len Brown wrote:
> Hi Marcelo, please do a 
> 
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23
> 
> This will update the following files:
> 
>  arch/i386/kernel/acpi.c        |    1 
>  arch/i386/kernel/dmi_scan.c    |    9 +---
>  arch/i386/kernel/mpparse.c     |   26 ++++++------
>  arch/i386/mm/ioremap.c         |    2 
>  drivers/acpi/ec.c              |    7 ++-
>  drivers/acpi/events/evregion.c |    6 +-
>  drivers/acpi/pci_link.c        |   61 ++++++++++++++++++++++++-----
>  include/acpi/acconfig.h        |    2 
>  8 files changed, 78 insertions(+), 36 deletions(-)
> 
> through these ChangeSets:
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/16 1.1063.43.6)
>    ACPI_CA_VERSION                 0x20030916
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/12 1.1063.43.5)
>    fix off-by-one error in ioremap()
>    fixes kernel crash in acpi mode:
> http://bugzilla.kernel.org/show_bug.cgi?id=1085
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/08 1.1063.43.4)
>    remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/08 1.1063.43.3)
>    support non ACPI compliant SCI over-ride specs (Jun Nakajima)
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/08 1.1063.43.2)
>    Fix ACPI oops on ThinkPad T32/T40 (Shaohua David Li)
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/09/08 1.1063.43.1)
>    Extended IRQ resource type for nForce (Andrew de Quincey)
>    Handle BIOS with _CRS that fails (Jun Nakajima)
> 
> 
> 
> 
