From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: ACPI screwing up USB ehci_hcd with kernel 2.6.16.18
Date: Mon, 29 May 2006 13:11:48 +0100
Message-ID: <1148904708.2916.1.camel@localhost.localdomain>
References: <200605282150.24428.surgpub@telkomsa.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:41684 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750733AbWE2MLw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 May 2006 08:11:52 -0400
In-Reply-To: <200605282150.24428.surgpub@telkomsa.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Surgeon <surgpub@telkomsa.net>
Cc: linux-acpi@vger.kernel.org

and before ?
can you send lspci -n ?


On Sun, 2006-05-28 at 21:50 +0200, Paul Surgeon wrote:
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
> 
> Regards
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

