Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445A2E8B6B;
	Tue, 24 Mar 2026 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382606; cv=none; b=NAcHgDL6DWdqEJ/oDEXaNO7+EHbpsMRsGu0qIwQV1ePx5C7UNWpTt27GklZKiPc7FCqCRWOh8vlf7f+9BytVlcRe9id62xujM2d36cUoLlo6QZ8ilJwiiIvt0nG3WP2iKedw5uk/+LqaZYrr9qUgltdmCrU4DnOQ3B+NQBMi74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382606; c=relaxed/simple;
	bh=x5t1xPnj3o3XCZMpvJ0Zk6gLOtGTVSs/d6xDj9x+gAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuS3f5hUfoU0jEY5H/XAmq5tTy02+TDMHqLTjpF5sXDnAAtLeayHlt1tsv8UN5WspMAkwUaZGbgMf6HR2fH+7g99tIGiiBxRxtcJ+UnDsq5VbL3B9uMDxpbTSeUHOkoO1I5Qh0sM+dCkXV06rcrFtNSfMVnoVLC0JLdDX8SBbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlqitMXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlqitMXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C10C2BCB2;
	Tue, 24 Mar 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382606;
	bh=x5t1xPnj3o3XCZMpvJ0Zk6gLOtGTVSs/d6xDj9x+gAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlqitMXaottQWh/mmUaLjXXoeTYddI+/DIGWdWX3eAlPdxaEUmucBn2G89yrfPuW2
	 +PGQJwXhkANbUhq2E1XN2kvLmPT5VijZ2+J4Gt1JEXvwlQ0KRdMU8ucujIIf4gKLsd
	 nEwEzxoKLlW5ExXyeMxkFyiVCs5Vd13If3Grv6zN1LfkUgQFc6TJFYSL4LweNtvphJ
	 g1+iMvPE0XWAB7Q8XpgofVU2zd0xZ9rvpj4GsIOKnxsmQvro+LUNINtcS2Hb6XPmsM
	 sknaKbSSMusuiB8A5cviLOZLydwdGzLLGP4Ye0eBZITL2ALid1dnn40ZJZOby3iayr
	 JBm9ue+iXnB/Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 5/7] platform/x86: toshiba_bluetooth: Convert ACPI driver to a
 platform one
Date: Tue, 24 Mar 2026 21:01:28 +0100
Message-ID: <3420881.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
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
ACPI companions, so convert the Toshiba Bluetooth Enable driver from an
ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_bluetooth.c | 42 ++++++++++++------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index 3824c2beaf11..e50d4fc1e603 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/acpi.h>
 #include <linux/rfkill.h>
+#include <linux/platform_device.h>
 
 #define BT_KILLSWITCH_MASK	0x01
 #define BT_PLUGGED_MASK		0x40
@@ -35,8 +36,8 @@ struct toshiba_bluetooth_dev {
 	bool powered;
 };
 
-static int toshiba_bt_rfkill_add(struct acpi_device *device);
-static void toshiba_bt_rfkill_remove(struct acpi_device *device);
+static int toshiba_bt_rfkill_probe(struct platform_device *pdev);
+static void toshiba_bt_rfkill_remove(struct platform_device *pdev);
 static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id bt_device_ids[] = {
@@ -50,15 +51,14 @@ static int toshiba_bt_resume(struct device *dev);
 #endif
 static SIMPLE_DEV_PM_OPS(toshiba_bt_pm, NULL, toshiba_bt_resume);
 
-static struct acpi_driver toshiba_bt_rfkill_driver = {
-	.name =		"Toshiba BT",
-	.class =	"Toshiba",
-	.ids =		bt_device_ids,
-	.ops =		{
-				.add =		toshiba_bt_rfkill_add,
-				.remove =	toshiba_bt_rfkill_remove,
-			},
-	.drv.pm =	&toshiba_bt_pm,
+static struct platform_driver toshiba_bt_rfkill_driver = {
+	.probe = toshiba_bt_rfkill_probe,
+	.remove = toshiba_bt_rfkill_remove,
+	.driver = {
+		.name = "Toshiba BT",
+		.acpi_match_table = bt_device_ids,
+		.pm = &toshiba_bt_pm,
+	},
 };
 
 static int toshiba_bluetooth_present(acpi_handle handle)
@@ -215,11 +215,9 @@ static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_PM_SLEEP
 static int toshiba_bt_resume(struct device *dev)
 {
-	struct toshiba_bluetooth_dev *bt_dev;
+	struct toshiba_bluetooth_dev *bt_dev = dev_get_drvdata(dev);
 	int ret;
 
-	bt_dev = acpi_driver_data(to_acpi_device(dev));
-
 	ret = toshiba_bluetooth_sync_status(bt_dev);
 	if (ret)
 		return ret;
@@ -230,8 +228,9 @@ static int toshiba_bt_resume(struct device *dev)
 }
 #endif
 
-static int toshiba_bt_rfkill_add(struct acpi_device *device)
+static int toshiba_bt_rfkill_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct toshiba_bluetooth_dev *bt_dev;
 	int result;
 
@@ -245,8 +244,8 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	if (!bt_dev)
 		return -ENOMEM;
 	bt_dev->acpi_dev = device;
-	device->driver_data = bt_dev;
-	dev_set_drvdata(&device->dev, bt_dev);
+
+	platform_set_drvdata(pdev, bt_dev);
 
 	result = toshiba_bluetooth_sync_status(bt_dev);
 	if (result) {
@@ -255,7 +254,7 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	}
 
 	bt_dev->rfk = rfkill_alloc("Toshiba Bluetooth",
-				   &device->dev,
+				   &pdev->dev,
 				   RFKILL_TYPE_BLUETOOTH,
 				   &rfk_ops,
 				   bt_dev);
@@ -291,9 +290,10 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	return result;
 }
 
-static void toshiba_bt_rfkill_remove(struct acpi_device *device)
+static void toshiba_bt_rfkill_remove(struct platform_device *pdev)
 {
-	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
+	struct toshiba_bluetooth_dev *bt_dev = platform_get_drvdata(pdev);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 	/* clean up */
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
@@ -309,4 +309,4 @@ static void toshiba_bt_rfkill_remove(struct acpi_device *device)
 	toshiba_bluetooth_disable(device->handle);
 }
 
-module_acpi_driver(toshiba_bt_rfkill_driver);
+module_platform_driver(toshiba_bt_rfkill_driver);
-- 
2.51.0




