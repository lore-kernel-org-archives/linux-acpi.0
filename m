From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/18] ACPICA: Use acpi_os_create_lock interface
Date: Sun, 29 May 2011 05:43:58 -0400
Message-ID: <3854c8e32f46ffa6ee0bf2eb01137f5a48b2754f.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:35428 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1E2JoT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:19 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00M9YB1U1162@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:19 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Replace spin_lock_init with acpi_os_create_lock.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    9 +++------
 drivers/acpi/acpica/utmutex.c  |   17 ++++++++++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index d69750b..6d512fc 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -226,12 +226,9 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_present;
  * Spinlocks are used for interfaces that can be possibly called at
  * interrupt level
  */
-ACPI_EXTERN spinlock_t _acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
-ACPI_EXTERN spinlock_t _acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
-ACPI_EXTERN spinlock_t _acpi_ev_global_lock_pending_lock; /* For global lock */
-#define acpi_gbl_gpe_lock	&_acpi_gbl_gpe_lock
-#define acpi_gbl_hardware_lock	&_acpi_gbl_hardware_lock
-#define acpi_ev_global_lock_pending_lock &_acpi_ev_global_lock_pending_lock
+ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
+ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
+ACPI_EXTERN acpi_spinlock acpi_ev_global_lock_pending_lock; /* For global lock */
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index a946c68..519d4ee 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -83,9 +83,20 @@ acpi_status acpi_ut_mutex_initialize(void)
 
 	/* Create the spinlocks for use at interrupt level */
 
-	spin_lock_init(acpi_gbl_gpe_lock);
-	spin_lock_init(acpi_gbl_hardware_lock);
-	spin_lock_init(acpi_ev_global_lock_pending_lock);
+	status = acpi_os_create_lock (&acpi_gbl_gpe_lock);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
+	status = acpi_os_create_lock (&acpi_gbl_hardware_lock);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
+	status = acpi_os_create_lock (&acpi_ev_global_lock_pending_lock);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
 
 	/* Mutex for _OSI support */
 	status = acpi_os_create_mutex(&acpi_gbl_osi_mutex);
-- 
1.7.5.3.367.ga9930.dirty

