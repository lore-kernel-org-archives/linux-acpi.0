Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EE289E13;
	Mon,  1 Jun 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333999; cv=none; b=nil/4YNneSk9jQc7G/2+St3U4ryNuST+3sKFObWDUfkzprR/WyalsMTWRk0Jf8i3U5fxBIciidhiWXAiO03luC8hzTGUfBEwoDnO+8YzrFYkhrK7aAnnZoQ5hdKQ64KAl48XAs1IAvqI0tkyN3gtAHC26AT8CpJ96oZUCSYxzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333999; c=relaxed/simple;
	bh=iwtZnaR/gdpS0mkrNNIlB72LQDYz+3SdLS5BoI0S+/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiG8Mab3UiM/Njs36o42NRifbhVi5DLm4iMY76O1dIKoCLO+6uKv83/wKpq1maquyb8hcVKdwpRr3nFVevgxTeWbY11wBORGLJgHdygpq7L4IVFHxbVns79j3AZyGmYRdbtapcWyy0aKDMsaHCz0mkUvMzy/eb+iQ5HR1K3eX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP3W7ebV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP3W7ebV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7441F00893;
	Mon,  1 Jun 2026 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780333998;
	bh=0TvUtgnJYq2bcE49nBgwYuOC7Ri6DJxLQQ7z6kwGp4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bP3W7ebVA/pyXmpdJ63+Hk5Pq1cntZJogaheTCg4S6OzXU1/8rAzIDVkUPazWqwPD
	 Etfjq9IdupdzcRbe+mTHxMjZm5BcbD7SpwrTBGHlqR35l9QNFQFBCN/KbgIT/5Kbg+
	 Ncgf2La3X4LkFkPZq9KZQKbYKuSmMLRGQDXw3eaWDxMxBK2S+2p0r740Rbja7rs34c
	 SG+OFtN6sk0wd8kEjVs12RKCi+mWUOOguHYYwln0h57fBoYI6deoKk6li0IMYaOrdB
	 t77TC3Q95DIMLI5PNiVIY3XrrtbSRHpCs9rRY9A6ncMCgvbKG/IcwxYzDQsRWNtAms
	 xtWztxVaN2Shw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 15/15] ACPI: button: Switch over to devres-based resource
 management
Date: Mon, 01 Jun 2026 19:12:58 +0200
Message-ID: <2283436.Mh6RI2rZIc@rafael.j.wysocki>
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

Switch over the ACPI button driver to devres-based resource management
by making the following changes:

 * Use devm_kzalloc() for allocating button object memory.

 * Use devm_input_allocate_device() for allocating the input class
   device object.

 * Turn acpi_lid_remove_fs() into a devm cleanup action added
   by devm_acpi_lid_add_fs() which is a new wrapper around
   acpi_lid_add_fs().

 * Add devm_acpi_button_init_wakeup() for initializing the wakeup source
   and make it add a custom devm action that will automatically remove
   the wakeup source registered by it.

 * Turn acpi_button_remove_event_handler() into a devm cleanup action
   added by devm_acpi_button_add_event_handler() which is a new wrapper
   around acpi_button_add_event_handler().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 101 ++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 8a56780e13da..154b17a8ea25 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -340,8 +340,9 @@ static int acpi_lid_add_fs(struct acpi_button *button)
 	return -ENODEV;
 }
 
-static void acpi_lid_remove_fs(struct acpi_button *button)
+static void acpi_lid_remove_fs(void *data)
 {
+	struct acpi_button *button = data;
 	struct acpi_device *device = button->adev;
 
 	remove_proc_entry(ACPI_BUTTON_FILE_STATE,
@@ -355,6 +356,17 @@ static void acpi_lid_remove_fs(struct acpi_button *button)
 	acpi_button_dir = NULL;
 }
 
+static int devm_acpi_lid_add_fs(struct device *dev, struct acpi_button *button)
+{
+	int ret;
+
+	ret = acpi_lid_add_fs(button);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, acpi_lid_remove_fs, button);
+}
+
 static acpi_handle saved_lid_handle;
 static DEFINE_MUTEX(acpi_lid_lock);
 
@@ -530,8 +542,20 @@ static acpi_notify_handler acpi_button_notify_handler(struct acpi_button *button
 	return acpi_button_notify;
 }
 
-static void acpi_button_remove_event_handler(struct acpi_button *button)
+static void acpi_button_wakeup_cleanup(void *data)
+{
+	device_init_wakeup(data, false);
+}
+
+static int devm_acpi_button_init_wakeup(struct device *dev)
 {
+	device_init_wakeup(dev, true);
+	return devm_add_action_or_reset(dev, acpi_button_wakeup_cleanup, dev);
+}
+
+static void acpi_button_remove_event_handler(void *data)
+{
+	struct acpi_button *button = data;
 	struct acpi_device *adev = button->adev;
 
 	switch (adev->device_type) {
@@ -606,6 +630,19 @@ static int acpi_button_add_event_handler(struct acpi_button *button)
 	return 0;
 }
 
+static int devm_acpi_button_add_event_handler(struct device *dev,
+					      struct acpi_button *button)
+{
+	int ret;
+
+	ret = acpi_button_add_event_handler(button);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, acpi_button_remove_event_handler,
+					button);
+}
+
 static int acpi_button_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -625,7 +662,7 @@ static int acpi_button_probe(struct platform_device *pdev)
 	    lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
 		return -ENODEV;
 
-	button = kzalloc_obj(struct acpi_button);
+	button = devm_kzalloc(dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
 
@@ -633,11 +670,10 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	button->dev = dev;
 	button->adev = device;
-	input = input_allocate_device();
-	if (!input) {
-		error = -ENOMEM;
-		goto err_free_button;
-	}
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
 	button->input = input;
 	button->type = button_type;
 
@@ -649,11 +685,10 @@ static int acpi_button_probe(struct platform_device *pdev)
 		input_set_capability(input, EV_SW, SW_LID);
 		input->open = acpi_lid_input_open;
 
-		error = acpi_lid_add_fs(button);
-		if (error) {
-			input_free_device(input);
-			goto err_free_button;
-		}
+		error = devm_acpi_lid_add_fs(dev, button);
+		if (error)
+			return error;
+
 		break;
 
 	case ACPI_BUTTON_TYPE_POWER:
@@ -672,7 +707,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 		break;
 
 	default:
-		input_free_device(input);
 		return dev_err_probe(dev, -ENODEV, "Unrecognized button type\n");
 	}
 
@@ -686,16 +720,16 @@ static int acpi_button_probe(struct platform_device *pdev)
 
 	input_set_drvdata(input, button);
 	error = input_register_device(input);
-	if (error) {
-		input_free_device(input);
-		goto err_remove_fs;
-	}
+	if (error)
+		return error;
 
-	device_init_wakeup(button->dev, true);
+	error = devm_acpi_button_init_wakeup(dev);
+	if (error)
+		return error;
 
-	error = acpi_button_add_event_handler(button);
+	error = devm_acpi_button_add_event_handler(dev, button);
 	if (error)
-		goto err_input_unregister;
+		return error;
 
 	if (button_type == ACPI_BUTTON_TYPE_LID) {
 		/*
@@ -706,37 +740,16 @@ static int acpi_button_probe(struct platform_device *pdev)
 	}
 
 	pr_info("%s [%s]\n", input->name, acpi_device_bid(device));
-	return 0;
 
-err_input_unregister:
-	device_init_wakeup(button->dev, false);
-	input_unregister_device(input);
-err_remove_fs:
-	if (button_type == ACPI_BUTTON_TYPE_LID)
-		acpi_lid_remove_fs(button);
-
-err_free_button:
-	kfree(button);
-	return error;
+	return 0;
 }
 
 static void acpi_button_remove(struct platform_device *pdev)
 {
 	struct acpi_button *button = platform_get_drvdata(pdev);
-	struct acpi_device *adev = button->adev;
-
-	if (button->type == ACPI_BUTTON_TYPE_LID)
-		acpi_lid_forget(adev);
-
-	acpi_button_remove_event_handler(button);
 
-	device_init_wakeup(button->dev, false);
-
-	input_unregister_device(button->input);
 	if (button->type == ACPI_BUTTON_TYPE_LID)
-		acpi_lid_remove_fs(button);
-
-	kfree(button);
+		acpi_lid_forget(button->adev);
 }
 
 static int param_set_lid_init_state(const char *val,
-- 
2.51.0




