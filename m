From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] ACPI interrupt statistics
Date: Sat, 24 Nov 2007 00:34:24 -0500
Message-ID: <200711240034.24747.lenb@kernel.org>
References: <200711030040.53126.lenb@kernel.org> <200711191942.35575.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43462 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXKXFem (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Sat, 24 Nov 2007 00:34:42 -0500
In-Reply-To: <200711191942.35575.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Linux-acpi@vger.kernel.org

On Monday 19 November 2007 14:42, Carlos Corbacho wrote:
> On Saturday 03 November 2007 04:40:53 Len Brown wrote:
> > For your review and testing...
> >
> > The patch below exports interrupt counters from within ACPI
> > so that developers can better understand the cause of ACPI interrupts.
> >
> > My intent is to have something like this built in by default
> > starting in 2.6.25.  The version below applies to 2.6.21
> > and is originally based on a patch by Luming Yu.
> 
> There have been a fair few changes since then, and this patch will probably 
> need a fair bit of work.
> 
> 1) Back in 2.6.21, acpi_subsys was defined as a 'struct subsystem' in 
> acpi_bus.h - it's now a 'struct kset'

yep, that is what broke it.

> 2) Greg KH has an RFC patch lined up that does even more work in this area - 
> http://lkml.org/lkml/2007/11/2

yeah, i noticed that too -- we already ran amuck of them with some
other patches in the acpi tree...  akpm patched it up in mm.

> 3) From my limited understanding of the area and intent, this patch seems to 
> be a combination of kset work + the interrupt support - could it be split 
> into two functionally separate patches to cover these instead?

the patch I sent to the list is actually a roll-up of a patch series,
so more patches will appear in the tree when it hits 2.6.25.

> (Basically, the only bit I'm really interested in is the 
> EXPORT_SYMBOL(acpi_subsys), as acpi_subsys can currently only be used from 
> built-in drivers, which is preventing me from converting wmi.c to a module).

hmm, okay, i didn't know that.
but feel free to pre-pend a non-wmi patch to your wmi series if you need it.

thanks,
-Len
