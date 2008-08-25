From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] PNPACPI: ignore the producer/consumer bit for extended IRQ descriptors
Date: Mon, 25 Aug 2008 08:56:00 -0600
Message-ID: <200808250856.01302.bjorn.helgaas@hp.com>
References: <200808220947.18253.bjorn.helgaas@hp.com> <20080825101543.GC26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:25034 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbYHYO4l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Aug 2008 10:56:41 -0400
In-Reply-To: <20080825101543.GC26610@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Adam M Belay <abelay@mit.edu>, Matthieu CASTET <matthieu.castet@parrot.com>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Monday 25 August 2008 04:15:43 am Andi Kleen wrote:
> On Fri, Aug 22, 2008 at 09:47:17AM -0600, Bjorn Helgaas wrote:
> > The Extended Interrupt descriptor has a producer/consumer bit, but
> > it's not clear what that would mean, and existing BIOSes use the bit
> > inconsistently.  This patch makes Linux PNPACPI ignore the bit.
> 
> Added thanks. Will put in the next 2.6.27 update.

This doesn't need to go in 2.6.27 (at least, I can't think of
anything it will fix there).  This is more in the category of
paving the way for future changes.

Bjorn
