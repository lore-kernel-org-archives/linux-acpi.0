From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH] acpi: use a different lock keys for spinlock
Date: Sat, 4 Jun 2011 12:39:30 +0200
Message-ID: <20110604103930.GA28714@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:51418 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359Ab1FDKjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Jun 2011 06:39:32 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

There is one functions which creates three spinlocks. Therefore lockdep
thinks that this is the same kind of a lock and assumes dead locks for
instance during poweroff.
I personally don't like this onion code and I don't think that we have
this somewhere else in the kernel except maybe in staging.
Adding the lockkey makes lockdep think that the three locks are
different even if allocated in the same place.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 drivers/acpi/acpica/evglock.c |    5 ++++-
 drivers/acpi/acpica/utmutex.c |    6 ++++--
 drivers/acpi/osl.c            |    3 ++-
 include/acpi/acpiosxf.h       |    2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 56a562a..9c6cfa5 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -64,6 +64,8 @@ static u32 acpi_ev_global_lock_handler(void *context);
  *
  ******************************************************************************/
 
+static struct lock_class_key gbl_pending_lk;
+
 acpi_status acpi_ev_init_global_lock_handler(void)
 {
 	acpi_status status;
@@ -90,7 +92,8 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	status = acpi_os_create_lock(&acpi_gbl_global_lock_pending_lock);
+	status = acpi_os_create_lock(&acpi_gbl_global_lock_pending_lock,
+			&gbl_pending_lk);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 7d797e2..8eb8dd1 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -64,6 +64,8 @@ static void acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
  *              spin locks, and reader/writer locks.
  *
  ******************************************************************************/
+static struct lock_class_key gbl_gpe_lk;
+static struct lock_class_key gbl_hw_lk;
 
 acpi_status acpi_ut_mutex_initialize(void)
 {
@@ -83,12 +85,12 @@ acpi_status acpi_ut_mutex_initialize(void)
 
 	/* Create the spinlocks for use at interrupt level */
 
-	status = acpi_os_create_lock (&acpi_gbl_gpe_lock);
+	status = acpi_os_create_lock(&acpi_gbl_gpe_lock, &gbl_gpe_lk);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
 
-	status = acpi_os_create_lock (&acpi_gbl_hardware_lock);
+	status = acpi_os_create_lock(&acpi_gbl_hardware_lock, &gbl_hw_lk);
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 52ca964..4422fc3 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1336,7 +1336,7 @@ EXPORT_SYMBOL(acpi_resources_are_enforced);
  * Create and initialize a spinlock.
  */
 acpi_status
-acpi_os_create_lock(acpi_spinlock *out_handle)
+acpi_os_create_lock(acpi_spinlock *out_handle, struct lock_class_key *key)
 {
 	spinlock_t *lock;
 
@@ -1344,6 +1344,7 @@ acpi_os_create_lock(acpi_spinlock *out_handle)
 	if (!lock)
 		return AE_NO_MEMORY;
 	spin_lock_init(lock);
+	lockdep_set_class(lock, key);
 	*out_handle = lock;
 
 	return AE_OK;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a756bc8..18f2acc 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -99,7 +99,7 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
  * Spinlock primitives
  */
 acpi_status
-acpi_os_create_lock(acpi_spinlock *out_handle);
+acpi_os_create_lock(acpi_spinlock *out_handle, struct lock_class_key *key);
 
 void acpi_os_delete_lock(acpi_spinlock handle);
 
-- 
1.7.4.4

