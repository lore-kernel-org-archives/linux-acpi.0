From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: platform_get_irq_byname() supported on ACPI?
Date: Mon, 08 Feb 2016 23:37:08 +0100
Message-ID: <14142046.8lM1qrtiEy@vostro.rjw.lan>
References: <56B8C6E1.1040804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42626 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756658AbcBHWf5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2016 17:35:57 -0500
In-Reply-To: <56B8C6E1.1040804@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday, February 08, 2016 10:48:33 AM Timur Tabi wrote:
> Is there support for the platform_get_irq_byname() function on ACPI systems?
> 
> I'm working on adding ACPI support for a driver that currently only 
> supports device tree.  This driver has code like this:
> 
> 	ret = platform_get_irq_byname(pdev, "core0_irq");
> 
> This function works fine on device tree, but it fails on our ACPI system 
> because our ACPI nodes don't appear to have any way to attach a name to 
> an IRQ resource:

That's correct.

> 
> Method (_CRS, 0x0, Serialized) {
> 	Name (RBUF, ResourceTemplate() {
> 		[snip]
> 		Interrupt (ResourceConsumer, Level, ActiveHigh,
> 			Exclusive, , , )
> 			{0x120, 0x121, 0x122, 0x123}
> 	})
> 	Return (RBUF)
> }
> 
> I would hate to have to do something like this:
> 
> ret = platform_get_irq_byname(pdev, "core0_irq");
> if (ret)
> 	/* ACPI doesn't support named resources */
> 	ret = platform_get_irq(pdev, 0);

That's the only way ATM, though.

In theory _DSD might be used to provide a name for the IRQ resource, but
that hasn't been explored yet (and there's no support in the code, of
course).

Thanks,
Rafael

