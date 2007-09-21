From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]:ACPI Using the ACPI status code in function of
	hpet_resources
Date: Fri, 21 Sep 2007 12:52:19 +0800
Message-ID: <1190350339.4102.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21198 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbXIUEq1 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 00:46:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Linux-acpi@vger.kernel.org

Subject: ACPI: Using the ACPI status code in function of hpet_resources
From: Zhao Yakui  <yakui.zhao@intel.com>

If hpet has been initialized before registering hpet driver, the callback 
function of hpet_resources will return the status code of -EBUSY, which
is not defined in the ACPI exception table.So when ACPI checks the status
code of callback function, it will report the unknown exception code.

So the ACPI status code is used instead of the generic error code in
the ACPI callback function of hpet_resources.
For example: -EBUSY is replaced by AE_ALREADY_EXISTS
             -EINVAL is replaced by AE_NO_MEMORY

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
---
 drivers/char/hpet.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc6/drivers/char/hpet.c
===================================================================
--- linux-2.6.23-rc6.orig/drivers/char/hpet.c
+++ linux-2.6.23-rc6/drivers/char/hpet.c
@@ -943,14 +943,14 @@ static acpi_status hpet_resources(struct
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
 				__FUNCTION__, hdp->hd_phys_address);
 			iounmap(hdp->hd_address);
-			return -EBUSY;
+			return AE_ALREADY_EXISTS;
 		}
 	} else if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
 		struct acpi_resource_fixed_memory32 *fixmem32;
 
 		fixmem32 = &res->data.fixed_memory32;
 		if (!fixmem32)
-			return -EINVAL;
+			return AE_NO_MEMORY;
 
 		hdp->hd_phys_address = fixmem32->address;
 		hdp->hd_address = ioremap(fixmem32->address,
@@ -960,7 +960,7 @@ static acpi_status hpet_resources(struct
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
 				__FUNCTION__, hdp->hd_phys_address);
 			iounmap(hdp->hd_address);
-			return -EBUSY;
+			return AE_ALREADY_EXISTS;
 		}
 	} else if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
 		struct acpi_resource_extended_irq *irqp;
