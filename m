From: Adrian Bunk <bunk@fs.tum.de>
Subject: [patch] 2.6.7-rc2-mm1: let SERIAL_8250_ACPI depend on ACPI_PCI
Date: Wed, 2 Jun 2004 02:39:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040602003938.GJ25681@fs.tum.de>
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265296AbUFBAjp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
>...
> All 296 patches:
>...
> bk-acpi.patch
>...

The

  PCI IRQ update

in the ACPI tree causes the following compile error with CONFIG_PCI=n:


<--  snip  -->

...
  CC      drivers/serial/8250_acpi.o
drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
drivers/serial/8250_acpi.c:61: warning: implicit declaration of function `acpi_register_gsi'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xfc1c7): In function `acpi_serial_ext_irq':
: undefined reference to `acpi_register_gsi'
drivers/built-in.o(.text+0xfc1f6): In function `acpi_serial_irq':
: undefined reference to `acpi_register_gsi'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


It seems the following is required:


--- linux-2.6.7-rc2-mm1/drivers/serial/Kconfig.old	2004-06-02 02:35:03.000000000 +0200
+++ linux-2.6.7-rc2-mm1/drivers/serial/Kconfig	2004-06-02 02:35:45.000000000 +0200
@@ -88,7 +88,7 @@
 config SERIAL_8250_ACPI
 	bool "8250/16550 device discovery via ACPI namespace"
 	default y if IA64
-	depends on ACPI_BUS && SERIAL_8250
+	depends on ACPI_PCI && SERIAL_8250
 	---help---
 	  If you wish to enable serial port discovery via the ACPI
 	  namespace, say Y here.  If unsure, say N.



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
