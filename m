From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Mon, 4 Dec 2006 14:20:12 -0700
Message-ID: <200612041420.12741.bjorn.helgaas@hp.com>
References: <20061202150530.GA5159@grok.co.za> <200612041049.00690.bjorn.helgaas@hp.com> <4574770B.80009@grok.co.za>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:58105 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937399AbWLDVUU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 16:20:20 -0500
In-Reply-To: <4574770B.80009@grok.co.za>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Andrews <tandrews@grok.co.za>
Cc: linux-acpi@vger.kernel.org

On Monday 04 December 2006 12:29, Thomas Andrews wrote:
> Bjorn Helgaas wrote:
> > On Saturday 02 December 2006 08:05, Thomas Andrews wrote:
> >> A driver that I've written for the Cologne HFC-4S (based heavily on
> >> qozap.c) only receives interrupts when pci=routeirq is specified. The
> >> driver is calling pci_enable_device(), so pci=routeirq should not be
> >> necessary surely?
> > 
> > Can you point me to your driver?  I don't see it in the Linus or
> > -mm trees.
> > 
> > The most likely problem is that you are using pci_dev.irq before
> > calling pci_enable_device().
> 
> Thanks Bjorn. My driver and the original are at 
> http://www.grok.org.za/qozap/
> 
> I'm pretty sure the interrupt is not invoked before calling 
> pci_enable_device(), but perhaps you can shed some light...

It looks like you're doing the right thing.

Can you post the entire dmesg log with and without "pci=routeirq"?
