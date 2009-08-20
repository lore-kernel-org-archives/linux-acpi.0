From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 17:10:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201708580.2670-100000@iolanthe.rowland.org>
References: <200908202137.28358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50776 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751293AbZHTVKe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 17:10:34 -0400
In-Reply-To: <200908202137.28358.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thu, 20 Aug 2009, Rafael J. Wysocki wrote:

> On Thursday 20 August 2009, Alan Stern wrote:
> > On Thu, 20 Aug 2009, Matthew Garrett wrote:
> > 
> > > > If the wakeup signal isn't squelched at the source, as part of the
> > > > event handling, will we get an interrupt storm?  Will the uhci-hcd 
> > > > resume routine be able to handle this or does it need to be done 
> > > > earlier?  In other words, do we need special-purpose code in the PCI 
> > > > layer to handler it?
> > > 
> > > No, nothing special needs to be done at the PCI level. It seems that 
> > > (for Intel at least) there's no need to do anything special at the UHCI 
> > > level either.
> > 
> > This contradicts what Shaohua wrote:
> > 
> > "The only case is UHCI in my mind. Because UHCI has non-standard wakeup
> > event register. If BIOS doesn't handle it correctly (for example, not
> > clear the wakeup event after a GPE), we will keep see the wakeup
> > event."
> 
> I'm not sure what the phrase "we will keep see the wakeup event" is supposed to
> mean.  For us to "see" any events there has to be a GPE set up or PCIe PME
> enabled on the right root port.  Otherwise I don't see how we can receive the
> event at all.
> 
> The bus type wakeup code won't know how to clear the register to acknowledge
> the wakeup, but the driver's ->runtime_resume() callback surely can do that.
> 
> > What code would be responsible for setting and clearing the 
> > non-standard wakeup register?  Are you assuming that ACPI will always 
> > handle it?  I guess that's a reasonable assumption -- if ACPI wasn't 
> > aware of the register then it never would get enabled, and conversely, 
> > if ACPI was aware and could enable the register, then ACPI ought to 
> > disable it when necessary.
> 
> In any case the event has to be raised in one of the standard ways.

I'm still not clear on this.  Does the non-standard wakeup register
have to be set and cleared by the suspend and resume routines in
uhci-hcd, or will it be handled by other code?

Alan Stern

