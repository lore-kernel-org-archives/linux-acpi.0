From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Tue, 24 Jul 2007 15:40:43 -0600
Message-ID: <200707241540.43868.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <200707061038.50755.bjorn.helgaas@hp.com> <Pine.LNX.4.64.0707211905450.6747@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:35687 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802AbXGXVlN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2007 17:41:13 -0400
In-Reply-To: <Pine.LNX.4.64.0707211905450.6747@asgard.lang.hm>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Saturday 21 July 2007 08:09:11 pm david@lang.hm wrote:
> On Fri, 6 Jul 2007, Bjorn Helgaas wrote:
> > Ultimately, you should have CONFIG_ACPI=y and CONFIG_PNPACPI=y, and you
> > should not have to boot with "noisapnp" or "pnpacpi=off".  My guess is
> > that you only need "pnpacpi=off" to work around the current problem.
> 
> these two options are enabled and pnpacpi=off does solve the problem.
> ...
> there's now a dmesg.pnpacpi_off which works, and you are correct that the 
> dmesg that's there is the non working one.

Thanks.  Here's what I glean from that.  With no arguments, it doesn't work:

    parport_pc 00:0a: reported by Plug and Play ACPI
    parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
    parport0: Printer, Brother HL-5040 series
    lp0: using parport0 (interrupt-driven).

With pnpacpi=off, it works:

    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
    parport0: irq 7 detected
    parport0: Printer, Brother HL-5040 series
    lp0: using parport0 (polling).

With pnpacpi=off, or a kernel without PNPACPI, we just probe at 0x378
and use the port in polling mode, and it works.

PNPACPI claims the device supports interrupts, so we try to use it in
interrupt mode, and it doesn't work.  It's possible that ACPI is lying
to us, and the interrupt really doesn't work.  Or maybe the interrupt
*does* work, but the BIOS left it half-configured.

Could you try the attached patch and collect the dmesg log and contents
of /proc/interrupts?

Thanks,
  Bjorn

Index: w/drivers/pnp/pnpacpi/core.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/core.c	2007-07-24 15:05:25.000000000 -0600
+++ w/drivers/pnp/pnpacpi/core.c	2007-07-24 15:29:50.000000000 -0600
@@ -216,6 +216,13 @@
 	pnp_add_device(dev);
 	num ++;
 
+	if (dev->active) {
+		printk("%s: configuring %s (%s)\n", __FUNCTION__, dev->dev.bus_id, dev_id->id);
+		pnp_disable_dev(dev);
+		pnp_init_resource_table(&dev->res);
+		pnp_activate_dev(dev);
+	}
+
 	return AE_OK;
 err1:
 	kfree(dev_id);
