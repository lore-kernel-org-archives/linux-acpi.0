From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI screwing up USB ehci_hcd with kernel 2.6.16.18
Date: Mon, 5 Jun 2006 10:45:10 -0600
Message-ID: <200606051045.10447.bjorn.helgaas@hp.com>
References: <200605282150.24428.surgpub@telkomsa.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:46231 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750777AbWFEQpQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 12:45:16 -0400
In-Reply-To: <200605282150.24428.surgpub@telkomsa.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Surgeon <surgpub@telkomsa.net>
Cc: linux-acpi@vger.kernel.org

On Sunday 28 May 2006 13:50, Paul Surgeon wrote:
> I had a problem with ACPI IRQ routing messing up the USB ehci module.
> I have to disable the irq routing with apci=noirq in the bootloader config in 
> order to use the ehci module.
> 
> Failing to do so results in :
> usb 5-1: new high speed USB device using ehci_hcd and address 3
> ehci_hcd 0000:00:10.4: Unlink after no-IRQ? Controller is probably using the 
> wrong IRQ.
> 
> System :
> Kernel 2.6.16.18
> Chipset VIA KT400A

Can you open a bug report at http://bugzilla.kernel.org in the ACPI
category?  Please attach the complete dmesg log both with and without
"acpi=noirq".

Thanks,
  Bjorn
