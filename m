From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
Date: Wed, 26 Mar 2008 12:47:29 -0600
Message-ID: <200803261247.31531.bjorn.helgaas@hp.com>
References: <200803180510.47670.lenb@kernel.org> <200803260956.55804.bjorn.helgaas@hp.com> <47EA86D9.7040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:19517 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761489AbYCZSnf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 14:43:35 -0400
In-Reply-To: <47EA86D9.7040404@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Corentin CHARY <corentincj@iksaif.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Wednesday 26 March 2008 11:24:41 am Alexey Starikovskiy wrote:
> Bjorn Helgaas wrote:
> > I'm curious about how this works.  I disassembled the DSDT from
> > http://bugzilla.kernel.org/show_bug.cgi?id=4773 (I attached the disassembly
> > at http://bugzilla.kernel.org/attachment.cgi?id=15448&action=view), and
> > the _PRT contains "_SB" and "ISA" (no trailing underscores):
> >
> >                 Package (0x04)
> >                 {
> >                     0x000DFFFF, 
> >                     0x00, 
> >                     \_SB.PCI0.ISA.LNKA, 
> >                     0x00
> >                 }
> >
> > But by the time we get to acpi_pci_irq_add_entry(), we've added the
> > underscores somewhere (see
> > http://bugzilla.kernel.org/attachment.cgi?id=15423&action=view):
> >
> >   0000:00:0d[A] -> \_SB_.PCI0.ISA_.LNKA
> >
> > I don't know where this happens, but it certainly confused me, and
> > it seems like it could lead to other bugs.
> >   
> ACPI is supposed to add trailing underscore for pad all names to 4 bytes.
> So ISA will be padded to ISA_.

The questions are "where does this happen?" and "why does it not
apply to other things like asus_acpi.c?"
