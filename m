From: Thomas Andrews <tandrews@grok.co.za>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Mon, 04 Dec 2006 21:29:15 +0200
Message-ID: <4574770B.80009@grok.co.za>
References: <20061202150530.GA5159@grok.co.za> <200612041049.00690.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.grok.org.za ([196.1.58.22]:3360 "EHLO mail.grok.org.za"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759310AbWLDT3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 14:29:30 -0500
In-Reply-To: <200612041049.00690.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Saturday 02 December 2006 08:05, Thomas Andrews wrote:
>> A driver that I've written for the Cologne HFC-4S (based heavily on
>> qozap.c) only receives interrupts when pci=routeirq is specified. The
>> driver is calling pci_enable_device(), so pci=routeirq should not be
>> necessary surely?
> 
> Can you point me to your driver?  I don't see it in the Linus or
> -mm trees.
> 
> The most likely problem is that you are using pci_dev.irq before
> calling pci_enable_device().

Thanks Bjorn. My driver and the original are at 
http://www.grok.org.za/qozap/

I'm pretty sure the interrupt is not invoked before calling 
pci_enable_device(), but perhaps you can shed some light...

Many thanks,
Thomas
