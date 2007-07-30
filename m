From: david@lang.hm
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Sun, 29 Jul 2007 18:22:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707291821590.6331@asgard.lang.hm>
References: <1183030080.4249.172.camel@queen.suse.de> <200707061038.50755.bjorn.helgaas@hp.com>
 <Pine.LNX.4.64.0707211905450.6747@asgard.lang.hm> <200707241540.43868.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:50463
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935950AbXG3BXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 21:23:35 -0400
In-Reply-To: <200707241540.43868.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Tue, 24 Jul 2007, Bjorn Helgaas wrote:

> On Saturday 21 July 2007 08:09:11 pm david@lang.hm wrote:
>> On Fri, 6 Jul 2007, Bjorn Helgaas wrote:
>>> Ultimately, you should have CONFIG_ACPI=y and CONFIG_PNPACPI=y, and you
>>> should not have to boot with "noisapnp" or "pnpacpi=off".  My guess is
>>> that you only need "pnpacpi=off" to work around the current problem.
>>
>> these two options are enabled and pnpacpi=off does solve the problem.
>> ...
>> there's now a dmesg.pnpacpi_off which works, and you are correct that the
>> dmesg that's there is the non working one.
>
> Thanks.  Here's what I glean from that.  With no arguments, it doesn't work:
>
>    parport_pc 00:0a: reported by Plug and Play ACPI
>    parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
>    parport0: Printer, Brother HL-5040 series
>    lp0: using parport0 (interrupt-driven).
>
> With pnpacpi=off, it works:
>
>    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
>    parport0: irq 7 detected
>    parport0: Printer, Brother HL-5040 series
>    lp0: using parport0 (polling).
>
> With pnpacpi=off, or a kernel without PNPACPI, we just probe at 0x378
> and use the port in polling mode, and it works.
>
> PNPACPI claims the device supports interrupts, so we try to use it in
> interrupt mode, and it doesn't work.  It's possible that ACPI is lying
> to us, and the interrupt really doesn't work.  Or maybe the interrupt
> *does* work, but the BIOS left it half-configured.
>
> Could you try the attached patch and collect the dmesg log and contents
> of /proc/interrupts?

done, see the files
2.6.22-rc4.interrupts
2.6.22-rc4.dmesg.test
at http://lang.hm/linux

David Lang

> Thanks,
>  Bjorn
>
> Index: w/drivers/pnp/pnpacpi/core.c
> ===================================================================
> --- w.orig/drivers/pnp/pnpacpi/core.c	2007-07-24 15:05:25.000000000 -0600
> +++ w/drivers/pnp/pnpacpi/core.c	2007-07-24 15:29:50.000000000 -0600
> @@ -216,6 +216,13 @@
> 	pnp_add_device(dev);
> 	num ++;
>
> +	if (dev->active) {
> +		printk("%s: configuring %s (%s)\n", __FUNCTION__, dev->dev.bus_id, dev_id->id);
> +		pnp_disable_dev(dev);
> +		pnp_init_resource_table(&dev->res);
> +		pnp_activate_dev(dev);
> +	}
> +
> 	return AE_OK;
> err1:
> 	kfree(dev_id);
>
