Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644F409634;
	Fri, 22 May 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461658; cv=none; b=XmzAb34kN9nOB+mPFJGd/zlF35BMr8+KR0u0hxIKJ8OnTze15Zs4Z+DXaMsEzNGfupIMbHqfPOPwBkISBxIrShCxOcsh487Bfj5z5zk0iEpkok4/GJrl026hcbz8UkflbipKjvAsmtFX9WeSkwZQNVppo0antRsmA3zIOfdS6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461658; c=relaxed/simple;
	bh=Gy4auY1ifgVHTzhfhG9A4esDJZTErFsAWSc6Zlk+V+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1s8IEDCWHTu7k3HMZEyrkvSacGT5lmzO2ZbJZU/HCjZ0+T6maK2DYd41aB+DZ8vI7MWYGfTwHRZnKsAJlckfd2kYYjazq2t+3r6E8BtX0uFhvMvsfn6MQAIRPufV5a1jsBYVuD56Qiel3AB73SyDTU7I84acTZ5muHlFSs4EC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KywN3YG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KywN3YG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB4D1F000E9;
	Fri, 22 May 2026 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461657;
	bh=FCHaIRNYLpdcn9PJ08ThLHgrZg5NBrmGzut7hhm6qBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KywN3YG0shu/mFMdVj6RZT8rSVLJVCl5BooRDtDRN9M6dVIJOBh2MpWvRyxqQCIAr
	 EIne+vo33Y/5+L9BWr/4JUglM+QGdduftIrYzq2lX2QyZYl+Kxm2te68Njsnbsj8xx
	 1SpQ7HC5yFu5uhynmSEtbbqwwfJdctn2JoFiJpWZgwZva2obQL/+lWO0TQi9YDPEyL
	 0hlLLFRuKVi5/KasHPHC80kBT0UBYaeb99G+Rk4FgfBVDC/jQIArRlvFC3XNlIHH3z
	 2bbmBC9KPinSJfCFAIJSZBl3b1kJwLVLrcH/rpWBGXHe9tKwCCGmbpXLffrvW0TXpY
	 Vj1c939njFJUg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Nick <nick@kousu.ca>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons at probe
 time
Date: Fri, 22 May 2026 16:52:10 +0200
Message-ID: <9629117.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2046403.PYKUYFuaPT@rafael.j.wysocki>
References: <2046403.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Prior to commit 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake()
for buttons"), ACPI button wakeup GPEs having handler methods remained
enabled after acpi_wakeup_gpe_init(), but currently they are not enabled
because acpi_setup_gpe_for_wake() disables them.

That causes function keys to stop working on some systems [1] and there
may be other related issues elsewhere.

To address that, make the ACPI button driver enable wakeup GPEs for ACPI
buttons so long as they have handler methods.  While this does not
restore the old behavior exactly (the ACPI button driver needs to be
bound to the button devices for the GPEs to be enabled), it should be
sufficient to restore the missing functionality.

For this purpose, introduce acpi_enable_gpe_cond() that enables
a GPE if its dispatch type matches the supplied one and modify
acpi_button_probe() to use that function for enabling the GPEs in
question.

Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons")
Reported-by: Nick <nick@kousu.ca>
Closes: https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
---

v1 -> v2:
   * Change the acpi_enable_gpe_cond() third parameter to a dispatch type (or
     "any type" value) and modify checks in it accordingly to address a
     problem pointed out by sashiko.dev
   * Adjust comments in acpi_enable_gpe_cond() and acpi_enable_gpe()
   * Update the changelog

@Nick, It would be good to test this version of the patch on your system
because it is a bit different from the previous one (which was not entirely
correct).  I'm not expecting it to behave differently, but additional
testing would be welcome.

Thanks!

---
 drivers/acpi/acpica/evxfgpe.c |   50 ++++++++++++++++++++++++++++++++++--------
 drivers/acpi/button.c         |   22 ++++++++++++++++++
 include/acpi/acpixf.h         |    5 ++++
 3 files changed, 68 insertions(+), 9 deletions(-)

--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -78,18 +78,22 @@ ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_enable_gpe
+ * FUNCTION:    acpi_enable_gpe_cond
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number          - GPE level within the GPE block
+ *              dispatch_type       - GPE dispatch type to match
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled.
+ * DESCRIPTION: Add a reference to a GPE so long as its dispatch type matches
+ *              the supplied one, or it is different from ACPI_GPE_DISPATCH_NONE
+ *              if the supplied one is ACPI_GPE_DISPATCH_MASK. On the first
+ *              reference, the GPE is hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+acpi_status acpi_enable_gpe_cond(acpi_handle gpe_device, u32 gpe_number,
+				 u8 dispatch_type)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -100,14 +104,18 @@ acpi_status acpi_enable_gpe(acpi_handle
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/*
-	 * Ensure that we have a valid GPE number and that there is some way
-	 * of handling the GPE (handler or a GPE method). In other words, we
-	 * won't allow a valid GPE to be enabled if there is no way to handle it.
+	 * Ensure that we have a valid GPE number and that the dispatch type of
+	 * the GPE matches the supplied one (or it is not ACPI_GPE_DISPATCH_NONE
+	 * if the supplied one is ACPI_GPE_DISPATCH_MASK).
 	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_NONE) {
+		if (dispatch_type == ACPI_GPE_DISPATCH_MASK)
+			dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
+		else if (dispatch_type != ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags))
+			dispatch_type = ACPI_GPE_DISPATCH_NONE;
+
+		if (dispatch_type != ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
 			if (ACPI_SUCCESS(status) &&
 			    ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
@@ -128,6 +136,30 @@ acpi_status acpi_enable_gpe(acpi_handle
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
+ACPI_EXPORT_SYMBOL(acpi_enable_gpe_cond)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled.
+ *
+ ******************************************************************************/
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	/*
+	 * Ensure that there is some way of handling the GPE (handler or a GPE
+	 * method). In other words, we won't allow a valid GPE to be enabled if
+	 * there is no way to handle it.
+	 */
+	return acpi_enable_gpe_cond(gpe_device, gpe_number, ACPI_GPE_DISPATCH_MASK);
+}
 ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
 
 /*******************************************************************************
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -179,6 +179,7 @@ struct acpi_button {
 	ktime_t last_time;
 	bool suspended;
 	bool lid_state_initialized;
+	bool gpe_enabled;
 };
 
 static struct acpi_device *lid_device;
@@ -646,6 +647,21 @@ static int acpi_button_probe(struct plat
 		status = acpi_install_notify_handler(device->handle,
 						     ACPI_ALL_NOTIFY, handler,
 						     button);
+		if (ACPI_SUCCESS(status) && device->wakeup.flags.valid) {
+			acpi_status st;
+
+			/*
+			 * If the wakeup GPE has a handler method, enable it in
+			 * case it is also used for signaling runtime events.
+			 */
+			st = acpi_enable_gpe_cond(device->wakeup.gpe_device,
+						   device->wakeup.gpe_number,
+						   ACPI_GPE_DISPATCH_METHOD);
+			button->gpe_enabled = ACPI_SUCCESS(st);
+			if (button->gpe_enabled)
+				dev_dbg(button->dev, "Enabled ACPI GPE%02llx\n",
+					device->wakeup.gpe_number);
+		}
 		break;
 	}
 	if (ACPI_FAILURE(status)) {
@@ -689,6 +705,12 @@ static void acpi_button_remove(struct pl
 						acpi_button_event);
 		break;
 	default:
+		if (button->gpe_enabled) {
+			dev_dbg(button->dev, "Disabling ACPI GPE%02llx\n",
+				adev->wakeup.gpe_number);
+			acpi_disable_gpe(adev->wakeup.gpe_device,
+					 adev->wakeup.gpe_number);
+		}
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -726,6 +726,11 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_update_all_gpes(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_enable_gpe_cond(acpi_handle gpe_device,
+						     u32 gpe_number,
+						     u8 dispatch_type))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_enable_gpe(acpi_handle gpe_device,
 						u32 gpe_number))
 



