From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Fri, 05 Sep 2003 18:28:56 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F590E28.6090101@pobox.com>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F59018E.5060604@pobox.com> <200309060016.16545.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309060016.16545.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew de Quincey wrote:
> On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
>>This is why we _really_ need you to split up your patches.  Multiple
>>split-up patches, one per email, is preferred.  Don't worry about
>>sending us too much email:  we like it like that.
> 
> 
> If/when I split it up, is it acceptable to number the patches to give the 
> order they have to be applied in?

Absolutely.  It's quite common for me to receive a series of emails, all 
patches, where each successive patch has a dependency on the preceding 
one.  Linus just applies a patch series from Al Viro today which was 
presented as
	[PATCH] large dev_t - second series (1/15)
	[PATCH] large dev_t - second series (2/15)
			...
	[PATCH] large dev_t - second series (15/15)

Many of us have patch-applying scripts, which can apply an entire mbox 
full of patches.  The email subject lines, the patch, and any text you 
wrote in the email are all commited to the BitKeeper repository as a 
single changeset.


>>As an aside, I know at least part of the VIA irq routing stuff still 
>>needs fixing.  For some on-board VIA southbridge devices, irq routing is 
>>accomplished by writing the PCI_INTERRUPT_xxx values to PCI config 
>>registers of the target device; for others, the normal pirq PCI config 
>>registers on the southbridge are used.  Alan's new irq stuff in 2.4.x 
>>IMO should be merged into 2.6.x soonish, as Alan's work makes a big step 
>>towards making it possible to fix some of the harder-to-fix irq routing 
>>problems.
> 
> 
> Is this still an issue when using ACPI? Surely it should insulate the OS from 
> this chipset-specific stuff? 

Correct, proper ACPI tables on VIA will avoid this problem.

	Jeff
