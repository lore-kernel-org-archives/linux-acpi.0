From: John Keller <jpk@sgi.com>
Subject: Re: [PATCH] RESEND - SN: Add initial ACPI support
Date: Fri, 27 Jan 2006 07:54:00 -0600 (CST)
Message-ID: <200601271354.k0RDs1uV037880@fcbayern.americas.sgi.com>
References: <200601261020.45802.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:52152 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751046AbWA0NyI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2006 08:54:08 -0500
In-Reply-To: <200601261020.45802.bjorn.helgaas@hp.com> from "Bjorn Helgaas" at Jan 26, 2006 10:20:45 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <linux-acpi-owner@vger.kernel.org>
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org

Bjorn,

Just noticed that my last reply didn't respond to all your comments....

John
----


> 
> On Monday 23 January 2006 09:00, John Keller wrote:
> > +obj-$(CONFIG_IA64_SGI_SN2)	+= acpi-ext.o
> 
> Just FYI, this code is moving into drivers/acpi soon.  Robert Moore
> might have made a trivial interface change when he integrated it into
> the ACPI CA.  No big deal, basically acpi-ext.c was arch-independent
> and we moved it to generic code.

Yes, I saw earlier discussions of this, and am aware it's coming soon,
and I believe it is already in Len's acpica tree.

...

> 
> > +void sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
> 
> This function looks very much like pci_acpi_scan_root().  Is this the
> old, non-ACPI path?

Correct. sn_pci_controller_fixup() is the old non-ACPI path.

