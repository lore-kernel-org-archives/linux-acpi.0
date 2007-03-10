From: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/20] ACPICA: Fix ACPI Global Lock re-entrancy
Date: Fri,  9 Mar 2007 22:49:24 -0500
Message-ID: <11734985831806-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12456 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXCJDto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:44 -0500
In-Reply-To: <11734985822425-git-send-email-len.brown@intel.com>
Message-Id: <610a3d069665ba2b27e42c90129ce640c4d6e515.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

patch "Delete recursive feature of ACPI Global Lock"
broke re-entrancy of the Global Lock.
The common routine to acquire GL is acpi_ev_acquire_global_lock,
so check for re-entrancy _must_ be there, and not anywhere else.

http://bugzilla.kernel.org/show_bug.cgi?id=8066#c9

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index d572700..8dcade6 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -423,6 +423,8 @@ static acpi_status acpi_ev_remove_global_lock_handler(void)
  * the global lock appear as a standard mutex on the OS side.
  *
  *****************************************************************************/
+static acpi_thread_id acpi_ev_global_lock_thread_id;
+static int acpi_ev_global_lock_acquired;
 
 acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 {
@@ -435,11 +437,24 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	 * Only one thread can acquire the GL at a time, the global_lock_mutex
 	 * enforces this. This interface releases the interpreter if we must wait.
 	 */
-	status = acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex, timeout);
+	status = acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex, 0);
+	if (status == AE_TIME) {
+		if (acpi_ev_global_lock_thread_id == acpi_os_get_thread_id()) {
+			acpi_ev_global_lock_acquired++;
+			return AE_OK;
+		}
+	}
+
+	if (ACPI_FAILURE(status)) {
+		status = acpi_ex_system_wait_mutex(acpi_gbl_global_lock_mutex, timeout);
+	}
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
+	acpi_ev_global_lock_thread_id = acpi_os_get_thread_id();
+	acpi_ev_global_lock_acquired++;
+
 	/*
 	 * Make sure that a global lock actually exists. If not, just treat
 	 * the lock as a standard mutex.
@@ -506,6 +521,11 @@ acpi_status acpi_ev_release_global_lock(void)
 		return_ACPI_STATUS(AE_NOT_ACQUIRED);
 	}
 
+	acpi_ev_global_lock_acquired--;
+	if (acpi_ev_global_lock_acquired > 0) {
+		return AE_OK;
+	}
+
 	if (acpi_gbl_global_lock_present) {
 
 		/* Allow any thread to release the lock */
@@ -529,7 +549,8 @@ acpi_status acpi_ev_release_global_lock(void)
 	acpi_gbl_global_lock_acquired = FALSE;
 
 	/* Release the local GL mutex */
-
+	acpi_ev_global_lock_thread_id = 0;
+	acpi_ev_global_lock_acquired = 0;
 	acpi_os_release_mutex(acpi_gbl_global_lock_mutex);
 	return_ACPI_STATUS(status);
 }
-- 
1.5.0.3.310.g05ef5
