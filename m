From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/3] acpi: add a utility function for evaluating _FIT
Date: Wed,  7 Oct 2015 15:49:36 -0600
Message-ID: <1444254577-23744-3-git-send-email-vishal.l.verma@intel.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27349 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbbJGVuA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2015 17:50:00 -0400
In-Reply-To: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

_FIT is an ACPI method to request an updated NFIT (Nvdimm Firmware
Interface Table) after a hotplug event. Add a function to evaluate the
_FIT method and return a buffer with the updated NFIT.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-nvdimm@lists.01.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/utils.c    | 23 +++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 475c907..78f7c69 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -614,6 +614,29 @@ acpi_status acpi_evaluate_lck(acpi_handle handle, int lock)
 }
 
 /**
+ * acpi_evaluate_fit: Evaluate _FIT method to get an updated NFIT
+ * @handle: ACPI device handle
+ * @buf: buffer for the updated NFIT
+ *
+ * Evaluate device's _FIT method if present to get an updated NFIT
+ */
+acpi_status acpi_evaluate_fit(acpi_handle handle, struct acpi_buffer **buf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = acpi_evaluate_object(handle, "_FIT", NULL, &buffer);
+
+	if (ACPI_FAILURE(status))
+		return status;
+
+	*buf = &buffer;
+
+	return status;
+}
+EXPORT_SYMBOL(acpi_evaluate_fit);
+
+/**
  * acpi_evaluate_dsm - evaluate device's _DSM method
  * @handle: ACPI device handle
  * @uuid: UUID of requested functions, should be 16 bytes
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5ba8fb6..7483399 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -61,6 +61,7 @@ bool acpi_ata_match(acpi_handle handle);
 bool acpi_bay_match(acpi_handle handle);
 bool acpi_dock_match(acpi_handle handle);
 
+acpi_status acpi_evaluate_fit(acpi_handle handle, struct acpi_buffer **buf);
 bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
 			int rev, int func, union acpi_object *argv4);
-- 
2.4.3

