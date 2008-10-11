From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/85] PNP: convert the last few pnp_info() uses to printk()
Date: Sat, 11 Oct 2008 02:36:23 -0400
Message-ID: <c865d2f6eb160c15b74245b4891c8e945d67d96c.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40791 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbYJKGhi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:38 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

There are only a few remaining uses of pnp_info(), so I just
converted them to printk and removed the pnp_err(), pnp_info(),
pnp_warn(), and pnp_dbg() wrappers.

I also removed a couple debug messages that don't seem useful any
more ("driver registered", "driver unregistered", "driver attached").

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/driver.c       |    4 ----
 drivers/pnp/pnpacpi/core.c |    6 +++---
 include/linux/pnp.h        |   10 ----------
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index d3f869e..54673a4 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -114,7 +114,6 @@ static int pnp_device_probe(struct device *dev)
 	} else
 		goto fail;
 
-	dev_dbg(dev, "driver attached\n");
 	return error;
 
 fail:
@@ -210,8 +209,6 @@ struct bus_type pnp_bus_type = {
 
 int pnp_register_driver(struct pnp_driver *drv)
 {
-	pnp_dbg("the driver '%s' has been registered", drv->name);
-
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pnp_bus_type;
 
@@ -221,7 +218,6 @@ int pnp_register_driver(struct pnp_driver *drv)
 void pnp_unregister_driver(struct pnp_driver *drv)
 {
 	driver_unregister(&drv->driver);
-	pnp_dbg("the driver '%s' has been unregistered", drv->name);
 }
 
 /**
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index c1b9ea3..67c651b 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -255,14 +255,14 @@ int pnpacpi_disabled __initdata;
 static int __init pnpacpi_init(void)
 {
 	if (acpi_disabled || pnpacpi_disabled) {
-		pnp_info("PnP ACPI: disabled");
+		printk(KERN_INFO "pnp: PnP ACPI: disabled\n");
 		return 0;
 	}
-	pnp_info("PnP ACPI init");
+	printk(KERN_INFO "pnp: PnP ACPI init\n");
 	pnp_register_protocol(&pnpacpi_protocol);
 	register_acpi_bus_type(&acpi_pnp_bus);
 	acpi_get_devices(NULL, pnpacpi_add_device_handler, NULL, NULL);
-	pnp_info("PnP ACPI: found %d devices", num);
+	printk(KERN_INFO "pnp: PnP ACPI: found %d devices\n", num);
 	unregister_acpi_bus_type(&acpi_pnp_bus);
 	pnp_platform_devices = 1;
 	return 0;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index be764e5..05daece 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -483,14 +483,4 @@ static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 
 #endif /* CONFIG_PNP */
 
-#define pnp_err(format, arg...) printk(KERN_ERR "pnp: " format "\n" , ## arg)
-#define pnp_info(format, arg...) printk(KERN_INFO "pnp: " format "\n" , ## arg)
-#define pnp_warn(format, arg...) printk(KERN_WARNING "pnp: " format "\n" , ## arg)
-
-#ifdef CONFIG_PNP_DEBUG
-#define pnp_dbg(format, arg...) printk(KERN_DEBUG "pnp: " format "\n" , ## arg)
-#else
-#define pnp_dbg(format, arg...) do {} while (0)
-#endif
-
 #endif /* _LINUX_PNP_H */
-- 
1.5.5.1

