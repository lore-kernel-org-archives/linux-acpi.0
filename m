Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593C3FAE0A;
	Thu, 21 May 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370866; cv=none; b=prybsz8YgUosiz2uUAHRyEbfosN3EJjUX3wNNWIelOOzYWJBRm6LmkKvHW1pB/eHdFzD6YD6iCmI9IA8N03XabbiXMN4VhS79d2S7Sv9R2+5/KfwWf58AoJt3YzA+humD+kII+FpuzTYf2JXiI42qjfPgrB+te78L6DDlTXnoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370866; c=relaxed/simple;
	bh=EDx2B4zEnaWUVrzjPtmcDuCcNTEx8mLgCpYayUUmhe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VADgDBJFw6Q4tlbORsX9O4lwLYbpjTDynsezaTC0X08WaO/IjBpFS/McveKwL6rbEZWWuear0HCrhI1ffpq4+q3yoDo/TrWbB3cSaouq1eGqL/gouli9gj+/4Z6Y7M3n/Nqx+++KPoewDz62H9ewJb8COL6PrtvlUhybsqFEC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYbJ5qCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYbJ5qCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B522D1F000E9;
	Thu, 21 May 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370864;
	bh=VONxuPBWDsTSzW24QSW0kofKeocGUJsvdmPpnNTi4ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QYbJ5qCc8P0Y9bZWHizW5T7GvTvmZV2SbNgDXHqyh0krh2qo625sk/QPyTrvPiHGL
	 uAomW5QDuN6TFgjT010xSeFYbO8f1cPOMjgn5mnsRvKLWcKzRedM3uJof4FSbVdUlb
	 6QwdCguR4fNaIZQEdItKPR9HPV8xCi9jWBtsEaDtC7DrspWLladJSTOsfvx7UB2Eip
	 Tpw2W91nuMh9UmtOwhNEb8iYpAJJMgXDMM8sehZvddepvHbT02Slbpvija1R1ikcZD
	 DNNqXChuLcIBrDQ+GweZOKkTKS3dr++DR0J7oH5G0ph3UEebIUlI4S3AM+XFaYIeFv
	 4HDXhVSvEToyQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons at probe
 time
Date: Thu, 21 May 2026 15:38:50 +0200
Message-ID: <2265993.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5996185.DvuYhMxLoT@rafael.j.wysocki>
References: <5996185.DvuYhMxLoT@rafael.j.wysocki>
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
a GPE if its dispatch type matches the given type mask and modify
acpi_button_probe() to use it for enabling the GPEs in question.

Link: https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
---

@Nick, I have reproduced the change of behavior introduced by commit
57c31e6d620f132dc on one of my systems, but not the function keys
regression because they are handled differently here.  This patch
should restore the missing functionality on your machine, but I would
appreciate some testing feedback.

@Saket, This includes some ACPICA changes, but they are Linux-specific
and will not affect any host OSes other than Linux.  I'll submit a
corresponding ACPICA PR when this patch goes to mainline Linux.

Thanks!

---
 drivers/acpi/acpica/evxfgpe.c |   33 +++++++++++++++++++++++++++------
 drivers/acpi/button.c         |   22 ++++++++++++++++++++++
 include/acpi/acpixf.h         |    5 +++++
 3 files changed, 54 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -78,18 +78,21 @@ ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_enable_gpe
+ * FUNCTION:    acpi_enable_gpe_cond
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number          - GPE level within the GPE block
+ *              dispatch_type_mask  - GPE dispatch types to match
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled.
+ * DESCRIPTION: Add a reference to a GPE so long as the dispatch type of the GPE
+ *              matches the supplied GPE dispatch type mask. On the first
+ *              reference, the GPE is hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+acpi_status acpi_enable_gpe_cond(acpi_handle gpe_device, u32 gpe_number,
+				 u8 dispatch_type_mask)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -106,8 +109,7 @@ acpi_status acpi_enable_gpe(acpi_handle
 	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_NONE) {
+		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) & dispatch_type_mask) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
 			if (ACPI_SUCCESS(status) &&
 			    ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
@@ -128,6 +130,25 @@ acpi_status acpi_enable_gpe(acpi_handle
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
+						     u8 dispatch_type_mask))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_enable_gpe(acpi_handle gpe_device,
 						u32 gpe_number))
 



