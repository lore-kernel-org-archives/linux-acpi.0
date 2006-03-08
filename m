From: Thomas Renninger <trenn@suse.de>
Subject: [PATH] Avoid slab errors on suspend
Date: Wed, 8 Mar 2006 09:04:52 +0100
Message-ID: <200603080904.53204.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:28367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932331AbWCHIEz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 03:04:55 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>

When going into suspend irqs must be disabled for a long time.

There is already a acpi_in_resume variable in osl.c
to not make use of sleeping functions (mem allocs/mutexes).
This one just makes a bit more intensive use of it.

The acpi_in_resume seem to vanish later (pci_link.c):
/*
 * FIXME: this is a workaround to avoid nasty warning.  It will be removed
 * after every device calls pci_disable_device in .resume.
 */
but for now below patch seem to be needed:

Subject: No GFP_KERNEL buffer alloc or mutexes if resuming

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/osl.c   |   10 +++++++---
 drivers/acpi/utils.c |    6 +++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6.15/drivers/acpi/osl.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/osl.c
+++ linux-2.6.15/drivers/acpi/osl.c
@@ -880,7 +880,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
 			  handle, units, timeout));
 
-	if (in_atomic())
+	if (in_atomic() || acpi_in_resume)
 		timeout = 0;
 
 	switch (timeout) {
@@ -1009,7 +1009,7 @@ u8 acpi_os_writable(void *ptr, acpi_size
 
 u32 acpi_os_get_thread_id(void)
 {
-	if (!in_atomic())
+	if (!in_atomic() && !acpi_in_resume)
 		return current->pid;
 
 	return 0;
@@ -1252,7 +1252,11 @@ acpi_status acpi_os_release_object(acpi_
 
 void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
-	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
+	void *object;
+	if (acpi_in_resume)
+		object = kmem_cache_alloc(cache, GFP_ATOMIC);
+	else
+		object = kmem_cache_alloc(cache, GFP_KERNEL);
 	WARN_ON(!object);
 	return object;
 }
Index: linux-2.6.15/drivers/acpi/utils.c
===================================================================
--- linux-2.6.15.orig/drivers/acpi/utils.c
+++ linux-2.6.15/drivers/acpi/utils.c
@@ -250,6 +250,7 @@ acpi_extract_package(union acpi_object *
 
 EXPORT_SYMBOL(acpi_extract_package);
 
+extern int acpi_in_resume;
 acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
@@ -264,7 +265,10 @@ acpi_evaluate_integer(acpi_handle handle
 	if (!data)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 
-	element = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	if (acpi_in_resume)
+		element = kmalloc(sizeof(union acpi_object), GFP_ATOMIC);
+	else
+		element = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!element)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 
