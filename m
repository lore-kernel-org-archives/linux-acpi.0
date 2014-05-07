From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] Revert "ACPI / AC: convert ACPI ac driver to platform bus"
Date: Tue,  6 May 2014 19:18:28 -0700
Message-ID: <1399429108-15395-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:43779 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaEGCSj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2014 22:18:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so402154pab.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 May 2014 19:18:39 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, Manuel Krause <manuelkrause@netscape.net>

This reverts commit cc8ef52707341e67a12067d6ead991d56ea017ca.

This is an attempt to fix (or at least track down)
https://bugzilla.kernel.org/show_bug.cgi?id=71711.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Conflicts:
	drivers/acpi/ac.c
	drivers/acpi/acpi_platform.c
---
Compile tested only.
It might make sense to test this in a VM (if that is possible)
before running it on a real system.

 drivers/acpi/ac.c            | 117 +++++++++++++++++++++----------------------
 drivers/acpi/acpi_platform.c |   1 -
 2 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2c01c1d..c67f6f5 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -52,11 +52,39 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
+static int acpi_ac_add(struct acpi_device *device);
+static int acpi_ac_remove(struct acpi_device *device);
+static void acpi_ac_notify(struct acpi_device *device, u32 event);
+
+static const struct acpi_device_id ac_device_ids[] = {
+	{"ACPI0003", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, ac_device_ids);
+
+#ifdef CONFIG_PM_SLEEP
+static int acpi_ac_resume(struct device *dev);
+#endif
+static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
+
 static int ac_sleep_before_get_state_ms;
 
+static struct acpi_driver acpi_ac_driver = {
+	.name = "ac",
+	.class = ACPI_AC_CLASS,
+	.ids = ac_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
+	.ops = {
+		.add = acpi_ac_add,
+		.remove = acpi_ac_remove,
+		.notify = acpi_ac_notify,
+		},
+	.drv.pm = &acpi_ac_pm,
+};
+
 struct acpi_ac {
 	struct power_supply charger;
-	struct platform_device *pdev;
+	struct acpi_device * device;
 	unsigned long long state;
 	struct notifier_block battery_nb;
 };
@@ -69,10 +97,12 @@ struct acpi_ac {
 
 static int acpi_ac_get_state(struct acpi_ac *ac)
 {
-	acpi_status status;
-	acpi_handle handle = ACPI_HANDLE(&ac->pdev->dev);
+	acpi_status status = AE_OK;
+
+	if (!ac)
+		return -EINVAL;
 
-	status = acpi_evaluate_integer(handle, "_PSR", NULL,
+	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
@@ -117,10 +147,9 @@ static enum power_supply_property ac_props[] = {
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-static void acpi_ac_notify_handler(acpi_handle handle, u32 event, void *data)
+static void acpi_ac_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_ac *ac = data;
-	struct acpi_device *adev;
+	struct acpi_ac *ac = acpi_driver_data(device);
 
 	if (!ac)
 		return;
@@ -143,11 +172,10 @@ static void acpi_ac_notify_handler(acpi_handle handle, u32 event, void *data)
 			msleep(ac_sleep_before_get_state_ms);
 
 		acpi_ac_get_state(ac);
-		adev = ACPI_COMPANION(&ac->pdev->dev);
-		acpi_bus_generate_netlink_event(adev->pnp.device_class,
-						dev_name(&ac->pdev->dev),
-						event, (u32) ac->state);
-		acpi_notifier_call_chain(adev, event, (u32) ac->state);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event,
+						  (u32) ac->state);
+		acpi_notifier_call_chain(device, event, (u32) ac->state);
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 	}
 
@@ -192,49 +220,39 @@ static struct dmi_system_id ac_dmi_table[] = {
 	{},
 };
 
-static int acpi_ac_probe(struct platform_device *pdev)
+static int acpi_ac_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_ac *ac = NULL;
-	struct acpi_device *adev;
 
-	if (!pdev)
-		return -EINVAL;
 
-	adev = ACPI_COMPANION(&pdev->dev);
-	if (!adev)
-		return -ENODEV;
+	if (!device)
+		return -EINVAL;
 
 	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
 
-	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
-	ac->pdev = pdev;
-	platform_set_drvdata(pdev, ac);
+	ac->device = device;
+	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
+	device->driver_data = ac;
 
 	result = acpi_ac_get_state(ac);
 	if (result)
 		goto end;
 
-	ac->charger.name = acpi_device_bid(adev);
+	ac->charger.name = acpi_device_bid(device);
 	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
-	result = power_supply_register(&pdev->dev, &ac->charger);
+	result = power_supply_register(&ac->device->dev, &ac->charger);
 	if (result)
 		goto end;
 
-	result = acpi_install_notify_handler(ACPI_HANDLE(&pdev->dev),
-			ACPI_ALL_NOTIFY, acpi_ac_notify_handler, ac);
-	if (result) {
-		power_supply_unregister(&ac->charger);
-		goto end;
-	}
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
-	       acpi_device_name(adev), acpi_device_bid(adev),
+	       acpi_device_name(device), acpi_device_bid(device),
 	       ac->state ? "on-line" : "off-line");
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
@@ -256,7 +274,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (!dev)
 		return -EINVAL;
 
-	ac = platform_get_drvdata(to_platform_device(dev));
+	ac = acpi_driver_data(to_acpi_device(dev));
 	if (!ac)
 		return -EINVAL;
 
@@ -270,19 +288,17 @@ static int acpi_ac_resume(struct device *dev)
 #else
 #define acpi_ac_resume NULL
 #endif
-static SIMPLE_DEV_PM_OPS(acpi_ac_pm_ops, NULL, acpi_ac_resume);
 
-static int acpi_ac_remove(struct platform_device *pdev)
+static int acpi_ac_remove(struct acpi_device *device)
 {
-	struct acpi_ac *ac;
+	struct acpi_ac *ac = NULL;
+
 
-	if (!pdev)
+	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
-			ACPI_ALL_NOTIFY, acpi_ac_notify_handler);
+	ac = acpi_driver_data(device);
 
-	ac = platform_get_drvdata(pdev);
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
@@ -292,23 +308,6 @@ static int acpi_ac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id acpi_ac_match[] = {
-	{ "ACPI0003", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, acpi_ac_match);
-
-static struct platform_driver acpi_ac_driver = {
-	.probe          = acpi_ac_probe,
-	.remove         = acpi_ac_remove,
-	.driver         = {
-		.name   = "acpi-ac",
-		.owner  = THIS_MODULE,
-		.pm     = &acpi_ac_pm_ops,
-		.acpi_match_table = ACPI_PTR(acpi_ac_match),
-	},
-};
-
 static int __init acpi_ac_init(void)
 {
 	int result;
@@ -316,7 +315,7 @@ static int __init acpi_ac_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	result = platform_driver_register(&acpi_ac_driver);
+	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0)
 		return -ENODEV;
 
@@ -325,7 +324,7 @@ static int __init acpi_ac_init(void)
 
 static void __exit acpi_ac_exit(void)
 {
-	platform_driver_unregister(&acpi_ac_driver);
+	acpi_bus_unregister_driver(&acpi_ac_driver);
 }
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index dbfe49e..1d49503 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -29,7 +29,6 @@ ACPI_MODULE_NAME("platform");
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
-	{ "ACPI0003" },
 	{ "VPC2004" },
 	{ "BCM4752" },
 
-- 
1.9.1

