From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/2] ACPI: EC: Fall back to DSDT scan if ECDT is broken
Date: Tue, 21 Aug 2007 17:22:59 +0400
Message-ID: <46CAE733.1010109@suse.de>
References: <46CAE65E.3000703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:46335 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759381AbXHUNXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 09:23:10 -0400
In-Reply-To: <46CAE65E.3000703@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Try to recover boot EC init in case of broken ECDT (bug #8651).

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 33afcd1..ce9e97a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -864,17 +864,20 @@ int __init acpi_ec_ecdt_probe(void)
         boot_ec->data_addr = ecdt_ptr->data.address;
         boot_ec->gpe = ecdt_ptr->gpe;
         status = acpi_get_handle(NULL, ecdt_ptr->id, &boot_ec->handle);
-        if (ACPI_FAILURE(status))
+        if (ACPI_FAILURE(status)) {
+            printk(KERN_ERR PREFIX "ECDT is broken\n");
             goto error;
+        }
         ec_complete_parse_device(boot_ec);
-    } else {
+    }
+    if (ACPI_FAILURE(status)) {
+        /* Try to recover boot_ec init */
         printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
         status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
-                        boot_ec, NULL);
+                      boot_ec, NULL);
         if (ACPI_FAILURE(status))
             goto error;
     }
-
     ret = ec_install_handlers(boot_ec);
     if (!ret) {
         first_ec = boot_ec;

