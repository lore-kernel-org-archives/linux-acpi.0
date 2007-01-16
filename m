From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 4/5] i386: turn on CONFIG_PNP in defconfig
Date: Tue, 16 Jan 2007 10:34:58 -0700
Message-ID: <200701161034.59194.bjorn.helgaas@hp.com>
References: <200701161028.10109.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:42786 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbXAPRfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 12:35:05 -0500
In-Reply-To: <200701161028.10109.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

I'm trying to remove drivers/acpi/motherboard.c, which is mostly
redundant with drivers/pnp/system.c.  So make sure that we include the
PNP driver in the default config.  Most distros enable this already.

Turning on CONFIG_PNP also causes the following options to be enabled:

    CONFIG_PNPACPI
    CONFIG_SERIAL_8250_PNP

CONFIG_SERIAL_8250_PNP causes legacy serial ports to be discovered
twice, which is ugly but harmless:

    serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
    00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: mm-work13/arch/i386/defconfig
===================================================================
--- mm-work13.orig/arch/i386/defconfig	2007-01-11 13:56:18.000000000 -0700
+++ mm-work13/arch/i386/defconfig	2007-01-11 13:57:23.000000000 -0700
@@ -466,7 +466,7 @@
 #
 # Plug and Play support
 #
-# CONFIG_PNP is not set
+CONFIG_PNP=y
 
 #
 # Block devices
