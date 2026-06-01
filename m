Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEC3DC87B;
	Mon,  1 Jun 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334002; cv=none; b=i/86L0l4gBeL1n6GDjIenG4mbtyP9vqvsz5kk6CpZ1Giml3B+fo0rwW9F8X0xPzeA2FsG01BGybjZYtC3CT3uZEDSr/Ex+x24iahh6otsi56PHMstH6GQEEamFntLLTMNRu7o+DrdVaUvW5wzZzwdvMUedUu7OUmltAvEQQrDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334002; c=relaxed/simple;
	bh=X6XCide9IUkeqqMY/HgYn/FWHxUJbk50bklN1mgtzCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5aAFsM+2B1RyAiSUNYlsnfh7wKBHvgDhgyBEjbpYrg54PueD6jZeyChvC4cmh+CZI6yHCwFc1zJfqkx+DuydJg8hivThiROXmvm3L42GcK+Wl7TH2zsuwZfFD2QC9dT/VhCS6mHjhVkNHd00VfKUt23RVKraIvzlH47hDjodwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huk2GeFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huk2GeFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3861F00893;
	Mon,  1 Jun 2026 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334000;
	bh=41VHf2yKQJy/49Ev++yQzu0ZAnCVr7ytGsODeD+JIiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Huk2GeFgBv+UJTc0BDmhDYdaAUru1kipvMOGZTzTMkX2KBVpN/TYeilyexzIqpODw
	 XWRRjkLKCnYLDBWb/1vG9PHpdu/2L1UbQKp2F9hVNsn9CB84uJe/6GEbi4RVm6BNgb
	 Z9KySN8jhelDx9avnIG5t7R7JHDm+jBm64v/BZ5QjHBnOM4MSSDd9fXVu8IMJluDzD
	 4pSLzdZTyRjnG3iVydNVTc2n6dX5HkM2y9vvSZHGSCMeLqH9H1JqxH8lAh0gqklBFw
	 88FHeGXD9SrX0Io4trv9t6DiJECanakWJB9PMl6t8ErWh8OyDRaxo54tYEOmNDnIC3
	 zQLEXJiO4f87Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 14/15] ACPI: button: Reorganize installing and removing event
 handlers
Date: Mon, 01 Jun 2026 19:12:19 +0200
Message-ID: <2714170.Lt9SDvczpP@rafael.j.wysocki>
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

To facilitate subsequent changes, move the code installing and
removing button event handlers into two separate functions called
acpi_button_add_event_handler() and acpi_button_remove_event_handler(),
respectively, and rearrange it to reduce code duplication.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 155 ++++++++++++++++++++++++------------------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 122c1dd8a68d..8a56780e13da 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -522,15 +522,99 @@ static int acpi_lid_input_open(struct input_dev *input)
 	return 0;
 }
 
+static acpi_notify_handler acpi_button_notify_handler(struct acpi_button *button)
+{
+	if (button->type == ACPI_BUTTON_TYPE_LID)
+		return acpi_lid_notify;
+
+	return acpi_button_notify;
+}
+
+static void acpi_button_remove_event_handler(struct acpi_button *button)
+{
+	struct acpi_device *adev = button->adev;
+
+	switch (adev->device_type) {
+	case ACPI_BUS_TYPE_POWER_BUTTON:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_event);
+		break;
+
+	case ACPI_BUS_TYPE_SLEEP_BUTTON:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_event);
+		break;
+
+	default:
+		if (button->gpe_enabled) {
+			dev_dbg(button->dev, "Disabling ACPI GPE%02llx\n",
+				adev->wakeup.gpe_number);
+			acpi_disable_gpe(adev->wakeup.gpe_device,
+					 adev->wakeup.gpe_number);
+		}
+		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+					   acpi_button_notify_handler(button));
+		break;
+	}
+	acpi_os_wait_events_complete();
+}
+
+static int acpi_button_add_fixed_event_handler(u32 event,
+					       struct acpi_button *button)
+{
+	acpi_status status;
+
+	status = acpi_install_fixed_event_handler(event, acpi_button_event, button);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int acpi_button_add_event_handler(struct acpi_button *button)
+{
+	struct acpi_device *adev = button->adev;
+	acpi_status status;
+
+	if (adev->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
+		return acpi_button_add_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+							   button);
+
+	if (adev->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
+		return acpi_button_add_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+							   button);
+
+	status = acpi_install_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+					     acpi_button_notify_handler(button),
+					     button);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (!adev->wakeup.flags.valid)
+		return 0;
+
+	/*
+	 * If the wakeup GPE has a handler method, enable it in case it is also
+	 * used for signaling runtime events.
+	 */
+	status = acpi_enable_gpe_cond(adev->wakeup.gpe_device,
+				      adev->wakeup.gpe_number,
+				      ACPI_GPE_DISPATCH_METHOD);
+	button->gpe_enabled = ACPI_SUCCESS(status);
+	if (button->gpe_enabled)
+		dev_dbg(button->dev, "Enabled ACPI GPE%02llx\n",
+			adev->wakeup.gpe_number);
+
+	return 0;
+}
+
 static int acpi_button_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acpi_device *device = ACPI_COMPANION(dev);
 	const struct acpi_device_id *id;
-	acpi_notify_handler handler;
 	struct acpi_button *button;
 	struct input_dev *input;
-	acpi_status status;
 	u8 button_type;
 	int error = 0;
 
@@ -567,8 +649,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 		input_set_capability(input, EV_SW, SW_LID);
 		input->open = acpi_lid_input_open;
 
-		handler = acpi_lid_notify;
-
 		error = acpi_lid_add_fs(button);
 		if (error) {
 			input_free_device(input);
@@ -582,8 +662,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 		input->name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		input_set_capability(input, EV_KEY, KEY_POWER);
 		input_set_capability(input, EV_KEY, KEY_WAKEUP);
-
-		handler = acpi_button_notify;
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
@@ -591,8 +669,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 		input->name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		input_set_capability(input, EV_KEY, KEY_SLEEP);
-
-		handler = acpi_button_notify;
 		break;
 
 	default:
@@ -617,42 +693,9 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	device_init_wakeup(button->dev, true);
 
-	switch (device->device_type) {
-	case ACPI_BUS_TYPE_POWER_BUTTON:
-		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-							  acpi_button_event,
-							  button);
-		break;
-	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-							  acpi_button_event,
-							  button);
-		break;
-	default:
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_ALL_NOTIFY, handler,
-						     button);
-		if (ACPI_SUCCESS(status) && device->wakeup.flags.valid) {
-			acpi_status st;
-
-			/*
-			 * If the wakeup GPE has a handler method, enable it in
-			 * case it is also used for signaling runtime events.
-			 */
-			st = acpi_enable_gpe_cond(device->wakeup.gpe_device,
-						   device->wakeup.gpe_number,
-						   ACPI_GPE_DISPATCH_METHOD);
-			button->gpe_enabled = ACPI_SUCCESS(st);
-			if (button->gpe_enabled)
-				dev_dbg(button->dev, "Enabled ACPI GPE%02llx\n",
-					device->wakeup.gpe_number);
-		}
-		break;
-	}
-	if (ACPI_FAILURE(status)) {
-		error = -ENODEV;
+	error = acpi_button_add_event_handler(button);
+	if (error)
 		goto err_input_unregister;
-	}
 
 	if (button_type == ACPI_BUTTON_TYPE_LID) {
 		/*
@@ -685,29 +728,7 @@ static void acpi_button_remove(struct platform_device *pdev)
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		acpi_lid_forget(adev);
 
-	switch (adev->device_type) {
-	case ACPI_BUS_TYPE_POWER_BUTTON:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_button_event);
-		break;
-	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_button_event);
-		break;
-	default:
-		if (button->gpe_enabled) {
-			dev_dbg(button->dev, "Disabling ACPI GPE%02llx\n",
-				adev->wakeup.gpe_number);
-			acpi_disable_gpe(adev->wakeup.gpe_device,
-					 adev->wakeup.gpe_number);
-		}
-		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
-					   button->type == ACPI_BUTTON_TYPE_LID ?
-						acpi_lid_notify :
-						acpi_button_notify);
-		break;
-	}
-	acpi_os_wait_events_complete();
+	acpi_button_remove_event_handler(button);
 
 	device_init_wakeup(button->dev, false);
 
-- 
2.51.0




