From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 19:20:12 +0100
Message-ID: <200903231920.12991.rjw@sisk.pl>
References: <49C484B7.20100@goop.org> <49C67054.7020603@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E8766@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60644 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757557AbZCWST5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2009 14:19:57 -0400
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E8766@pdsmsx502.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: 'Jeremy Fitzhardinge' <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

On Monday 23 March 2009, Tian, Kevin wrote:
> >From: Jeremy Fitzhardinge
> >Sent: Monday, March 23, 2009 1:08 AM
> >
> >Rafael J. Wysocki wrote:
> >> On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
> >>   
> >>> Rafael J. Wysocki wrote:
> >>>     
> >>>> Well, why don't you implement the platform suspend 
> >operations for Xen?
> >>>> I guess you don't want ACPI _PTS to be executed during 
> >suspend as well.
> >>>>   
> >>>>       
> >>> I don't know.  What's _PTS?
> >>>     
> >>
> >> It's an ACPI method called to prepare the platform to enter 
> >the sleep state
> >> (the name stands for "prepare to sleep").  Executing it may 
> >affect the
> >> hardware.
> >>   
> >
> >OK, that's what we want.  Dom0 is the control domain which is 
> >responsible for the bulk of the hardware; Xen itself has very little 
> >hardware knowledge.
> 
> yes, Xen only takes care of several core system devices (pic, 
> ioapic, serial, timer sources) and cpus, and let dom0 control all
> the rest. _PTS, imo, will not affect Xen controlled devices as 
> even on native those devices are suspended after _PTS. Also
> Xen doesn't incorporate ACPI parser and thus can't evaluate any
> ACPI method on its own.
> 
> >
> >> I think you really should not execute any global ACPI 
> >methods to suspend a
> >> guest, because that may affect the host.  That's why I think 
> >it's better to
> >> regard Xen as a platform and implement a separate set of 
> >suspend operations for
> >> it.
> >>   
> >
> >In this case we're talking about the special privileged domain 
> >which can 
> >be considered to be on the "host" side of the line. 
> >
> >That said, I'd be interested in looking at a suspend operations-based 
> >approach if you think its the right way to go.  But I'm concerned that 
> >we'd end up with a big set of very similar-looking parallel functions 
> >just to deal with some difference in detail near the bottom.  Can you 
> >give me a pointer to where this gets put together for acpi?
> >
> 
> As Jeremy pointed out, dom0 is a special domain which cooperate
> with Xen to fulfill the whole S3 sequence, i.e. dom0 still carries 99%
> existing ACPI S3 flow, with several exceptions as below:
> 
> a) No need to prepare wakeup stub (since it's Xen to be first waken
> up after resume), and no expectation that execution flow will be 
> resumed from its wakeup stub (context is resumed at hypercall
> return)
> 
> b) No need to save/restore bsp context and gear to Xen by hypercall
> at last step where originally hardware reg bits are written
> 
> And then Xen jumps in to finish remaining steps. From this angle,
> Xen is not a completely new platform and, well, S3 is more like a
> 'S1' type from dom0's p.o.v with a different trigger method. Then is
> it overkilled to introduce a new set of ops with 99% content 
> duplicated?

IMO, no, it isn't.

Thanks,
Rafael
