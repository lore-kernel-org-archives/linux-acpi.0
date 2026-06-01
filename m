Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE33DEFF3;
	Mon,  1 Jun 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334036; cv=none; b=osTmLzU11Pn/pQ4nHBEfJA9mNA/T9C/2MP1VBtPz+HTdalAj3GUL+6odCVSJQKVsCC+YxhDC50KZ5g7nmqCVWeq5L4RFY4rMwe8ICWsf3Sdp89W2zIrt1q5ZUbqlsHSqwbdKEYV2E9wcT3AMSPInu8kyOAl5aLH5MtJnkwZj8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334036; c=relaxed/simple;
	bh=TnE1xdR/ikfYSm8AXjXcFe/qOwbNhD6Ol0MhLxIBs5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvVE65XmU7ZLGV2OmbxC7nk9k1WTWf7Fix/hSgIJSHp7d15Xe1tvFHS29o3Q3y7jIaegu4JdRa780mCG8LtRw2LwkJ4x7WJf81SRrQGdZW2pxiC84YlNGRt8rwwz0U0a2v919nCtNPmp2reeGMhTCwUv8IGWfZNTGqwVYEmOQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt1pWWzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt1pWWzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CC1F00893;
	Mon,  1 Jun 2026 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334034;
	bh=YS7nCZIoveN/Z6nFxyOM15QdxnjvRrmmk7gPj3aQgUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qt1pWWzCupwlamYs3k9dsaCKZryXW5J/0mgE5ymmUEmDERL7gIQJxioIuqegwMiGI
	 MJPU/NUI30BUbMcTSaqmmaXH+d776H9n7W0seogQkszMEQgzuMy62ioz3TTrL9fFQY
	 2vG7FJ+x/Hjo6j5a/43jw93z87o/D3wZXJBkjp2Oc6gVBvJQtbNdkZZBxsNXBmnux6
	 dMEDquDxRQA2gvvQSV3fTJhsIPDiuRgLIwSP6sNqaWO20MJfsU+HNVJl6Piyt7lTNt
	 hdpdjsV7eC3Nekd//i7C5XImFGgbokvlzdBY7RST/AMqi6XVpdE/Ma3xX1HsQsCtCl
	 HpNFXZrbdKcYQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 02/15] ACPI: button: Pass ACPI handle to acpi_lid_evaluate_state()
Date: Mon, 01 Jun 2026 18:55:53 +0200
Message-ID: <4747530.LvFx2qVVIh@rafael.j.wysocki>
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

Make it clear that acpi_lid_evaluate_state() only uses the ACPI handle
of the lid by changing its argument to acpi_handle and adjust its
callers accordingly.

Also save the ACPI handle of the lid, that later may be passed to
acpi_lid_evaluate_state(), in a static variable instead of saving a
pointer to the ACPI device object containing that handle.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5df470eea754..0b96db762bea 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -192,12 +192,12 @@ MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 static struct proc_dir_entry *acpi_button_dir;
 static struct proc_dir_entry *acpi_lid_dir;
 
-static int acpi_lid_evaluate_state(struct acpi_device *device)
+static int acpi_lid_evaluate_state(acpi_handle lid_handle)
 {
 	unsigned long long lid_state;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &lid_state);
+	status = acpi_evaluate_integer(lid_handle, "_LID", NULL, &lid_state);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -292,7 +292,7 @@ static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
 	struct acpi_button *button = seq->private;
 	int state;
 
-	state = acpi_lid_evaluate_state(button->adev);
+	state = acpi_lid_evaluate_state(button->adev->handle);
 	seq_printf(seq, "state:      %s\n",
 		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
 	return 0;
@@ -377,22 +377,22 @@ static int acpi_button_remove_fs(struct acpi_button *button)
 	return 0;
 }
 
-static struct acpi_device *lid_device;
+static acpi_handle saved_lid_handle;
 static DEFINE_MUTEX(acpi_lid_lock);
 
 static void acpi_lid_save(struct acpi_device *adev)
 {
 	guard(mutex)(&acpi_lid_lock);
 
-	lid_device = adev;
+	saved_lid_handle = adev->handle;
 }
 
 static void acpi_lid_forget(struct acpi_device *adev)
 {
 	guard(mutex)(&acpi_lid_lock);
 
-	if (lid_device == adev)
-		lid_device = NULL;
+	if (saved_lid_handle == adev->handle)
+		saved_lid_handle = NULL;
 }
 
 /* Driver Interface */
@@ -400,20 +400,19 @@ int acpi_lid_open(void)
 {
 	guard(mutex)(&acpi_lid_lock);
 
-	if (!lid_device)
+	if (!saved_lid_handle)
 		return -ENODEV;
 
-	return acpi_lid_evaluate_state(lid_device);
+	return acpi_lid_evaluate_state(saved_lid_handle);
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
 static int acpi_lid_update_state(struct acpi_button *button,
 				 bool signal_wakeup)
 {
-	struct acpi_device *device = button->adev;
 	int state;
 
-	state = acpi_lid_evaluate_state(device);
+	state = acpi_lid_evaluate_state(button->adev->handle);
 	if (state < 0)
 		return state;
 
@@ -516,12 +515,11 @@ static int acpi_button_suspend(struct device *dev)
 static int acpi_button_resume(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
-	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct input_dev *input;
 
 	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		button->last_state = !!acpi_lid_evaluate_state(device);
+		button->last_state = !!acpi_lid_evaluate_state(ACPI_HANDLE(dev));
 		button->last_time = ktime_get();
 		acpi_lid_initialize_state(button);
 	}
@@ -540,9 +538,8 @@ static int acpi_button_resume(struct device *dev)
 static int acpi_lid_input_open(struct input_dev *input)
 {
 	struct acpi_button *button = input_get_drvdata(input);
-	struct acpi_device *device = button->adev;
 
-	button->last_state = !!acpi_lid_evaluate_state(device);
+	button->last_state = !!acpi_lid_evaluate_state(button->adev->handle);
 	button->last_time = ktime_get();
 	acpi_lid_initialize_state(button);
 
-- 
2.51.0




