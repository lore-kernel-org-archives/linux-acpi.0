Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027762D6E55;
	Sat, 28 Feb 2026 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291596; cv=none; b=hw10oRCKbRqvioEP8/ZqxfFF/99wxTLhEbtX5d0DAqVGXSWiT4/OyFK9X7IUK5wyaxJANJARV2QCgao4ZeHOvxn9AGDs7ec9gxq4aoYHjV+5nI30WBCTb6xbzlKDHWBYXdi7tZU561d3+6O0v/eWyCuSKmUbmNe1Li6fXyE1xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291596; c=relaxed/simple;
	bh=/c0LZcZy6rY1nM/T9/mj2hk8GqXrleWHnG/94I9mQD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUitu9WDxLndS6x67AXF7v4HCfddXcdIaGVkRzqT5MXoXGVG/haHYs82s2pH4CWY8FVfhnKmlKps8vvKq74hmUoroBG/FeiQ/3niLyQuIvIQamWgmpa7D9x5bx2mIoGpHB1m3TRTjG7FAGXHyuFGrN9JHB1Fx4NYu/nK8A95uU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhrG/zAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhrG/zAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF599C19421;
	Sat, 28 Feb 2026 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291595;
	bh=/c0LZcZy6rY1nM/T9/mj2hk8GqXrleWHnG/94I9mQD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhrG/zAQtdkmk9+HVv2VxJ9hKFJ5VR9uhbA3JrTfiPZYF+LdDksSNu5tVXuTP6I++
	 P6zcnf808TTll4NCv0y3MXrYJkvAsxplt/RqxoPxxcZdogShTu4S30BgU9qFroh7HX
	 wxKC/KFVieUIzIogDbqaP/G7pLOmg0tEWpe17ZrYiuspxR23548bZOL829K8qyGLry
	 a+kidvQ6DirJyurxhyRNIOpIX53qNgprODPf7ZZjh5cf0duhM/UNvrDc61mUI+OzUs
	 YhVM8xcH97sKpQ6iMqajHhSrdCeXbFTyh6B2tT9HETRPX4ZbpNsE2OS7BLxjBHHn3l
	 dBV3/wYyfynuQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject:
 [PATCH v1 3/4] platform/x86: asus-wireless: Register ACPI notify handler
 directly
Date: Sat, 28 Feb 2026 16:12:02 +0100
Message-ID: <1949745.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5971620.DvuYhMxLoT@rafael.j.wysocki>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/asus-wireless.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index 41227bf95878..45d41875c515 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -108,9 +108,10 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
 	queue_work(data->wq, &data->led_work);
 }
 
-static void asus_wireless_notify(struct acpi_device *adev, u32 event)
+static void asus_wireless_notify(acpi_handle handle, u32 event, void *context)
 {
-	struct asus_wireless_data *data = acpi_driver_data(adev);
+	struct asus_wireless_data *data = context;
+	struct acpi_device *adev = data->adev;
 
 	dev_dbg(&adev->dev, "event=%#x\n", event);
 	if (event != 0x88) {
@@ -166,8 +167,18 @@ static int asus_wireless_add(struct acpi_device *adev)
 	data->led.default_trigger = "rfkill-none";
 	err = devm_led_classdev_register(&adev->dev, &data->led);
 	if (err)
-		destroy_workqueue(data->wq);
+		goto err;
+
+	err = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					      asus_wireless_notify, data);
+	if (err) {
+		devm_led_classdev_unregister(&adev->dev, &data->led);
+		goto err;
+	}
+	return 0;
 
+err:
+	destroy_workqueue(data->wq);
 	return err;
 }
 
@@ -175,6 +186,8 @@ static void asus_wireless_remove(struct acpi_device *adev)
 {
 	struct asus_wireless_data *data = acpi_driver_data(adev);
 
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       asus_wireless_notify);
 	if (data->wq) {
 		devm_led_classdev_unregister(&adev->dev, &data->led);
 		destroy_workqueue(data->wq);
@@ -188,7 +201,6 @@ static struct acpi_driver asus_wireless_driver = {
 	.ops = {
 		.add = asus_wireless_add,
 		.remove = asus_wireless_remove,
-		.notify = asus_wireless_notify,
 	},
 };
 module_acpi_driver(asus_wireless_driver);
-- 
2.51.0




