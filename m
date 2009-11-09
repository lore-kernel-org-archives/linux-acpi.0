From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] acpica: Add support for unregistering ACPI GPE methods
Date: Mon,  9 Nov 2009 17:44:46 -0500
Message-ID: <1257806687-6608-2-git-send-email-mjg@redhat.com>
References: <1257806687-6608-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49370 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbZKIWpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:45:05 -0500
In-Reply-To: <1257806687-6608-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, robert.moore@intel.com, Matthew Garrett <mjg@redhat.com>

Some vendors ship firmware with untested GPE handlers. The presence of
these handlers may be sufficient to cause the OS to assume that runtime
power management of the associated devices is possible, potentially
resulting in devices being powered down and no wakeup events ever being
generated.

The simplest solution is to add support for the OS to unhook these GPE
methods when it knows that they are broken. Add a function to the ACPICA
code to allow this.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/evxface.c |   69 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    3 ++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 90cdeae..33b1dc0 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -736,6 +736,75 @@ ACPI_EXPORT_SYMBOL(acpi_remove_gpe_handler)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_remove_gpe_method
+ *
+ * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
+ *                                defined GPEs)
+ *              gpe_number      - The event to remove a handler
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove the method for a General Purpose acpi_event.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_remove_gpe_method(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_remove_gpe_method);
+
+	/* Parameter validation */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	/* Make sure that a method is indeed installed */
+
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+	    ACPI_GPE_DISPATCH_METHOD) {
+		status = AE_NOT_EXIST;
+		goto unlock_and_exit;
+	}
+
+	/* Make sure all deferred tasks are completed */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	acpi_os_wait_events_complete(NULL);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Remove the method */
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	gpe_event_info->dispatch.method_node = NULL;
+	gpe_event_info->flags &= ~ACPI_GPE_DISPATCH_METHOD;
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+      unlock_and_exit:
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_remove_gpe_method)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_acquire_global_lock
  *
  * PARAMETERS:  Timeout         - How long the caller is willing to wait
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bb3c975..f89aa7b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -258,6 +258,9 @@ acpi_status
 acpi_remove_gpe_handler(acpi_handle gpe_device,
 			u32 gpe_number, acpi_event_handler address);
 
+acpi_status
+acpi_remove_gpe_method(acpi_handle gpe_device, u32 gpe_number);
+
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
 #endif
-- 
1.6.5.2

