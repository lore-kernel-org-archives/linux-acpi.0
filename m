From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Fri, 05 Sep 2003 17:35:10 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F59018E.5060604@pobox.com>
References: <200309051958.02818.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309051958.02818.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew de Quincey wrote:
> Hi, this is my next round of ACPI IRQ fixes. Attached are patches for linux-2.4.23-pre3 and linux-2.6.0-test4.
> 
> Please CC me on any replies. I seem to be having issues with vger.kernel.org right now.
> 
> 
> This patch addresses the following issues:
> 
> 1) ACPI now drops back to PIC mode if configuration in APIC mode fails.
> 
> 2) Removed 2 lines of erroneous code in mpparse.c which causes IO-APICs to be misconfigured.
> 
> 3) ACPI now supports PIC controllers properly.
> 
> 4) This patch includes a patch by "Jun Nakajima" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> which fixes ACPI IRQ routing for all 
> VIA motherboards I have had tested so far. I've included it in this patch as it changes one of the same files.
> 
> 5) Now retries with an extended IRQ descriptor if programming a link device with a "standard" IRQ descriptor fails.
> 
> This has already been tested successfully by multiple people.


Patch looks pretty good.  It is _very_ difficult to pick through, and 
pick apart, though.

Consider that one or more people reading your email (a) would want some 
of these fixes but (b) already have some of these fixes.

This is why we _really_ need you to split up your patches.  Multiple 
split-up patches, one per email, is preferred.  Don't worry about 
sending us too much email:  we like it like that.


As an aside, I know at least part of the VIA irq routing stuff still 
needs fixing.  For some on-board VIA southbridge devices, irq routing is 
accomplished by writing the PCI_INTERRUPT_xxx values to PCI config 
registers of the target device; for others, the normal pirq PCI config 
registers on the southbridge are used.  Alan's new irq stuff in 2.4.x 
IMO should be merged into 2.6.x soonish, as Alan's work makes a big step 
towards making it possible to fix some of the harder-to-fix irq routing 
problems.

	Jeff
