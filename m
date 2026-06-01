Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8F3DCD81;
	Mon,  1 Jun 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334017; cv=none; b=s0HlMxupJsXffjKpMysDrVufTrOauIazQdm67cxk4ng9uNwt4beXMcZJmy+3kcI5/Ueg1lKemPfxoCyqVrb7KAtsT6UaZLtmcy7h3aG3fpw1zCZTnBMOJk3HPBQWq2CI3dyNpAJxQ6YfXof6sioIdemGPYgQPL2Q8gZH6SzsQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334017; c=relaxed/simple;
	bh=vopIwUVakUy1SVl7TeRQH2P1tEIoF7OaWmDlQTxhuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM1x2ydr9WIM0/nndL2E043NzVcXb0HYRkvajUPZsTZ6s17SuOPNbv6qI0Cl40ebY1vm3I65XpleBv0iLdBTZxLOcFTSp31A/+o+1C/oe4vxKTj0WRN/b8syN7CQvocDsx266tsz7GqFca6PAHFA25kkV0Q3oAQ4T4COivhvtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4KLw3WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4KLw3WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440181F00893;
	Mon,  1 Jun 2026 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334015;
	bh=ehcAgwiokKJbFt95k8qERdNKRNCKQ3F5YRNHD2MMRV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4KLw3WMIk6yu9ETzcu2oYsjEdiv7HJU2SEUHCESHh6yDO9B/eAu7qm+q7GiloYP4
	 4ODjpDnQW29VsTdLiKNMDWKg3M6vHtjc4Vr0MwZ8dcBX+G+Gy+16JpoTt4R0B6eX7p
	 WhlzRk9woOe/dPKnfO1EoU7AxfVdhk+GhPkj9cQGmg52uqs0oR1x8DMQSPd+eWig9I
	 r3TTSN5vSbxSH5EZpXeOD9zpnz2NX81KQJ8DUXg+qNhnLAvEA2tl5JKwdVlEwRQP3B
	 flzDeUzaxU1jYb3D8vCbq/kzb1dJLaVZfSLN9lBOZotT1ATpQX3KU/NwHzRG6pGk1O
	 UE4i1+8FAUSVA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 09/15] ACPI: button: Rework device verification during probe
Date: Mon, 01 Jun 2026 19:03:24 +0200
Message-ID: <7960518.EvYhyI6sBW@rafael.j.wysocki>
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

Instead of manually comparing the primary ID of the device (retuned
by _HID) with each of the device IDs supported by the driver, use
acpi_match_acpi_device() (which includes the ACPI companion device
pointer check against NULL) and store the ACPI button type as
driver_data in button_device_ids[], which allows a multi-branch
conditional statement to be replaced with a switch () one.  However,
to continue preventing successful probing of devices that only have
one of the supported device IDs in their _CID lists, compare the
matched device ID with the primary ID of the device and return an
error if they don't match.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 77 ++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9fe8d212b606..dbaf87417428 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -59,11 +59,11 @@ MODULE_DESCRIPTION("ACPI Button Driver");
 MODULE_LICENSE("GPL");
 
 static const struct acpi_device_id button_device_ids[] = {
-	{ACPI_BUTTON_HID_LID,    0},
-	{ACPI_BUTTON_HID_SLEEP,  0},
-	{ACPI_BUTTON_HID_SLEEPF, 0},
-	{ACPI_BUTTON_HID_POWER,  0},
-	{ACPI_BUTTON_HID_POWERF, 0},
+	{ACPI_BUTTON_HID_LID, ACPI_BUTTON_TYPE_LID},
+	{ACPI_BUTTON_HID_SLEEP, ACPI_BUTTON_TYPE_SLEEP},
+	{ACPI_BUTTON_HID_SLEEPF, ACPI_BUTTON_TYPE_SLEEP},
+	{ACPI_BUTTON_HID_POWER, ACPI_BUTTON_TYPE_POWER},
+	{ACPI_BUTTON_HID_POWERF, ACPI_BUTTON_TYPE_POWER},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
@@ -542,22 +542,23 @@ static int acpi_lid_input_open(struct input_dev *input)
 static int acpi_button_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
+	const struct acpi_device_id *id;
 	acpi_notify_handler handler;
-	struct acpi_device *device;
 	struct acpi_button *button;
 	struct input_dev *input;
 	acpi_status status;
 	char *name, *class;
-	const char *hid;
+	u8 button_type;
 	int error = 0;
 
-	device = ACPI_COMPANION(dev);
-	if (!device)
-		return -ENODEV;
+	id = acpi_match_acpi_device(button_device_ids, device);
+	if (!id || strcmp(acpi_device_hid(device), id->id))
+		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
 
-	hid = acpi_device_hid(device);
-	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
-	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
+	button_type = id->driver_data;
+	if (button_type == ACPI_BUTTON_TYPE_LID &&
+	    lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
 		return -ENODEV;
 
 	button = kzalloc_obj(struct acpi_button);
@@ -568,57 +569,59 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	button->dev = dev;
 	button->adev = device;
-	button->input = input = input_allocate_device();
+	input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
 		goto err_free_button;
 	}
+	button->input = input;
+	button->type = button_type;
 
 	class = acpi_device_class(device);
 
-	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
-	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
-		button->type = ACPI_BUTTON_TYPE_POWER;
+	switch (button_type) {
+	case ACPI_BUTTON_TYPE_LID:
+		handler = acpi_lid_notify;
+		name = ACPI_BUTTON_DEVICE_NAME_LID;
+		sprintf(class, "%s/%s",
+			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+		input->open = acpi_lid_input_open;
+		break;
+
+	case ACPI_BUTTON_TYPE_POWER:
 		handler = acpi_button_notify;
 		name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
-	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
-		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
-		button->type = ACPI_BUTTON_TYPE_SLEEP;
+		break;
+
+	case ACPI_BUTTON_TYPE_SLEEP:
 		handler = acpi_button_notify;
 		name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
-	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
-		button->type = ACPI_BUTTON_TYPE_LID;
-		handler = acpi_lid_notify;
-		name = ACPI_BUTTON_DEVICE_NAME_LID;
-		sprintf(class, "%s/%s",
-			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
-		input->open = acpi_lid_input_open;
-	} else {
-		pr_info("Unsupported hid [%s]\n", hid);
-		error = -ENODEV;
-	}
+		break;
 
-	if (!error)
-		error = acpi_button_add_fs(button);
+	default:
+		input_free_device(input);
+		return dev_err_probe(dev, -ENODEV, "Unrecognized button type\n");
+	}
 
+	error = acpi_button_add_fs(button);
 	if (error) {
 		input_free_device(input);
 		goto err_free_button;
 	}
 
-	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
+	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
 
 	input->name = name;
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
-	input->id.product = button->type;
+	input->id.product = button_type;
 	input->dev.parent = dev;
 
-	switch (button->type) {
+	switch (button_type) {
 	case ACPI_BUTTON_TYPE_POWER:
 		input_set_capability(input, EV_KEY, KEY_POWER);
 		input_set_capability(input, EV_KEY, KEY_WAKEUP);
@@ -679,7 +682,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 		goto err_input_unregister;
 	}
 
-	if (button->type == ACPI_BUTTON_TYPE_LID) {
+	if (button_type == ACPI_BUTTON_TYPE_LID) {
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
-- 
2.51.0




