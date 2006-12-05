From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Tue, 5 Dec 2006 10:58:19 -0700
Message-ID: <200612051058.19960.bjorn.helgaas@hp.com>
References: <20061202150530.GA5159@grok.co.za> <200612041420.12741.bjorn.helgaas@hp.com> <20061205045050.GA14444@grok.co.za>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:45097 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968546AbWLER60 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Dec 2006 12:58:26 -0500
In-Reply-To: <20061205045050.GA14444@grok.co.za>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Andrews <tandrews@grok.co.za>
Cc: linux-acpi@vger.kernel.org

On Monday 04 December 2006 21:50, Thomas Andrews wrote:
> On Mon, Dec 04, 2006 at 02:20:12PM -0700, Bjorn Helgaas wrote:
> > Can you post the entire dmesg log with and without "pci=routeirq"?
> 
> And here it is with "pci=routeirq":

I think this is a BIOS bug.  Are there any updates available?

My guess is that 0000:00:0a.0[A] is really connected to LNKC,
and the BIOS writer forgot to tell us that.

Without "pci=routeirq", we leave LNKC disabled.  With
"pci=routeirq", we enable LNKC at IRQ 10 for 0000:00:0e.0[A]
even though you don't have a driver for the 0000:00:0e.0 device,
and I think this makes the 0000:00:0a.0[A] interrupt work as
a side-effect.

If you load a driver for the firewire device at 0000:00:0e.0,
that should enable LNKC, and I bet that will make your qozap
driver start working.

Let me know what you find.

Bjorn
