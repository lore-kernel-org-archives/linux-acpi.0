From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Wed, 6 Dec 2006 09:45:17 -0700
Message-ID: <200612060945.17243.bjorn.helgaas@hp.com>
References: <20061202150530.GA5159@grok.co.za> <200612051058.19960.bjorn.helgaas@hp.com> <45766939.80303@grok.co.za>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56920 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936473AbWLFQpX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Dec 2006 11:45:23 -0500
In-Reply-To: <45766939.80303@grok.co.za>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Andrews <tandrews@grok.co.za>
Cc: linux-acpi@vger.kernel.org

On Tuesday 05 December 2006 23:54, Thomas Andrews wrote:
> Bjorn Helgaas wrote:
> > On Monday 04 December 2006 21:50, Thomas Andrews wrote:
> >> On Mon, Dec 04, 2006 at 02:20:12PM -0700, Bjorn Helgaas wrote:
> >>> Can you post the entire dmesg log with and without "pci=routeirq"?
> >> And here it is with "pci=routeirq":
> > 
> > I think this is a BIOS bug.  Are there any updates available?
> > 
> > My guess is that 0000:00:0a.0[A] is really connected to LNKC,
> > and the BIOS writer forgot to tell us that.
> > 
> > Without "pci=routeirq", we leave LNKC disabled.  With
> > "pci=routeirq", we enable LNKC at IRQ 10 for 0000:00:0e.0[A]
> > even though you don't have a driver for the 0000:00:0e.0 device,
> > and I think this makes the 0000:00:0a.0[A] interrupt work as
> > a side-effect.
> > 
> > If you load a driver for the firewire device at 0000:00:0e.0,
> > that should enable LNKC, and I bet that will make your qozap
> > driver start working.
> 
> Compiling firewire support into the kernel does indeed make it start 
> working, so your theory appears to be 100% correct. Is there any way to 
> confirm the BIOS bug by looking at the DSDT code? I am in touch with the 
> manufacturers of the board, so it would be very nice if I could just 
> send them a patch. (The board is quite new and there are no updates.)

I don't think you can confirm the bug by looking *only* at the _PRT
because the _PRT is a description of the hardware.  You really have
to compare the _PRT with a hardware schematic and look for a mismatch.

Your DSDT should contain a _PRT with an entry like this for the
firewire device (see section 6.2.11 of the ACPI 3.0 spec for more
details):

  Package(0x000effff, 0, LNKC, 0)

That says the INTA wire for device 0e is connected to LNKC.  If our
theory is correct, the BIOS bug would be fixed by adding an entry
like this:

  Package(0x000affff, 0, LNKC, 0)

I guess you could patch your DSDT by adding such an entry and use the
CONFIG_ACPI_CUSTOM_DSDT option to confirm that it fixes the problem.

But if your manufacturer is cooperative, they should be able to check
for this bug very easily themselves.

Bjorn
