From: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: How to "register" a GSI for a non PCI non ISA device
Date: Thu, 26 Jan 2012 18:30:41 +0100
Message-ID: <20120126183041.15474705@xilun>
References: <20120124184203.1b0878c2@xilun>
	<4F1F99A5.1000206@kernel.org>
	<20120125182314.7834c75b@xilun>
	<20120125190214.GC18606@phenom.dumpdata.com>
	<20120126160719.3b9be3b3@xilun>
	<20120126153239.GA14367@phenom.dumpdata.com>
	<20120126172248.72b0efa5@xilun>
	<CAErSpo5vCr4Y3Q6U1=yYLcSBH-85koMKDte4rzw4tyuKocYXYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from paperboy.avencall.com ([91.194.178.22]:58285 "EHLO
	mx1.corp.avencall.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752176Ab2AZRat (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2012 12:30:49 -0500
In-Reply-To: <CAErSpo5vCr4Y3Q6U1=yYLcSBH-85koMKDte4rzw4tyuKocYXYA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guillaume Knispel <gknispel@proformatique.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Xavier Carcelle <xcarcelle@avencall.com>, =?ISO-8859-1?Q?No=E9?= Rubinstein <nrubinstein@avencall.com>

On Thu, 26 Jan 2012 10:24:31 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> A driver should never need to use acpi_register_gsi() directly.  It
> sounds like you have a non-PCI device that would be described as an
> ACPI device in the DSDT.  In the Device definition, you include a _CRS
> method that tells the kernel what GSI it is using.  The PNPACPI
> subsystem will parse _CRS and should do the acpi_register_gsi() for
> you.  Then your driver would use pnp_register_driver() and pnp_irq()
> to learn the IRQ.  drivers/tty/serial/8250_pnp.c is an example.

Thanks a lot, I'll look into it.

-- 
Guillaume Knispel
Avencall - 10 bis, rue Lucien Voilin - 92800 Puteaux
