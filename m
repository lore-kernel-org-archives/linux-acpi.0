From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 2/5] acpi: add real mutex function calls
Date: Thu,  7 Aug 2008 07:59:40 -0700
Message-ID: <1218121178-13779-3-git-send-email-dwalker@mvista.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62986 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYHGO7q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 10:59:46 -0400
In-Reply-To: <1218121178-13779-2-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Instead of re-using semaphores for the mutex operation, I've
add usage of the kernel mutex for the acpi os mutex
implementation.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/osl.c      |   86 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpiosxf.h |   11 +-----
 2 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..c0184f4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -871,6 +871,92 @@ acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 	return AE_OK;
 }
 
+acpi_status
+acpi_os_create_mutex(acpi_mutex *handle)
+{
+	struct mutex *mutex = NULL;
+
+	mutex = acpi_os_allocate(sizeof(struct mutex));
+	if (!mutex)
+		return AE_NO_MEMORY;
+	memset(mutex, 0, sizeof(struct mutex));
+
+	mutex_init(mutex);
+
+	*handle = (acpi_handle *) mutex;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating mutex[%p].\n",
+			  *handle));
+
+	return AE_OK;
+}
+
+acpi_status acpi_os_delete_mutex(acpi_mutex handle)
+{
+	struct mutex *mutex = (struct mutex *)handle;
+
+	if (!mutex)
+		return AE_BAD_PARAMETER;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting mutex[%p].\n", handle));
+
+	BUG_ON(mutex_is_locked(mutex));
+	kfree(mutex);
+	mutex = NULL;
+
+	return AE_OK;
+}
+
+acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout)
+{
+	acpi_status status = AE_OK;
+	struct mutex *mutex = (struct mutex *)handle;
+	long jiffies;
+	int ret = 0;
+
+	if (!mutex)
+		return AE_BAD_PARAMETER;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for mutex[%p|%d]\n",
+			  handle, timeout));
+
+	if (timeout == ACPI_WAIT_FOREVER)
+		jiffies = MAX_SCHEDULE_TIMEOUT;
+	else
+		jiffies = msecs_to_jiffies(timeout);
+
+	ret = mutex_lock_timeout(mutex, jiffies);
+	if (ret == -ETIME)
+		status = AE_TIME;
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
+				  "Failed to acquire mutex[%p|%d], %s",
+				  handle, timeout,
+				  acpi_format_exception(status)));
+	} else {
+		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
+				  "Acquired mutex[%p|%d]", handle,
+				  timeout));
+	}
+
+	return status;
+}
+
+acpi_status acpi_os_release_mutex(acpi_mutex handle)
+{
+	struct mutex *mutex = (struct mutex *)handle;
+
+	if (!mutex)
+		return AE_BAD_PARAMETER;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Signaling mutex[%p]\n", handle));
+
+	mutex_unlock(mutex);
+
+	return AE_OK;
+}
+
 #ifdef ACPI_FUTURE_USAGE
 u32 acpi_os_get_line(char *buffer)
 {
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 3f93a6b..9032ec3 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -125,18 +125,11 @@ acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
  */
 acpi_status acpi_os_create_mutex(acpi_mutex * out_handle);
 
-void acpi_os_delete_mutex(acpi_mutex handle);
+acpi_status acpi_os_delete_mutex(acpi_mutex handle);
 
 acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
 
-void acpi_os_release_mutex(acpi_mutex handle);
-
-/* Temporary macros for Mutex* interfaces, map to existing semaphore xfaces */
-
-#define acpi_os_create_mutex(out_handle)    acpi_os_create_semaphore (1, 1, out_handle)
-#define acpi_os_delete_mutex(handle)        (void) acpi_os_delete_semaphore (handle)
-#define acpi_os_acquire_mutex(handle,time)  acpi_os_wait_semaphore (handle, 1, time)
-#define acpi_os_release_mutex(handle)       (void) acpi_os_signal_semaphore (handle, 1)
+acpi_status acpi_os_release_mutex(acpi_mutex handle);
 
 /*
  * Memory allocation and mapping
-- 
1.5.5.1.32.gba7d2


