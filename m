From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] ACPICA: hw: Don't carry spinlock over suspend
Date: Wed, 10 Oct 2007 01:07:50 -0400
Message-ID: <1191992870-15009-5-git-send-email-lenb@kernel.org>
References: <1191992870-15009-1-git-send-email-lenb@kernel.org>
 <1191992870-15009-2-git-send-email-lenb@kernel.org>
 <1191992870-15009-3-git-send-email-lenb@kernel.org>
 <1191992870-15009-4-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35727 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbXJJFHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:55 -0400
In-Reply-To: <1191992870-15009-4-git-send-email-lenb@kernel.org>
Message-Id: <2d571b33cf7efd6a894e765e3cb45587ec5b834a.1191992618.git.len.brown@intel.com>
In-Reply-To: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
References: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

ACPI uses acpi_get_register() in order to get into suspend.
This function is guarded by acpi_gbl_hardware_lock, which will be carried
into resume phase.
At resume interrupts are enabled and first ACPI interrupt deadlocks on this
lock.
Solution seems to be to not lock register read, as there are no concurrent
activity at this point.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=7499

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    3 ++-
 include/acpi/acpixf.h           |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 4d0c677..c0577ca 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -398,7 +398,8 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
+		status = acpi_get_register_unlocked(ACPI_BITREG_WAKE_STATUS,
+						    &in_value);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3d7ab9e..9512f04 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -314,6 +314,8 @@ acpi_resource_to_address64(struct acpi_resource *resource,
  */
 acpi_status acpi_get_register(u32 register_id, u32 * return_value);
 
+acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
+
 acpi_status acpi_set_register(u32 register_id, u32 value);
 
 acpi_status
-- 
1.5.3.4.206.g58ba4
