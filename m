From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/25] acpi: remove counting semaphores
Date: Wed, 28 Oct 2015 03:45:49 +0100
Message-ID: <1446000373-1823620-2-git-send-email-arnd@arndb.de>
References: <1446000373-1823620-1-git-send-email-arnd@arndb.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64127 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbbJ1CqZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 22:46:25 -0400
In-Reply-To: <1446000373-1823620-1-git-send-email-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Counting semaphores are going away, so replace the ACPI code using them
with an open-coded version.

There are too many layers of other code, including mutexes and completions
in ACPI built on top that it's not really possible to maintain a generic
semaphore otherwise.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/osl.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f31c5c5f1b7e..89c535d2154b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -43,7 +43,6 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/jiffies.h>
-#include <linux/semaphore.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -918,17 +917,26 @@ void acpi_os_wait_events_complete(void *context)
 
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
+/*
+ * Linux semaphores are not compatible with the way that ACPI
+ * semaphores are defined, so it's easier to build our own here.
+ */
+struct acpi_os_semaphore {
+	wait_queue_head_t wq;
+	atomic_t count;
+};
+
 acpi_status
 acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
-	struct semaphore *sem = NULL;
+	struct acpi_os_semaphore *sem = NULL;
 
-	sem = acpi_os_allocate(sizeof(struct semaphore));
+	sem = acpi_os_allocate(sizeof(struct acpi_os_semaphore));
 	if (!sem)
 		return AE_NO_MEMORY;
-	memset(sem, 0, sizeof(struct semaphore));
 
-	sema_init(sem, initial_units);
+	init_waitqueue_head(&sem->wq);
+	atomic_set(&sem->count, initial_units);
 
 	*handle = (acpi_handle *) sem;
 
@@ -947,14 +955,14 @@ acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 
 acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct acpi_os_semaphore *sem = (struct acpi_os_semaphore *)handle;
 
 	if (!sem)
 		return AE_BAD_PARAMETER;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
 
-	BUG_ON(!list_empty(&sem->wait_list));
+	BUG_ON(!list_empty(&sem->wq.task_list));
 	kfree(sem);
 	sem = NULL;
 
@@ -967,7 +975,7 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 {
 	acpi_status status = AE_OK;
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct acpi_os_semaphore *sem = (struct acpi_os_semaphore *)handle;
 	long jiffies;
 	int ret = 0;
 
@@ -985,9 +993,17 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 	else
 		jiffies = msecs_to_jiffies(timeout);
 	
-	ret = down_timeout(sem, jiffies);
-	if (ret)
-		status = AE_TIME;
+	if (timeout == ACPI_DO_NOT_WAIT) {
+		ret = atomic_add_unless(&sem->count, -1, 0);
+		if (!ret)
+			status = AE_TIME;
+	} else {
+		ret = wait_event_timeout(sem->wq,
+					 atomic_add_unless(&sem->count, -1, 0),
+					 jiffies);
+		if (ret == 0)
+			status = AE_TIME;
+	}
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
@@ -1008,7 +1024,7 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
  */
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct acpi_os_semaphore *sem = (struct acpi_os_semaphore *)handle;
 
 	if (!sem || (units < 1))
 		return AE_BAD_PARAMETER;
@@ -1019,7 +1035,8 @@ acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n", handle,
 			  units));
 
-	up(sem);
+	if (atomic_inc_return(&sem->count) == 1)
+		wake_up(&sem->wq);
 
 	return AE_OK;
 }
-- 
2.1.0.rc2

