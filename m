From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 5/5] acpi: semaphore removal
Date: Thu,  7 Aug 2008 07:59:43 -0700
Message-ID: <1218121178-13779-6-git-send-email-dwalker@mvista.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:63020 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbYHGO7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 10:59:47 -0400
In-Reply-To: <1218121178-13779-5-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

The semaphore usage in ACPI is more like completions. The ASL
functions getting implemented here are signals which follow a
"wait for", signaled, or reset format.

This implements the ACPI signaling methods with the Linux
completion API, instead of using semaphores.

completion_done() taken from Dave Chinner.

Cc: linux-acpi@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/osl.c         |   54 ++++++++++++++++++++++---------------------
 include/linux/completion.h |   19 +++++++++++++++
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7340baf..2e4ae01 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -43,7 +43,7 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/jiffies.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -768,42 +768,44 @@ void acpi_os_delete_lock(acpi_spinlock handle)
 acpi_status
 acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
-	struct semaphore *sem = NULL;
+	struct completion *comp = NULL;
 
-	sem = acpi_os_allocate(sizeof(struct semaphore));
-	if (!sem)
+	BUG_ON(initial_units);
+
+	comp = acpi_os_allocate(sizeof(struct completion));
+	if (!comp)
 		return AE_NO_MEMORY;
-	memset(sem, 0, sizeof(struct semaphore));
+	memset(comp, 0, sizeof(struct completion));
 
-	sema_init(sem, initial_units);
+	init_completion(comp);
 
-	*handle = (acpi_handle *) sem;
+	*handle = (acpi_handle *) comp;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating semaphore[%p|%d].\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating completion[%p|%d].\n",
 			  *handle, initial_units));
 
 	return AE_OK;
 }
 
 /*
- * TODO: A better way to delete semaphores?  Linux doesn't have a
- * 'delete_semaphore()' function -- may result in an invalid
+ * TODO: A better way to delete completions?  Linux doesn't have a
+ * 'delete_completions()' function -- may result in an invalid
  * pointer dereference for non-synchronized consumers.	Should
  * we at least check for blocked threads and signal/cancel them?
  */
 
 acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 
-	if (!sem)
+	if (!comp)
 		return AE_BAD_PARAMETER;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting completion[%p].\n", handle));
 
-	BUG_ON(!list_empty(&sem->wait_list));
-	kfree(sem);
-	sem = NULL;
+	BUG_ON(!completion_done(comp));
+	kfree(comp);
+	comp = NULL;
 
 	return AE_OK;
 }
@@ -814,17 +816,17 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 {
 	acpi_status status = AE_OK;
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 	long jiffies;
 	int ret = 0;
 
-	if (!sem || (units < 1))
+	if (!comp || (units < 1))
 		return AE_BAD_PARAMETER;
 
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for completion[%p|%d|%d]\n",
 			  handle, units, timeout));
 
 	if (timeout == ACPI_WAIT_FOREVER)
@@ -832,18 +834,18 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
 	else
 		jiffies = msecs_to_jiffies(timeout);
 	
-	ret = down_timeout(sem, jiffies);
+	ret = wait_for_completion_timeout(comp, jiffies);
 	if (ret)
 		status = AE_TIME;
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Failed to acquire semaphore[%p|%d|%d], %s",
+				  "Failed to acquire completion[%p|%d|%d], %s",
 				  handle, units, timeout,
 				  acpi_format_exception(status)));
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Acquired semaphore[%p|%d|%d]", handle,
+				  "Acquired completion[%p|%d|%d]", handle,
 				  units, timeout));
 	}
 
@@ -855,18 +857,18 @@ acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
  */
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 {
-	struct semaphore *sem = (struct semaphore *)handle;
+	struct completion *comp = (struct completion *)handle;
 
-	if (!sem || (units < 1))
+	if (!comp || (units < 1))
 		return AE_BAD_PARAMETER;
 
 	if (units > 1)
 		return AE_SUPPORT;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling semaphore[%p|%d]\n", handle,
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling completion[%p|%d]\n", handle,
 			  units));
 
-	up(sem);
+	complete(comp);
 
 	return AE_OK;
 }
diff --git a/include/linux/completion.h b/include/linux/completion.h
index d2961b6..00b1288 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -36,6 +36,25 @@ struct completion {
 # define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
 #endif
 
+/**
+ *	completion_done - Test to see if a completion has any waiters
+ *	@x:	completion structure
+ *
+ *	Returns: 0 if there are waiters (wait_for_completion() in progress)
+ *		 1 if there are no waiters.
+ *
+ */
+static inline bool completion_done(struct completion *x)
+{
+	int ret = 1;
+
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done)
+		ret = 0;
+	spin_unlock_irq(&x->wait.lock);
+	return ret;
+}
+
 static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
-- 
1.5.5.1.32.gba7d2

