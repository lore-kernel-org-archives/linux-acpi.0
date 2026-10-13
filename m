Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3F39EF20;
	Tue, 13 Oct 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873553; cv=none; b=CIfNmZLZXMcDlow3vA1MjFsq/O1EICgbXsKn9mh3iOIh5Gsh2Ftzkqj1UimL19+OAMlDpaxNfuBT2EqyVUr8KFKm/yDLWf3KacI6BjuEtNf+ACMgaOcuB5OLgW6lV4ZS2kJFnK+CbJw7MDaACWUC/fa1s7pFZfLJzVZbCfo9RO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873553; c=relaxed/simple;
	bh=jJRwwekGJ0kyAxBwKCJ73MW1KN6Hmin1hlEIRqZtZS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQEn/f0IcwkhiE1SdoUoW1P5WEauDre4Wj73/MBITAEzg1QP1etBn0VwT53fgn35gYj9yg/k+Hb2AY9PTPoSORIUhBs2GDEdFJ2kWZMMpnALEXbcJyIruQATv+/91XCiogJJoIeSVf+qKxw/I9gPYPoNNWvTtlqVlsVf56GGUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uq+T7Npd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uq+T7Npd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uw
	B60U7fBqjA82cli4ckVv4N76faN4OXTa+KufBGAcA=; b=Uq+T7NpdZgBxcWR/BT
	7KcAaub6VkSqN6mUyGJhLvwQZzbQ+iY6rVdnhQ5oWrFWCjyBq8IXyOyW3pkP0msP
	TbTfAlFCpXbWdIe/aRw33+GqaUZbR54na+zSFGXagGP7phXs5RK/IMYZDA9htLN5
	9Uh5vN4JUx2fNTgYhV0S1oPLU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn78wA0s1q_NgEEA--.56486S2;
	Tue, 13 Oct 2026 14:38:57 +0800 (CST)
From: liujinlong176@163.com
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujinlong <liujinlong@kylinos.cn>
Subject: [PATCH] ACPI: button: Support separate press and release events
Date: Tue, 13 Oct 2026 14:38:56 +0800
Message-Id: <20261013063856.1755787-1-liujinlong176@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn78wA0s1q_NgEEA--.56486S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy7urWkAw4fuw17AFW3GFg_yoW5AF13pF
	Z0gasag3y5XanrJ3Wayr18uFyrt3y7Wr1rJrsrta4fZa1Sqry8urWqqrWDJ34Y9a1IqayD
	KF9rJrWDAF17JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joxRhUUUUU=
X-CM-SenderInfo: xolxyxxqor0wqrxwqiywtou0bp/xtbC5wHC1WrN0gELJQAA3r

From: liujinlong <liujinlong@kylinos.cn>

The ACPI button driver only recognizes notify value 0x80 and
always synthesizes a press followed by an immediate release.
This makes it impossible for userspace to determine the actual
duration of a power button press.

Add two new notify values, 0x81 and 0x82, that firmware can use
to report the press and the release separately.  The 0x80 path
is unchanged for compatibility with existing firmware.

Move the notify value definitions to include/acpi/button.h so
they can be shared between the driver and other users.

Signed-off-by: liujinlong <liujinlong@kylinos.cn>
---
 drivers/acpi/button.c | 24 ++++++++++++++++++------
 include/acpi/button.h |  4 ++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..b72ed9fc429d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -26,7 +26,6 @@
 #define ACPI_BUTTON_FILE_STATE		"state"
 #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
 #define ACPI_BUTTON_NOTIFY_WAKE		0x02
-#define ACPI_BUTTON_NOTIFY_STATUS	0x80
 
 #define ACPI_BUTTON_CLASS_POWER		"button/power"
 #define ACPI_BUTTON_DEVICE_NAME_POWER	"Power Button"
@@ -465,7 +464,8 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
-		break;
+	case ACPI_BUTTON_NOTIFY_PRESS:
+	case ACPI_BUTTON_NOTIFY_RELEASE:
 	case ACPI_BUTTON_NOTIFY_WAKE:
 		break;
 	default:
@@ -482,10 +482,22 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	input = button->input;
 	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
 
-	input_report_key(input, keycode, 1);
-	input_sync(input);
-	input_report_key(input, keycode, 0);
-	input_sync(input);
+	switch (event) {
+	case ACPI_BUTTON_NOTIFY_STATUS:
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+		break;
+	case ACPI_BUTTON_NOTIFY_PRESS:
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		break;
+	case ACPI_BUTTON_NOTIFY_RELEASE:
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+		break;
+	}
 
 	acpi_bus_generate_netlink_event(button->class, dev_name(&device->dev),
 					event, ++button->pushed);
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..832f1a308828 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -6,6 +6,10 @@
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
 
+#define ACPI_BUTTON_NOTIFY_STATUS	0x80
+#define ACPI_BUTTON_NOTIFY_PRESS	0x81
+#define ACPI_BUTTON_NOTIFY_RELEASE	0x82
+
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
 #else
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

