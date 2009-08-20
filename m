From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 11:22:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201118490.2656-100000@iolanthe.rowland.org>
References: <20090820144246.GA4229@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48256 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751461AbZHTPW7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 11:22:59 -0400
In-Reply-To: <20090820144246.GA4229@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 20 Aug 2009, Matthew Garrett wrote:

> > If the wakeup signal isn't squelched at the source, as part of the
> > event handling, will we get an interrupt storm?  Will the uhci-hcd 
> > resume routine be able to handle this or does it need to be done 
> > earlier?  In other words, do we need special-purpose code in the PCI 
> > layer to handler it?
> 
> No, nothing special needs to be done at the PCI level. It seems that 
> (for Intel at least) there's no need to do anything special at the UHCI 
> level either.

This contradicts what Shaohua wrote:

"The only case is UHCI in my mind. Because UHCI has non-standard wakeup
event register. If BIOS doesn't handle it correctly (for example, not
clear the wakeup event after a GPE), we will keep see the wakeup
event."

What code would be responsible for setting and clearing the 
non-standard wakeup register?  Are you assuming that ACPI will always 
handle it?  I guess that's a reasonable assumption -- if ACPI wasn't 
aware of the register then it never would get enabled, and conversely, 
if ACPI was aware and could enable the register, then ACPI ought to 
disable it when necessary.

Alan Stern

