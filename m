From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH]Missing newline in acpi messes up dmesg output
Date: Thu, 6 Jul 2006 23:40:22 +0200
Message-ID: <200607062340.23137.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:51249 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWGFVjN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Jul 2006 17:39:13 -0400
Received: by nf-out-0910.google.com with SMTP id y38so306808nfb
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2006 14:39:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Hi,

There's a tiny bug in 2.6.18-rc1.
In drivers/acpi/bus.c::acpi_bus_set_power() there's a check to see if
the device is power_manageable and if not then print a debug message
and return -ENODEV. The debug printk() is missing a \n.

The printk statement looks like this : 

          printk(KERN_DEBUG "Device `[%s]' is not power manageable",
                          device->kobj.name);

As you can see, there's no newline at the end, and that causes 
problems for the next message to be printed.

On my system the above results in this in dmesg : 

...
Device `[PEB1]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
Device `[PEB2]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
...

Adding a newline (as the patch below does) turns this into

...
Device `[PEB1]' is not power manageable
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
Device `[PEB2]' is not power manageable
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
...

Which is much nicer :-)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/bus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc1-orig/drivers/acpi/bus.c	2006-07-06 19:39:29.000000000 +0200
+++ linux-2.6.18-rc1/drivers/acpi/bus.c	2006-07-06 23:23:12.000000000 +0200
@@ -192,7 +192,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable\n",
 				device->kobj.name);
 		return -ENODEV;
 	}



