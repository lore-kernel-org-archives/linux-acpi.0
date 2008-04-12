From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/73] ACPICA: Fix for update of the Global Lock Handle
Date: Sat, 12 Apr 2008 00:24:57 -0400
Message-ID: <fa55853ee6a9aeba44de3e4d545896e593d80b10.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:47253 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752481AbYDLE16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:58 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where the global lock handle was not properly
updated if a thread that acquired the global lock via
executing AML code then attempted to acquire the lock via the
AcpiAcquireGlobalLock interface.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c  |   13 +++++++++++++
 drivers/acpi/events/evxface.c |    9 +--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 2d34663..d075062 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -461,6 +461,19 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	acpi_ev_global_lock_acquired++;
 
 	/*
+	 * Update the global lock handle and check for wraparound. The handle is
+	 * only used for the external global lock interfaces, but it is updated
+	 * here to properly handle the case where a single thread may acquire the
+	 * lock via both the AML and the acpi_acquire_global_lock interfaces. The
+	 * handle is therefore updated on the first acquire from a given thread
+	 * regardless of where the acquisition request originated.
+	 */
+	acpi_gbl_global_lock_handle++;
+	if (acpi_gbl_global_lock_handle == 0) {
+		acpi_gbl_global_lock_handle = 1;
+	}
+
+	/*
 	 * Make sure that a global lock actually exists. If not, just treat
 	 * the lock as a standard mutex.
 	 */
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index e210aa2..412cae6 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -782,15 +782,8 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle)
 					      acpi_os_get_thread_id());
 
 	if (ACPI_SUCCESS(status)) {
-		/*
-		 * If this was the first acquisition of the Global Lock by this thread,
-		 * create a new handle. Otherwise, return the existing handle.
-		 */
-		if (acpi_gbl_global_lock_mutex->mutex.acquisition_depth == 1) {
-			acpi_gbl_global_lock_handle++;
-		}
 
-		/* Return the global lock handle */
+		/* Return the global lock handle (updated in acpi_ev_acquire_global_lock) */
 
 		*handle = acpi_gbl_global_lock_handle;
 	}
-- 
1.5.5.29.g7134

