Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D5367F31;
	Sat, 25 Apr 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154277; cv=none; b=I7u7h92ewbfTEiyCZS7NSzu8zYnI7fcAIeC1Uy5XlwyKLTT4b+fe694PX4q7zx37+vbXlIXmptBXdoqOouXKos1AiDwFJ7Qf0pTAbFtA91giC/sKyDfEgawyQTpUb0LFtw5lL9uCJV63uWldKzqN+S9zG+GKsF4p5YDDDBR3k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154277; c=relaxed/simple;
	bh=HDbMsjjfAVTsdkAUn6AS5IvI6hGr+GB1VWC06XnjbiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfQCXJIt04r4GGFcJZq90awNoccerntuKGJGVHYBnyZXSsCvAIkB/ou7wAjdIL8u3Oi4Fzj7dURHmEPJ5mj7MXMYRieXeKsZpAr7/hCpB1l04+V1Ty+o9XN2ir4gZnCtCeWouBkbWVaFbdkq/b6ZSUt6eVLPX+qSTu6PTCbUPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HRK0Zspz; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HRK0Zspz"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 61D7CC1847;
	Sun, 26 Apr 2026 00:57:48 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id D156EC1818;
	Sun, 26 Apr 2026 00:57:47 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B32731FD47E;
	Sun, 26 Apr 2026 00:57:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154267;
	bh=kCFKuOwTOpvO8wuwF8nH541CkPemBPYvdRJlmy2rGcs=; h=From:To:Subject;
	b=HRK0ZspzgqZ22KvMHLAgbtezshiYtRouTs0dm6gU/7gHHT2c+mkjzwrbJz5sCLVeM
	 OLyUooagqhplyYGbw8NMJfw73/kLhxiR7X1SkhLuLVeYw7yvzHNb9Gc7fAvSKSbYmt
	 azU7yDGwZ48GvUpbPzetSLMi7NhY+QvtmbfF711FsOsxHSSBpNSPLMZphC6Lx9aQLD
	 7Bvi56rI/MMy1mwEs1CffYhG+hcx8MxxZcq8f1kZFk/WPIKqkqaKtOKA9WedEk/0Pq
	 PIHjkopaJ0HKreGOd2D04i2VTWMre1Pcebx2jES98AoOS6FS9RurhoMRFHQtEYawrC
	 hauOLzSb9qB2g==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 05/10] HID: asus: remove quirk handling for Ally devices
Date: Sat, 25 Apr 2026 23:57:29 +0200
Message-ID: <20260425215734.14116-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715426746.3678080.17843960859623243697@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Ally device controllers had suspend issues due to the faulty s2idle
ordering present in the kernel, causing a failure to resume. These
issues were partially addressed with a firmware update, leading to
the introduction of a version check in this driver.

However, after fixing the call ordering in s2idle and adding a small
delay particularly for Ally devices, the controller for these devices
is universally fixed for all firmware versions, including the spurious
resume bug requiring set_ally_mcu_powersave(True) for the controller to
function correctly on newer firmwares.

Therefore, remove the check and cleanup the driver.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 113 ++---------------------------------------
 1 file changed, 4 insertions(+), 109 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bc93b27f9b13..2d2fe72a3d5b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -53,10 +53,6 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
-#define ROG_ALLY_REPORT_SIZE 64
-#define ROG_ALLY_X_MIN_MCU 313
-#define ROG_ALLY_MIN_MCU 319
-
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -99,9 +95,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_MEDION_E1239T		BIT(10)
 #define QUIRK_ROG_NKEY_KEYBOARD		BIT(11)
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD	BIT(12)
-#define QUIRK_ROG_ALLY_XPAD		BIT(13)
-#define QUIRK_HID_FN_LOCK		BIT(14)
-#define QUIRK_ROG_NKEY_ID1ID2_INIT	BIT(15)
+#define QUIRK_HID_FN_LOCK		BIT(13)
+#define QUIRK_ROG_NKEY_ID1ID2_INIT	BIT(14)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -631,102 +626,9 @@ static void asus_kbd_backlight_work(struct work_struct *work)
 		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
 }
 
-/*
- * We don't care about any other part of the string except the version section.
- * Example strings: FGA80100.RC72LA.312_T01, FGA80100.RC71LS.318_T01
- * The bytes "5a 05 03 31 00 1a 13" and possibly more come before the version
- * string, and there may be additional bytes after the version string such as
- * "75 00 74 00 65 00" or a postfix such as "_T01"
- */
-static int mcu_parse_version_string(const u8 *response, size_t response_size)
-{
-	const u8 *end = response + response_size;
-	const u8 *p = response;
-	int dots, err, version;
-	char buf[4];
-
-	dots = 0;
-	while (p < end && dots < 2) {
-		if (*p++ == '.')
-			dots++;
-	}
-
-	if (dots != 2 || p >= end || (p + 3) >= end)
-		return -EINVAL;
-
-	memcpy(buf, p, 3);
-	buf[3] = '\0';
-
-	err = kstrtoint(buf, 10, &version);
-	if (err || version < 0)
-		return -EINVAL;
-
-	return version;
-}
-
-static int mcu_request_version(struct hid_device *hdev)
-{
-	u8 *response __free(kfree) = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
-	const u8 request[] = { 0x5a, 0x05, 0x03, 0x31, 0x00, 0x20 };
-	int ret;
-
-	if (!response)
-		return -ENOMEM;
-
-	ret = asus_kbd_set_report(hdev, request, sizeof(request));
-	if (ret < 0)
-		return ret;
-
-	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response,
-				ROG_ALLY_REPORT_SIZE, HID_FEATURE_REPORT,
-				HID_REQ_GET_REPORT);
-	if (ret < 0)
-		return ret;
-
-	ret = mcu_parse_version_string(response, ROG_ALLY_REPORT_SIZE);
-	if (ret < 0) {
-		pr_err("Failed to parse MCU version: %d\n", ret);
-		print_hex_dump(KERN_ERR, "MCU: ", DUMP_PREFIX_NONE,
-			      16, 1, response, ROG_ALLY_REPORT_SIZE, false);
-	}
-
-	return ret;
-}
-
-static void validate_mcu_fw_version(struct hid_device *hdev, int idProduct)
-{
-	int min_version, version;
-
-	version = mcu_request_version(hdev);
-	if (version < 0)
-		return;
-
-	switch (idProduct) {
-	case USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY:
-		min_version = ROG_ALLY_MIN_MCU;
-		break;
-	case USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X:
-		min_version = ROG_ALLY_X_MIN_MCU;
-		break;
-	default:
-		min_version = 0;
-	}
-
-	if (version < min_version) {
-		hid_warn(hdev,
-			"The MCU firmware version must be %d or greater to avoid issues with suspend.\n",
-			min_version);
-	} else {
-		set_ally_mcu_hack(ASUS_WMI_ALLY_MCU_HACK_DISABLED);
-		set_ally_mcu_powersave(true);
-	}
-}
-
 static int asus_kbd_register_leds(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
-	struct usb_interface *intf;
-	struct usb_device *udev;
 	unsigned char kbd_func;
 	int ret;
 
@@ -754,13 +656,6 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
-		intf = to_usb_interface(hdev->dev.parent);
-		udev = interface_to_usbdev(intf);
-		validate_mcu_fw_version(hdev,
-			le16_to_cpu(udev->descriptor.idProduct));
-	}
-
 	drvdata->kbd_backlight = devm_kzalloc(&hdev->dev,
 					      sizeof(struct asus_kbd_leds),
 					      GFP_KERNEL);
@@ -1493,10 +1388,10 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD},
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_XGM_2022),
 	},
-- 
2.53.0


