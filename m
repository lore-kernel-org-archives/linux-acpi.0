From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 10:38:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201034340.3048-100000@iolanthe.rowland.org>
References: <20090820141436.GA3722@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41794 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751434AbZHTOiP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 10:38:15 -0400
In-Reply-To: <20090820141436.GA3722@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 20 Aug 2009, Matthew Garrett wrote:

> On Thu, Aug 20, 2009 at 10:11:19AM -0400, Alan Stern wrote:
> 
> > How is the wakeup event received?  Maybe for this one type of device a 
> > PCI quirk will solve the problem.
> 
> Pretty much the same as PME events on PCI - a GPE is generated, an SCI 
> raised, the ACPI interpreter executes the code that's in the ACPI 
> tables, that generates a notification event on the appropriate UHCI 
> device, we live happily ever after.

What happens after the notification event is generated?  That is, what
functions get called?  I'm not at all familiar with this part of the
kernel.

If the wakeup signal isn't squelched at the source, as part of the
event handling, will we get an interrupt storm?  Will the uhci-hcd 
resume routine be able to handle this or does it need to be done 
earlier?  In other words, do we need special-purpose code in the PCI 
layer to handler it?

Alan Stern

