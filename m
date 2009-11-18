From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1] [RFC] ipmi: support for AML access to IPMI via opregion
Date: Tue, 17 Nov 2009 17:24:10 -0700
Message-ID: <20091118002410.20840.64771.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:26116 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbZKRAYG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 19:24:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

This is just a sample of how I think we might be able to connect the ACPI
opregion support with the IPMI hardware driver in ipmi_si_intf.c.  The idea
is that whenever ipmi_si_intf.c finds an interface in the namespace, it
calls the opregion "acpi_ipmi_add()" function, which registers the opregion
handler.

This applies on top of my previous patch series and your "Add the IPMI
opregion driver" patch.

The opregion support doesn't talk directly to the hardware (it doesn't touch
the I/O or MMIO resources and it doesn't field interrupts), so I don't think
it's quite right for this code to register directly as a driver for the IPMI
interface.

I don't have any way to test this, of course, but it does compile for me,
at least with the IPMI stuff compiled in statically.  If these were all
modules, I think we'd have to load them in this order:

    ipmi_msghandler
    ipmi (the opregion one; maybe needs a better name)
    ipmi_si (contains ipmi_si_intf.o, ipmi_kcs_sm.o, etc)

One issue is that this makes "ipmi" (the opregion piece) required -- since
ipmi_si_intf.c calls it directly, we can't load ipmi_si unless ipmi has
already been loaded.
---
 drivers/acpi/Kconfig             |    7 ++--
 drivers/acpi/ipmi.c              |   71 +++-----------------------------------
 drivers/char/ipmi/ipmi_si_intf.c |   10 +++++
 include/acpi/acpi_drivers.h      |    4 ++
 4 files changed, 23 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 23cd08a..fee5b3d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -211,11 +211,12 @@ config ACPI_IPMI
 	select IPMI_HANDLER
 	select IPMI_SI
 	help
-	  This driver enables the ACPI to access the BMC controller. And it
-	  uses the IPMI request/response message to communicate with BMC
-	  controller, which can be found on on the server.
+	  This driver enables ACPI AML access to the BMC controller.  It
+	  uses IPMI request/response messages to communicate with the BMC
+	  controller.
 
 	  To compile this driver as a module, choose M here:
+	  the module will be called ipmi.
 
 config ACPI_HOTPLUG_CPU
 	bool
diff --git a/drivers/acpi/ipmi.c b/drivers/acpi/ipmi.c
index 5c74936..205cb4b 100644
--- a/drivers/acpi/ipmi.c
+++ b/drivers/acpi/ipmi.c
@@ -56,7 +56,6 @@ MODULE_LICENSE("GPL");
 struct acpi_ipmi_device {
 	acpi_handle handle;
 	struct acpi_device *device;
-	int if_type;
 	/* the device list attached to driver_data.ipmi_devices */
 	struct list_head head;
 	ipmi_user_t 	user_interface;
@@ -454,40 +453,16 @@ static int ipmi_install_handlers(struct acpi_ipmi_device *ipmi)
 	return 0;
 }
 
-static int acpi_ipmi_add(struct acpi_device *device)
+int acpi_ipmi_add(struct acpi_device *device)
 {
 	struct acpi_ipmi_device *ipmi_device;
-	acpi_handle handle;
-	unsigned long long temp;
-	acpi_status status;
-	if (!device)
-		return -EINVAL;
 
-	handle = device->handle;
-	temp = 0;
-	status = acpi_evaluate_integer(handle, "_IFT", NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_DEBUG "Incorrect _IFT object for %s\n",
-				acpi_device_bid(device));
-		return -ENODEV;
-	}
 	ipmi_device = kzalloc(sizeof(struct acpi_ipmi_device), GFP_KERNEL);
 	if (!ipmi_device) {
 		printk(KERN_DEBUG "Can't allocate memory space\n");
 		return -ENOMEM;
 	}
-	ipmi_device->if_type = temp;
-	switch (ipmi_device->if_type) {
-	case 1:
-	case 2:
-	case 3:
-		break;
-	default:
-		printk(KERN_DEBUG "Unknow IPMI:SI interface type %d\n",
-				ipmi_device->if_type);
-		kfree(ipmi_device);
-		return -EINVAL;
-	}
+
 	ipmi_device->handle = device->handle;
 	ipmi_device->device = device;
 	mutex_init(&ipmi_device->mutex_lock);
@@ -505,8 +480,9 @@ static int acpi_ipmi_add(struct acpi_device *device)
 	device->driver_data = ipmi_device;
 	return 0;
 }
+EXPORT_SYMBOL(acpi_ipmi_add);
 
-static int acpi_ipmi_remove(struct acpi_device *device, int type)
+int acpi_ipmi_remove(struct acpi_device *device)
 {
 	struct acpi_ipmi_device *ipmi_device;
 
@@ -532,51 +508,16 @@ static int acpi_ipmi_remove(struct acpi_device *device, int type)
 	device->driver_data = NULL;
 	return 0;
 }
-
-static const struct acpi_device_id ipmi_device_ids[] = {
-	{"IPI0001", 0},
-	{"", 0},
-};
-
-static struct acpi_driver acpi_ipmi_driver = {
-	.name = "ipmi",
-	.class = ACPI_IPMI_CLASS,
-	.ids = ipmi_device_ids,
-	.ops = {
-		.add = acpi_ipmi_add,
-		.remove = acpi_ipmi_remove,
-		},
-};
+EXPORT_SYMBOL(acpi_ipmi_remove);
 
 static int __init acpi_ipmi_init(void)
 {
-	int result = 0;
-
-	if (acpi_disabled)
-		return result;
-
-	result = acpi_bus_register_driver(&acpi_ipmi_driver);
-
-	if (result)
-		return result;
-
-	result = ipmi_smi_watcher_register(&driver_data.bmc_events);
-
-	if (result)
-		acpi_bus_unregister_driver(&acpi_ipmi_driver);
-
-	return result;
+	return ipmi_smi_watcher_register(&driver_data.bmc_events);
 }
 
 static void __exit acpi_ipmi_exit(void)
 {
-	if (acpi_disabled)
-		return;
-
 	ipmi_smi_watcher_unregister(&driver_data.bmc_events);
-	acpi_bus_unregister_driver(&acpi_ipmi_driver);
-
-	return;
 }
 
 module_init(acpi_ipmi_init);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 679cd08..d0ab282 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1807,6 +1807,7 @@ static __devinit void hardcode_find_bmc(void)
 #ifdef CONFIG_ACPI
 
 #include <linux/acpi.h>
+#include <acpi/acpi_drivers.h>
 
 /*
  * Once we get an ACPI failure, we don't try any more, because we go
@@ -2033,6 +2034,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	acpi_handle handle;
 	acpi_status status;
 	unsigned long long tmp;
+	int ret;
 
 	acpi_dev = pnp_acpi_device(dev);
 	if (!acpi_dev)
@@ -2096,7 +2098,12 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	info->dev = &acpi_dev->dev;
 	pnp_set_drvdata(dev, info);
 
-	return try_smi_init(info);
+	ret = try_smi_init(info);
+	if (ret)
+		return ret;
+
+	acpi_ipmi_add(acpi_dev);
+	return 0;
 
 err_free:
 	kfree(info);
@@ -2107,6 +2114,7 @@ static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
 {
 	struct smi_info *info = pnp_get_drvdata(dev);
 
+	acpi_ipmi_remove(pnp_acpi_device(dev));
 	cleanup_one_si(info);
 }
 
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 0c0522f..ce88cb1 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -153,4 +153,8 @@ static inline void unregister_hotplug_dock_device(acpi_handle handle)
 }
 #endif
 
+/* IPMI opregion driver */
+extern int acpi_ipmi_add(struct acpi_device *device);
+extern int acpi_ipmi_remove(struct acpi_device *device);
+
 #endif /*__ACPI_DRIVERS_H__*/

