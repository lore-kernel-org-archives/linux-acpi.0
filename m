Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC463DB65A;
	Mon,  1 Jun 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334005; cv=none; b=qtf5fjqTTsTXZiu06Q7Ho4FResXIaUN/J9Lx2rk/le4tkmQYpO1eeMuEhXNG6ZUMhOgC4MVDxm/L87QA2+KKDWaJYGEFXeGIqUbZNSow1gEHyxAV8jgcKvUwdEkuEM6LNQ6jkTf4xLQli5j0tDRFq/gWqHyXTyJ5KCbv9GxnxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334005; c=relaxed/simple;
	bh=aOHdtoqbu4aKOwnilONnGhvrl1KID5BsLTrW4Cy6GVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKqjgFu0YKFp+wmP7kvp9BqrCubK1QpsQ/vvp4KXR1YDuRgQ9zBl4MSkGd1EIfXDi67SAnttklHPW9x3GfPio7OCXfv7MP/GZAcO2X0DyPhdoDT2SIQ7S/4IySPcBkiEMeoGydlP2+v9TsoRF8Gcr3/kW8XuKmImXdBAIAx40LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX8B260i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX8B260i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CA11F00893;
	Mon,  1 Jun 2026 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334003;
	bh=AjDkKyCkK5vUk4p4cKNeEFQDhdXUyvyrTxgPM1YHjn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IX8B260iLJVo49BcEV/Z8rFvDmPpSVOHN9j4BR4POnmHoBhZdnRNJ+w/IR2z5CQnL
	 90vt3M+M0S+hH+wbTFi4ahKkPX/wB7whNUUKAczfiuDn4BPx0Zt97IEbP3VNDSMwLH
	 Mw1rkzSVEZRPwMH6pyw4X1drLXMCjxb5rhgupKiVgH9gY5f2tFu4fEmsv4FY+4qOAg
	 ihQYhLONYYFEGGJV9gGMrgracEB7oZNkZnkw6je0e+IimZK+NEs6AvUVECN4lHyPez
	 79ADahqjQ8QlnceSD8gURUpGELOC6Tn4EnCfexuyfp83gbckrzslzP8jJbLOCze1+h
	 JGotGoA3nK3Bw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 13/15] ACPI: button: Use string literals for generating netlink
 messages
Date: Mon, 01 Jun 2026 19:07:57 +0200
Message-ID: <2070791.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12913564.O9o76ZdvQC@rafael.j.wysocki>
References: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of storing strings that never change later under
acpi_device_class(device) and using them for generating netlink
messages, use pointers to string literals with the same content.

This also allows the clearing of the acpi_device_class(device)
area during driver removal and in the probe rollback path to be
dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3327ee8132ad..122c1dd8a68d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -28,14 +28,15 @@
 #define ACPI_BUTTON_NOTIFY_WAKE		0x02
 #define ACPI_BUTTON_NOTIFY_STATUS	0x80
 
-#define ACPI_BUTTON_SUBCLASS_POWER	"power"
+#define ACPI_BUTTON_CLASS_POWER		"button/power"
 #define ACPI_BUTTON_DEVICE_NAME_POWER	"Power Button"
 #define ACPI_BUTTON_TYPE_POWER		0x01
 
-#define ACPI_BUTTON_SUBCLASS_SLEEP	"sleep"
+#define ACPI_BUTTON_CLASS_SLEEP		"button/sleep"
 #define ACPI_BUTTON_DEVICE_NAME_SLEEP	"Sleep Button"
 #define ACPI_BUTTON_TYPE_SLEEP		0x03
 
+#define ACPI_BUTTON_CLASS_LID		"button/lid"
 #define ACPI_BUTTON_SUBCLASS_LID	"lid"
 #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
 #define ACPI_BUTTON_TYPE_LID		0x05
@@ -173,6 +174,7 @@ struct acpi_button {
 	struct device *dev;		/* physical button device */
 	unsigned int type;
 	struct input_dev *input;
+	const char *class;		/* for netlink messages */
 	char phys[32];			/* for input device */
 	unsigned long pushed;
 	bool last_state;
@@ -462,8 +464,7 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	input_report_key(input, keycode, 0);
 	input_sync(input);
 
-	acpi_bus_generate_netlink_event(acpi_device_class(device),
-					dev_name(&device->dev),
+	acpi_bus_generate_netlink_event(button->class, dev_name(&device->dev),
 					event, ++button->pushed);
 }
 
@@ -530,7 +531,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 	struct acpi_button *button;
 	struct input_dev *input;
 	acpi_status status;
-	char *class;
 	u8 button_type;
 	int error = 0;
 
@@ -559,17 +559,15 @@ static int acpi_button_probe(struct platform_device *pdev)
 	button->input = input;
 	button->type = button_type;
 
-	class = acpi_device_class(device);
-
 	switch (button_type) {
 	case ACPI_BUTTON_TYPE_LID:
+		button->class = ACPI_BUTTON_CLASS_LID;
+
 		input->name = ACPI_BUTTON_DEVICE_NAME_LID;
 		input_set_capability(input, EV_SW, SW_LID);
 		input->open = acpi_lid_input_open;
 
 		handler = acpi_lid_notify;
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 
 		error = acpi_lid_add_fs(button);
 		if (error) {
@@ -579,22 +577,22 @@ static int acpi_button_probe(struct platform_device *pdev)
 		break;
 
 	case ACPI_BUTTON_TYPE_POWER:
+		button->class = ACPI_BUTTON_CLASS_POWER;
+
 		input->name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		input_set_capability(input, EV_KEY, KEY_POWER);
 		input_set_capability(input, EV_KEY, KEY_WAKEUP);
 
 		handler = acpi_button_notify;
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
+		button->class = ACPI_BUTTON_CLASS_SLEEP;
+
 		input->name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		input_set_capability(input, EV_KEY, KEY_SLEEP);
 
 		handler = acpi_button_notify;
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 		break;
 
 	default:
@@ -676,7 +674,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 err_free_button:
 	kfree(button);
-	memset(acpi_device_class(device), 0, sizeof(acpi_device_class));
 	return error;
 }
 
@@ -719,8 +716,6 @@ static void acpi_button_remove(struct platform_device *pdev)
 		acpi_lid_remove_fs(button);
 
 	kfree(button);
-
-	memset(acpi_device_class(adev), 0, sizeof(acpi_device_class));
 }
 
 static int param_set_lid_init_state(const char *val,
-- 
2.51.0




