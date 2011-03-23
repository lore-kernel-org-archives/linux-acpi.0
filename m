From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 2/3] ACPICA: Use acpi_os_create_lock interface
Date: Wed, 23 Mar 2011 17:26:35 +0800
Message-ID: <1300872396-16522-3-git-send-email-ming.m.lin@intel.com>
References: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5458 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943Ab1CWJSv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2011 05:18:51 -0400
In-Reply-To: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Replace spin_lock_init with acpi_os_create_lock.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
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
1.7.3

