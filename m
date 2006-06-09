From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: ACPI screwing up USB ehci_hcd with kernel 2.6.16.18
Date: Fri, 9 Jun 2006 15:34:41 -0600
Message-ID: <200606091534.41266.bjorn.helgaas@hp.com>
References: <200605282150.24428.surgpub@telkomsa.net> <200606051045.10447.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:1174 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030278AbWFIVev (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2006 17:34:51 -0400
In-Reply-To: <200606051045.10447.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Surgeon <surgpub@telkomsa.net>
Cc: linux-acpi@vger.kernel.org

On Monday 05 June 2006 10:45, Bjorn Helgaas wrote:
> On Sunday 28 May 2006 13:50, Paul Surgeon wrote:
> > I had a problem with ACPI IRQ routing messing up the USB ehci module.
> > I have to disable the irq routing with apci=noirq in the bootloader config in 
> > order to use the ehci module.
> > 
> > Failing to do so results in :
> > usb 5-1: new high speed USB device using ehci_hcd and address 3
> > ehci_hcd 0000:00:10.4: Unlink after no-IRQ? Controller is probably using the 
> > wrong IRQ.
> > 
> > System :
> > Kernel 2.6.16.18
> > Chipset VIA KT400A
> 
> Can you open a bug report at http://bugzilla.kernel.org in the ACPI
> category?  Please attach the complete dmesg log both with and without
> "acpi=noirq".

Did you resolve this problem?  If you can collect some information, we
can probably fix the problem.

Bjorn
