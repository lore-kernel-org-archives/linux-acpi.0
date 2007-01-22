From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Mon, 22 Jan 2007 09:25:49 -0700
Message-ID: <200701220925.49821.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <200701191433.09311.bjorn.helgaas@hp.com> <414cba4e0701201000n698f0bbbh10016c984c84b364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:49506 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbXAVQZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jan 2007 11:25:58 -0500
In-Reply-To: <414cba4e0701201000n698f0bbbh10016c984c84b364@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Saturday 20 January 2007 11:00, emisca wrote:
> Could you tell me which informations I must collect and in which
> conditions I must collect them so I could post them?
> They replied me on the other post that I must manually debug the
> pnpacpi code.......

Sure.  I'm here to help with the manual debug of pnpacpi :-)

If I understand correctly, you're seeing this:

  1a) Original boot (serial port works fine)
  1b) Suspend to disk
  1c) Resume (serial port doesn't work)

  2a) Original boot with pnpacpi=off (serial port works fine)
  2b) Suspend to disk
  2c) Resume (serial port works fine)

Can you please apply the patch below and collect this info:

  - Your .config file
  - dmesg logs (use "dmesg -s64000") from 1a, 1c, 2a, and 2c
  - Contents of /proc/interrupts from 1c and 2c

I'm pretty ignorant of suspend/resume, so I don't know what the
dmesg log of a resume looks like.  My dim understanding is that
resume starts with a normal boot, and then loads a suspended memory
image from disk.  I suppose the suspended memory image contains
a dmesg buffer from the original boot.  So I'm not sure what sort
of log you'll get from the 2c case.

Bjorn



Index: mm-work3/drivers/serial/8250.c
===================================================================
--- mm-work3.orig/drivers/serial/8250.c	2007-01-22 09:10:16.000000000 -0700
+++ mm-work3/drivers/serial/8250.c	2007-01-22 09:23:32.000000000 -0700
@@ -2511,6 +2511,7 @@
  */
 void serial8250_suspend_port(int line)
 {
+	printk("%s: line %d\n", __FUNCTION__, line);
 	uart_suspend_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
@@ -2522,6 +2523,7 @@
  */
 void serial8250_resume_port(int line)
 {
+	printk("%s: line %d\n", __FUNCTION__, line);
 	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
@@ -2584,8 +2586,10 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev) {
+			printk("%s: line %d\n", __FUNCTION__, i);
 			uart_suspend_port(&serial8250_reg, &up->port);
+		}
 	}
 
 	return 0;
@@ -2598,8 +2602,10 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev) {
+			printk("%s: line %d\n", __FUNCTION__, i);
 			uart_resume_port(&serial8250_reg, &up->port);
+		}
 	}
 
 	return 0;
Index: mm-work3/drivers/serial/8250_pnp.c
===================================================================
--- mm-work3.orig/drivers/serial/8250_pnp.c	2007-01-22 09:08:19.000000000 -0700
+++ mm-work3/drivers/serial/8250_pnp.c	2007-01-22 09:23:53.000000000 -0700
@@ -469,6 +469,7 @@
 {
 	long line = (long)pnp_get_drvdata(dev);
 
+	printk("%s: dev %s line %ld\n", __FUNCTION__, dev->name, line);
 	if (!line)
 		return -ENODEV;
 	serial8250_suspend_port(line - 1);
@@ -479,6 +480,7 @@
 {
 	long line = (long)pnp_get_drvdata(dev);
 
+	printk("%s: dev %s line %ld\n", __FUNCTION__, dev->name, line);
 	if (!line)
 		return -ENODEV;
 	serial8250_resume_port(line - 1);
Index: mm-work3/drivers/pnp/driver.c
===================================================================
--- mm-work3.orig/drivers/pnp/driver.c	2007-01-22 09:11:02.000000000 -0700
+++ mm-work3/drivers/pnp/driver.c	2007-01-22 09:17:47.000000000 -0700
@@ -155,6 +155,7 @@
 		return 0;
 
 	if (pnp_drv->suspend) {
+		printk("%s: %s\n", __FUNCTION__, pnp_dev->name);
 		error = pnp_drv->suspend(pnp_dev, state);
 		if (error)
 			return error;
@@ -185,8 +186,10 @@
 			return error;
 	}
 
-	if (pnp_drv->resume)
+	if (pnp_drv->resume) {
+		printk("%s: %s\n", __FUNCTION__, pnp_dev->name);
 		return pnp_drv->resume(pnp_dev);
+	}
 
 	return 0;
 }
