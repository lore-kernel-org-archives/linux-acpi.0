Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E613DC4C9;
	Mon,  1 Jun 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334007; cv=none; b=HnmZkUGD10YA2Cqq7ILGmdQP6qEnmJBuGKMJI9PHvaZ24WBW7Ofjxm6Ij2bNTWfPmnoDyv4m37B3csWMoyGe6u7vn8lhvOvRQ5RTCJdNXWHPvzMEPnd2JxsaCah76qtOOhvZ4H3Dl0ov3BnrnMIrMUqBtDe/2DSiEH7Sg7KhewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334007; c=relaxed/simple;
	bh=Cm/pO6BT8e/8CIm1MgX+mUVBD644MN6zVYL+RaCNxo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfY/VTCwCLuf1ml5Kh0PvityEIPgmYRxSqQYtL9OIFvgKyQFlG1lhESEFyngZQs0o0RWJfsd9UKmmRi/a7hFiV0oW3eR+V/Wj7Thyw+/1uHGdLvtyOf+LrqBuwr6GU5I/vR5qyNwr4/cl9wCARlTfqpt8s4T4wUdgVpDm1TGBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek28OGa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek28OGa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE381F00893;
	Mon,  1 Jun 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334006;
	bh=A4ozbygPnKnyEptPtvQBJ0Hkn6jY8b5H4KruzJ/S5Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ek28OGa6LLFjgankBnH8j7d6jkysJxT+WWkxqide5xPI6Yl5lzFUwsJWX6UTFx/5W
	 Wnme1l8v7tR8vN2MsptSOaLbSC7Ctt1n8Nps+hcj7EuEZyCxSFQXD3TvqHEya0CbaQ
	 RNmYed20SDux+WmYHKKiHr84OSspVGJVd985iqgZh+PyH6vMrAafRH81FU+G/OA13R
	 g6KHD2mrhLO1LCVb03wGl0CbqhgXOhO7nIKBDt54CH5ZL7HB9O87HyfkTTP9dwtMmX
	 rqdLZ0PR6wt0IT4X8isujCqfOYyjDoAUbSmlKH3P0EK6XJT4Vvey7iF33ArT8+9zX7
	 OAOyhEMInAu0Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 12/15] ACPI: button: Clean up adding and removing lid procfs
 interface
Date: Mon, 01 Jun 2026 19:07:14 +0200
Message-ID: <1869050.VLH7GnMWUR@rafael.j.wysocki>
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

The procfs interface is only used with lid devices which only becomes
clear after looking into the function bodies of acpi_button_add_fs()
and acpi_button_remove_fs().  Moreover, the only error code returned
by the former of these functions is -ENODEV, so the ret local variable
in it is redundant, and the return type of the latter one can be changed
to void.

Accordingly, rename these functions to acpi_button_add_fs() and
acpi_button_remove_fs(), respectively, move the button->type checks
against ACPI_BUTTON_TYPE_LID from them to their callers, and make
code simplifications as per the above.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 54 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c035741e5abf..3327ee8132ad 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -292,15 +292,10 @@ static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
 	return 0;
 }
 
-static int acpi_button_add_fs(struct acpi_button *button)
+static int acpi_lid_add_fs(struct acpi_button *button)
 {
 	struct acpi_device *device = button->adev;
 	struct proc_dir_entry *entry = NULL;
-	int ret = 0;
-
-	/* procfs I/F for ACPI lid device only */
-	if (button->type != ACPI_BUTTON_TYPE_LID)
-		return 0;
 
 	if (acpi_button_dir || acpi_lid_dir) {
 		pr_info("More than one Lid device found!\n");
@@ -314,33 +309,25 @@ static int acpi_button_add_fs(struct acpi_button *button)
 
 	/* create /proc/acpi/button/lid */
 	acpi_lid_dir = proc_mkdir(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
-	if (!acpi_lid_dir) {
-		ret = -ENODEV;
+	if (!acpi_lid_dir)
 		goto remove_button_dir;
-	}
 
 	/* create /proc/acpi/button/lid/LID/ */
 	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), acpi_lid_dir);
-	if (!acpi_device_dir(device)) {
-		ret = -ENODEV;
+	if (!acpi_device_dir(device))
 		goto remove_lid_dir;
-	}
 
 	/* create /proc/acpi/button/lid/LID/state */
 	entry = proc_create_single_data(ACPI_BUTTON_FILE_STATE, S_IRUGO,
 			acpi_device_dir(device), acpi_button_state_seq_show,
 			button);
-	if (!entry) {
-		ret = -ENODEV;
+	if (!entry)
 		goto remove_dev_dir;
-	}
 
-done:
-	return ret;
+	return 0;
 
 remove_dev_dir:
-	remove_proc_entry(acpi_device_bid(device),
-			  acpi_lid_dir);
+	remove_proc_entry(acpi_device_bid(device), acpi_lid_dir);
 	acpi_device_dir(device) = NULL;
 remove_lid_dir:
 	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
@@ -348,16 +335,13 @@ static int acpi_button_add_fs(struct acpi_button *button)
 remove_button_dir:
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 	acpi_button_dir = NULL;
-	goto done;
+	return -ENODEV;
 }
 
-static int acpi_button_remove_fs(struct acpi_button *button)
+static void acpi_lid_remove_fs(struct acpi_button *button)
 {
 	struct acpi_device *device = button->adev;
 
-	if (button->type != ACPI_BUTTON_TYPE_LID)
-		return 0;
-
 	remove_proc_entry(ACPI_BUTTON_FILE_STATE,
 			  acpi_device_dir(device));
 	remove_proc_entry(acpi_device_bid(device),
@@ -367,8 +351,6 @@ static int acpi_button_remove_fs(struct acpi_button *button)
 	acpi_lid_dir = NULL;
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 	acpi_button_dir = NULL;
-
-	return 0;
 }
 
 static acpi_handle saved_lid_handle;
@@ -588,6 +570,12 @@ static int acpi_button_probe(struct platform_device *pdev)
 		handler = acpi_lid_notify;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+
+		error = acpi_lid_add_fs(button);
+		if (error) {
+			input_free_device(input);
+			goto err_free_button;
+		}
 		break;
 
 	case ACPI_BUTTON_TYPE_POWER:
@@ -614,12 +602,6 @@ static int acpi_button_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENODEV, "Unrecognized button type\n");
 	}
 
-	error = acpi_button_add_fs(button);
-	if (error) {
-		input_free_device(input);
-		goto err_free_button;
-	}
-
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0",
 		 acpi_device_hid(device));
 
@@ -689,7 +671,9 @@ static int acpi_button_probe(struct platform_device *pdev)
 	device_init_wakeup(button->dev, false);
 	input_unregister_device(input);
 err_remove_fs:
-	acpi_button_remove_fs(button);
+	if (button_type == ACPI_BUTTON_TYPE_LID)
+		acpi_lid_remove_fs(button);
+
 err_free_button:
 	kfree(button);
 	memset(acpi_device_class(device), 0, sizeof(acpi_device_class));
@@ -730,8 +714,10 @@ static void acpi_button_remove(struct platform_device *pdev)
 
 	device_init_wakeup(button->dev, false);
 
-	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
+	if (button->type == ACPI_BUTTON_TYPE_LID)
+		acpi_lid_remove_fs(button);
+
 	kfree(button);
 
 	memset(acpi_device_class(adev), 0, sizeof(acpi_device_class));
-- 
2.51.0




