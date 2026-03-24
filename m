Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577242FD1B5;
	Tue, 24 Mar 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382622; cv=none; b=hXgHMGECxlzXjSPji2DRxJSjl61MkFPZOSOlWvwM6MbAadVWt+ZJ7wR+IdfR0rZsB63JHtp+xoS9rjT1ia62LB0+/B/RJ7D+EG0JqQqltMp/kSZuI903lnHjDf+Spf9KhJ9UrNWGmxlu9eAAZ0nNDZFHIsieEx1A+9nvq7ygw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382622; c=relaxed/simple;
	bh=Yt4AfLAEo9BJfkwOFL1UdrB3R4ayVT8ldQno/E2sL80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZV0Y91rbJR6M3UYTPr0nRpECdGACOoScQ1HWJ1/HpWLpwBw1wLDMP0XnJM0AlW6NrUqb49uVs8j3Tsaixw9wyLy5GMaQIn1iKvXeJfloZLfrc7QFQxazlGvTUn4awok6BjHmtaYuidm1jBqYZcJqleo5gDjOYwwbsztpkhQUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fum3DKmT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fum3DKmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1202C19424;
	Tue, 24 Mar 2026 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382622;
	bh=Yt4AfLAEo9BJfkwOFL1UdrB3R4ayVT8ldQno/E2sL80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fum3DKmTEgbpkrJ5u5EfqP7IPp7m2fov87c0xPPFxq4YiHqkp02gir1+Iwp25mdTk
	 zj8OgwBa5FVzRtec7hb6Dp80g/ytj8yd2wXTjFVYOFDH178RQl/jSijf5T3DNOTDb+
	 bqPLf34wUGhje02l6ZreEPSubAUTYkm7oidXaXMEKuA0FbO9ZfkCH/v9yDrsJ0KL00
	 /SZ2mpg0q2+xxCwhL917aJ8RthA588Gk4SICdUKpvRp/D01VPXf5iobWlYrsbPvcgn
	 sH0g12O82I8p3avHyFVAvPuvJ5e5E0MurXUtWZ6omApSK3QZ/w0BelKETTtqtvyK8o
	 eeElZJH6xDXnQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 1/7] platform/x86: toshiba_acpi: Reorder code to avoid forward
 declaration
Date: Tue, 24 Mar 2026 20:58:05 +0100
Message-ID: <4734258.LvFx2qVVIh@rafael.j.wysocki>
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

Move the definition of toshiba_acpi_notify() before the definitions of
the functions that will refer to it after subsequent updates to avoid
having to add a forward declarations of it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_acpi.c | 120 ++++++++++++++--------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 18fb558115aa..fbd7b6b6b826 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3193,6 +3193,66 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 	pr_cont("\n");
 }
 
+static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
+{
+	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+
+	switch (event) {
+	case 0x80: /* Hotkeys and some system events */
+		/*
+		 * Machines with this WMI GUID aren't supported due to bugs in
+		 * their AML.
+		 *
+		 * Return silently to avoid triggering a netlink event.
+		 */
+		if (wmi_has_guid(TOSHIBA_WMI_EVENT_GUID))
+			return;
+		toshiba_acpi_process_hotkeys(dev);
+		break;
+	case 0x81: /* Dock events */
+	case 0x82:
+	case 0x83:
+		pr_info("Dock event received %x\n", event);
+		break;
+	case 0x88: /* Thermal events */
+		pr_info("Thermal event received\n");
+		break;
+	case 0x8f: /* LID closed */
+	case 0x90: /* LID is closed and Dock has been ejected */
+		break;
+	case 0x8c: /* SATA power events */
+	case 0x8b:
+		pr_info("SATA power event received %x\n", event);
+		break;
+	case 0x92: /* Keyboard backlight mode changed */
+		dev->kbd_event_generated = true;
+		/* Update sysfs entries */
+		if (sysfs_update_group(&acpi_dev->dev.kobj,
+				       &toshiba_attr_group))
+			pr_err("Unable to update sysfs entries\n");
+		/* Notify LED subsystem about keyboard backlight change */
+		if (dev->kbd_type == 2 && dev->kbd_mode != SCI_KBD_MODE_AUTO)
+			led_classdev_notify_brightness_hw_changed(&dev->kbd_led,
+					(dev->kbd_mode == SCI_KBD_MODE_ON) ?
+					LED_FULL : LED_OFF);
+		break;
+	case 0x8e: /* Power button pressed */
+		break;
+	case 0x85: /* Unknown */
+	case 0x8d: /* Unknown */
+	case 0x94: /* Unknown */
+	case 0x95: /* Unknown */
+	default:
+		pr_info("Unknown event received %x\n", event);
+		break;
+	}
+
+	acpi_bus_generate_netlink_event(acpi_dev->pnp.device_class,
+					dev_name(&acpi_dev->dev),
+					event, (event == 0x80) ?
+					dev->last_key_event : 0);
+}
+
 static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
@@ -3495,66 +3555,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	return ret;
 }
 
-static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
-{
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
-
-	switch (event) {
-	case 0x80: /* Hotkeys and some system events */
-		/*
-		 * Machines with this WMI GUID aren't supported due to bugs in
-		 * their AML.
-		 *
-		 * Return silently to avoid triggering a netlink event.
-		 */
-		if (wmi_has_guid(TOSHIBA_WMI_EVENT_GUID))
-			return;
-		toshiba_acpi_process_hotkeys(dev);
-		break;
-	case 0x81: /* Dock events */
-	case 0x82:
-	case 0x83:
-		pr_info("Dock event received %x\n", event);
-		break;
-	case 0x88: /* Thermal events */
-		pr_info("Thermal event received\n");
-		break;
-	case 0x8f: /* LID closed */
-	case 0x90: /* LID is closed and Dock has been ejected */
-		break;
-	case 0x8c: /* SATA power events */
-	case 0x8b:
-		pr_info("SATA power event received %x\n", event);
-		break;
-	case 0x92: /* Keyboard backlight mode changed */
-		dev->kbd_event_generated = true;
-		/* Update sysfs entries */
-		if (sysfs_update_group(&acpi_dev->dev.kobj,
-				       &toshiba_attr_group))
-			pr_err("Unable to update sysfs entries\n");
-		/* Notify LED subsystem about keyboard backlight change */
-		if (dev->kbd_type == 2 && dev->kbd_mode != SCI_KBD_MODE_AUTO)
-			led_classdev_notify_brightness_hw_changed(&dev->kbd_led,
-					(dev->kbd_mode == SCI_KBD_MODE_ON) ?
-					LED_FULL : LED_OFF);
-		break;
-	case 0x8e: /* Power button pressed */
-		break;
-	case 0x85: /* Unknown */
-	case 0x8d: /* Unknown */
-	case 0x94: /* Unknown */
-	case 0x95: /* Unknown */
-	default:
-		pr_info("Unknown event received %x\n", event);
-		break;
-	}
-
-	acpi_bus_generate_netlink_event(acpi_dev->pnp.device_class,
-					dev_name(&acpi_dev->dev),
-					event, (event == 0x80) ?
-					dev->last_key_event : 0);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int toshiba_acpi_suspend(struct device *device)
 {
-- 
2.51.0




