From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 15:42:46 +0100
Message-ID: <20090820144246.GA4229@srcf.ucam.org>
References: <20090820141436.GA3722@srcf.ucam.org> <Pine.LNX.4.44L0.0908201034340.3048-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53702 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbZHTOmz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 10:42:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908201034340.3048-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Aug 20, 2009 at 10:38:15AM -0400, Alan Stern wrote:
> On Thu, 20 Aug 2009, Matthew Garrett wrote:
> > Pretty much the same as PME events on PCI - a GPE is generated, an SCI 
> > raised, the ACPI interpreter executes the code that's in the ACPI 
> > tables, that generates a notification event on the appropriate UHCI 
> > device, we live happily ever after.
> 
> What happens after the notification event is generated?  That is, what
> functions get called?  I'm not at all familiar with this part of the
> kernel.

The notification will be sent to whichever code has registered a 
notification handler for that device. In my patches that means it'll 
arrive in the PCI layer (if it's a PCI device) and then call 
pci_runtime_resume on the appropriate device.

> If the wakeup signal isn't squelched at the source, as part of the
> event handling, will we get an interrupt storm?  Will the uhci-hcd 
> resume routine be able to handle this or does it need to be done 
> earlier?  In other words, do we need special-purpose code in the PCI 
> layer to handler it?

No, nothing special needs to be done at the PCI level. It seems that 
(for Intel at least) there's no need to do anything special at the UHCI 
level either.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
