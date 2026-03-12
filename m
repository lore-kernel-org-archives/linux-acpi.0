Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB962D3225;
	Thu, 12 Mar 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313573; cv=none; b=mTvYoTS4MQ6qPTL09wkB0mxu8GsVLY1+nDcM7QYtgLuD65e2eXlmwma2+NeufqmiRkvVFLLzKYdJtW5MYjkfmt6KEOhShF0EXs4emI44dCy/jC5QZAdt+r2qhVrzl3JfMSM22fgshyW0Od+uZqE/65K701wTMXTvayrohZfhOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313573; c=relaxed/simple;
	bh=b0Mh4ewbTJJileHDaNe1epZKDNHJn6T8z1blCzC1uro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbElx4vpBHIn/Mz24ELOe6jG/FLV2By370al+h8DhPxHwkvNH18FGdrqO+l8E9gyaicIIepdvpDL9yixEANvCN1hoXIREL5TRf+uqqJ/0Mppcliv5NgiRvXiFp0BpAxrOV+LQaxYZPiF5S7BIVkhsPSikq15TqtILK2NUhYPG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRXWB5aO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRXWB5aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C35C4CEF7;
	Thu, 12 Mar 2026 11:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773313572;
	bh=b0Mh4ewbTJJileHDaNe1epZKDNHJn6T8z1blCzC1uro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRXWB5aOy2UwEUbFNsalsRyxaOso8t4DHFPB0db02BcGthsdQ/2dGdB90VVmJrRek
	 tMhIMxafzg9s+fDR0kjEm3PDW+RAqFsnJuxF+EohjuHTGtlv2VVc4juS4NEzBAoAQ2
	 QzezKdqSYW25W4C2X3G0enW08cGvJYqLoX5D0XoQqYME6su9CLYQnWf0LbVCLX7tK9
	 0Hl11fUDozV2faEG7B3sCT6a7e13tEXneZbCCmbfrimaheQeEv9XVocFbI5qdEm3N9
	 KdiFeIUy/jqEIhyKe1Avh/p6JUHZ6N43oqY7AttlVlGErNQW5AfDPAx4vvrimH6+U/
	 UwbBdMz3I1fng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject:
 [PATCH v1 2/2] platform/x86: dell/dell-rbtn: Convert ACPI driver to a
 platform one
Date: Thu, 12 Mar 2026 12:05:52 +0100
Message-ID: <3416389.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5071411.GXAFRqVoOG@rafael.j.wysocki>
References: <5071411.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Dell Airplane Mode Switch (rbtn) ACPI
driver to a platform one.

After this change, the subordinate rfkill device will be registered
under the platform device used for driver binding instead of its ACPI
companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/dell/dell-rbtn.c | 108 +++++++++++++-------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index 9271b27abb46..6e294b612488 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/rfkill.h>
 #include <linux/input.h>
+#include <linux/platform_device.h>
 
 #include "dell-rbtn.h"
 
@@ -109,9 +110,9 @@ static const struct rfkill_ops rbtn_ops = {
 	.set_block = rbtn_rfkill_set_block,
 };
 
-static int rbtn_rfkill_init(struct acpi_device *device)
+static int rbtn_rfkill_init(struct device *dev)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 	int ret;
 
 	if (rbtn_data->rfkill)
@@ -122,8 +123,8 @@ static int rbtn_rfkill_init(struct acpi_device *device)
 	 *       but rfkill interface does not support "ANY" type
 	 *       so "WLAN" type is used
 	 */
-	rbtn_data->rfkill = rfkill_alloc("dell-rbtn", &device->dev,
-					 RFKILL_TYPE_WLAN, &rbtn_ops, device);
+	rbtn_data->rfkill = rfkill_alloc("dell-rbtn", dev, RFKILL_TYPE_WLAN,
+					 &rbtn_ops, ACPI_COMPANION(dev));
 	if (!rbtn_data->rfkill)
 		return -ENOMEM;
 
@@ -137,9 +138,9 @@ static int rbtn_rfkill_init(struct acpi_device *device)
 	return 0;
 }
 
-static void rbtn_rfkill_exit(struct acpi_device *device)
+static void rbtn_rfkill_exit(struct device *dev)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 
 	if (!rbtn_data->rfkill)
 		return;
@@ -149,12 +150,12 @@ static void rbtn_rfkill_exit(struct acpi_device *device)
 	rbtn_data->rfkill = NULL;
 }
 
-static void rbtn_rfkill_event(struct acpi_device *device)
+static void rbtn_rfkill_event(struct device *dev)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 
 	if (rbtn_data->rfkill)
-		rbtn_rfkill_query(rbtn_data->rfkill, device);
+		rbtn_rfkill_query(rbtn_data->rfkill, ACPI_COMPANION(dev));
 }
 
 
@@ -205,8 +206,8 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
  * acpi driver
  */
 
-static int rbtn_add(struct acpi_device *device);
-static void rbtn_remove(struct acpi_device *device);
+static int rbtn_probe(struct platform_device *pdev);
+static void rbtn_remove(struct platform_device *pdev);
 static void rbtn_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id rbtn_ids[] = {
@@ -251,8 +252,7 @@ static void ACPI_SYSTEM_XFACE rbtn_clear_suspended_flag(void *context)
 
 static int rbtn_suspend(struct device *dev)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct rbtn_data *rbtn_data = acpi_driver_data(device);
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 
 	rbtn_data->suspended = true;
 
@@ -261,8 +261,7 @@ static int rbtn_suspend(struct device *dev)
 
 static int rbtn_resume(struct device *dev)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct rbtn_data *rbtn_data = acpi_driver_data(device);
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 	acpi_status status;
 
 	/*
@@ -286,13 +285,13 @@ static int rbtn_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rbtn_pm_ops, rbtn_suspend, rbtn_resume);
 
-static struct acpi_driver rbtn_driver = {
-	.name = "dell-rbtn",
-	.ids = rbtn_ids,
-	.drv.pm = &rbtn_pm_ops,
-	.ops = {
-		.add = rbtn_add,
-		.remove = rbtn_remove,
+static struct platform_driver rbtn_driver = {
+	.probe = rbtn_probe,
+	.remove = rbtn_remove,
+	.driver = {
+		.name = "dell-rbtn",
+		.acpi_match_table = rbtn_ids,
+		.pm = &rbtn_pm_ops,
 	},
 };
 
@@ -307,8 +306,7 @@ static ATOMIC_NOTIFIER_HEAD(rbtn_chain_head);
 
 static int rbtn_inc_count(struct device *dev, void *data)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 	int *count = data;
 
 	if (rbtn_data->type == RBTN_SLIDER)
@@ -319,17 +317,16 @@ static int rbtn_inc_count(struct device *dev, void *data)
 
 static int rbtn_switch_dev(struct device *dev, void *data)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 	bool enable = data;
 
 	if (rbtn_data->type != RBTN_SLIDER)
 		return 0;
 
 	if (enable)
-		rbtn_rfkill_init(device);
+		rbtn_rfkill_init(dev);
 	else
-		rbtn_rfkill_exit(device);
+		rbtn_rfkill_exit(dev);
 
 	return 0;
 }
@@ -341,7 +338,7 @@ int dell_rbtn_notifier_register(struct notifier_block *nb)
 	int ret;
 
 	count = 0;
-	ret = driver_for_each_device(&rbtn_driver.drv, NULL, &count,
+	ret = driver_for_each_device(&rbtn_driver.driver, NULL, &count,
 				     rbtn_inc_count);
 	if (ret || count == 0)
 		return -ENODEV;
@@ -353,7 +350,7 @@ int dell_rbtn_notifier_register(struct notifier_block *nb)
 		return ret;
 
 	if (auto_remove_rfkill && first)
-		ret = driver_for_each_device(&rbtn_driver.drv, NULL,
+		ret = driver_for_each_device(&rbtn_driver.driver, NULL,
 					     (void *)false, rbtn_switch_dev);
 
 	return ret;
@@ -369,7 +366,7 @@ int dell_rbtn_notifier_unregister(struct notifier_block *nb)
 		return ret;
 
 	if (auto_remove_rfkill && !rbtn_chain_head.head)
-		ret = driver_for_each_device(&rbtn_driver.drv, NULL,
+		ret = driver_for_each_device(&rbtn_driver.driver, NULL,
 					     (void *)true, rbtn_switch_dev);
 
 	return ret;
@@ -381,46 +378,48 @@ EXPORT_SYMBOL_GPL(dell_rbtn_notifier_unregister);
  * acpi driver functions
  */
 
-static void rbtn_cleanup(struct acpi_device *device)
+static void rbtn_cleanup(struct device *dev)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 
 	switch (rbtn_data->type) {
 	case RBTN_TOGGLE:
 		rbtn_input_exit(rbtn_data);
 		break;
 	case RBTN_SLIDER:
-		rbtn_rfkill_exit(device);
+		rbtn_rfkill_exit(dev);
 		break;
 	default:
 		break;
 	}
 }
 
-static int rbtn_add(struct acpi_device *device)
+static int rbtn_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct rbtn_data *rbtn_data;
 	enum rbtn_type type;
 	int ret = 0;
 
 	type = rbtn_check(device);
 	if (type == RBTN_UNKNOWN) {
-		dev_info(&device->dev, "Unknown device type\n");
+		dev_info(&pdev->dev, "Unknown device type\n");
 		return -EINVAL;
 	}
 
-	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
+	rbtn_data = devm_kzalloc(&pdev->dev, sizeof(*rbtn_data), GFP_KERNEL);
 	if (!rbtn_data)
 		return -ENOMEM;
 
 	ret = rbtn_acquire(device, true);
 	if (ret < 0) {
-		dev_err(&device->dev, "Cannot enable device\n");
+		dev_err(&pdev->dev, "Cannot enable device\n");
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, rbtn_data);
+
 	rbtn_data->type = type;
-	device->driver_data = rbtn_data;
 
 	switch (rbtn_data->type) {
 	case RBTN_TOGGLE:
@@ -430,7 +429,7 @@ static int rbtn_add(struct acpi_device *device)
 		if (auto_remove_rfkill && rbtn_chain_head.head)
 			ret = 0;
 		else
-			ret = rbtn_rfkill_init(device);
+			ret = rbtn_rfkill_init(&pdev->dev);
 		break;
 	default:
 		ret = -EINVAL;
@@ -440,9 +439,9 @@ static int rbtn_add(struct acpi_device *device)
 		goto err;
 
 	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      rbtn_notify, device);
+					      rbtn_notify, &pdev->dev);
 	if (ret) {
-		rbtn_cleanup(device);
+		rbtn_cleanup(&pdev->dev);
 		goto err;
 	}
 
@@ -453,29 +452,31 @@ static int rbtn_add(struct acpi_device *device)
 	return ret;
 }
 
-static void rbtn_remove(struct acpi_device *device)
+static void rbtn_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
-	rbtn_cleanup(device);
+	rbtn_cleanup(&pdev->dev);
 	rbtn_acquire(device, false);
 }
 
 static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct device *dev = data;
+	struct rbtn_data *rbtn_data = dev_get_drvdata(dev);
 
 	/*
 	 * Some BIOSes send a notification at resume.
 	 * Ignore it to prevent unwanted input events.
 	 */
 	if (rbtn_data->suspended) {
-		dev_dbg(&device->dev, "ACPI notification ignored\n");
+		dev_dbg(dev, "ACPI notification ignored\n");
 		return;
 	}
 
 	if (event != 0x80) {
-		dev_info(&device->dev, "Received unknown event (0x%x)\n",
+		dev_info(dev, "Received unknown event (0x%x)\n",
 			 event);
 		return;
 	}
@@ -485,20 +486,15 @@ static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 		rbtn_input_event(rbtn_data);
 		break;
 	case RBTN_SLIDER:
-		rbtn_rfkill_event(device);
-		atomic_notifier_call_chain(&rbtn_chain_head, event, device);
+		rbtn_rfkill_event(dev);
+		atomic_notifier_call_chain(&rbtn_chain_head, event, NULL);
 		break;
 	default:
 		break;
 	}
 }
 
-
-/*
- * module functions
- */
-
-module_acpi_driver(rbtn_driver);
+module_platform_driver(rbtn_driver);
 
 module_param(auto_remove_rfkill, bool, 0444);
 
-- 
2.51.0




