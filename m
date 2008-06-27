From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 09:14:18 -0600
Message-ID: <200806270914.18564.bjorn.helgaas@hp.com>
References: <4864ED65.8050009@keyaccess.nl> <31574.1214572588@redhat.com> <16399.1214578444@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:30357 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYF0POm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2008 11:14:42 -0400
In-Reply-To: <16399.1214578444@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On Friday 27 June 2008 08:54:04 am David Howells wrote:
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
> > Well, it's been promoted from a u8, so no need for that anyway, but <shrug>.
> 
> My logic is that in commit 95b24192cf27631dc11541e97c430389320e7a93 it says
> the following:
> 
> 	ACPI Extended Interrupt Descriptors can encode 32-bit interrupt
> 	numbers, so an interrupt number may exceed the size of the bitmap
> 	we use to track possible IRQ settings.
>  
> so the field in 'struct acpi_resource_irq' might at some point increase to be
> a 32-bit unsigned value.  Otherwise there's no point having the check at all,
> right?

There are two flavors of ACPI IRQ descriptors, which the CA puts
into acpi_resource_irq and acpi_resource_extended_irq.

struct acpi_resource_irq will never have an IRQ number larger than
255.  PNP_IRQ_NR is currently 256, so we don't really have a problem
there.

struct acpi_resource_extended_irq has a u32 IRQ value, and that's
where I'm worried.  We already have plenty of devices with GSIs in
the 2000 range.  In most cases, I think these are PCI devices, so
these GSIs appear in _PRT (PCI routing tables) rather than in _PRS.
But there is the possibility that we could see a configurable ACPI
device with a large GSI, and that's why I added the check.

I think what happened here is that I meant to put this test in
pnpacpi_parse_ext_irq_option(), but somehow it got into
pnpacpi_parse_irq_option() instead.  I'll try to sort this out
today.

Bjorn
