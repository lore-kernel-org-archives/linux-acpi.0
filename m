From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add _PRT quirks to work around broken firmware
Date: Wed, 12 Mar 2008 15:50:20 -0400
Message-ID: <200803121550.21397.lenb@kernel.org>
References: <200803111445.16316.bjorn.helgaas@hp.com> <200803112340.05293.lenb@kernel.org> <200803121155.13321.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38642 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbYCLTv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 15:51:29 -0400
In-Reply-To: <200803121155.13321.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Pierre Ossman <drzeus-bugzilla@drzeus.cx>, Michael Fu <michael.fu@intel.com>, Martin Kirst <martin.kirst@s1998.tu-chemnitz.de>, Hadmut Danisch <hadmut@danisch.de>, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Dominik =?iso-8859-1?q?Sch=E4fer?= <schaedpq2@gmx.de>, Alex Williamson <alex.williamson@hp.com>, Aron Griffis <aron@hp.com>

On Wednesday 12 March 2008, Bjorn Helgaas wrote:
> On Tuesday 11 March 2008 09:40:04 pm Len Brown wrote:
> > Is it true that simply enabling pci=routeirq on these boxes
> > is an insufficient workaround?
> 
> I'm told that pci=routeirq is a sufficient workaround for the
> first two issues, but I verified that it is not sufficient on
> the t5710.
> 
> On the t5710, even with pci=routeirq, as soon as we turn on the
> radeon interrupt, it starts generating interrupts on LNK3.  Since
> the radeon driver isn't listening there, we eventually turn off
> that IRQ, killing other other devices sharing it as a side-effect.
> 
> I don't know why pci=routeirq works on the other two boxes.  Maybe
> because of your guess below.

okay, then lets go with the precise workaround you proposed.

thanks,
-Len

> > I suspect the answer is yes, because when pci=routeirq works
> > we may just be lucky -- eg. we happen to assign the real
> > and the fake link to the same IRQ and thus the driver
> > actually registers for the correct IRQ, but by accident.
> > 
