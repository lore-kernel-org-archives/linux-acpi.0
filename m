From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] acpi: add utility to test for device dma coherency
Date: Tue,  9 Sep 2014 16:57:58 -0400
Message-ID: <1410296278-1244-1-git-send-email-msalter@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaIIU6O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 16:58:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>

ACPI 5.1 adds a _CCA object to indicate memory coherency
of a bus master device. It is an integer with zero meaning
non-coherent and one meaning coherent. This attribute may
be inherited from a parent device. It may also be missing
entirely, in which case, an architecture-specific default
is assumed.

This patch adds a utility function to parse a device handle
(and its parents) for a _CCA object and return the coherency
attribute if found.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/acpi/utils.c    | 26 ++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 07c8c5a..aec9656 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -698,3 +698,29 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
 	return false;
 }
 EXPORT_SYMBOL(acpi_check_dsm);
+
+/**
+ * acpi_check_coherency - check for memory coherency of a device
+ * @handle: ACPI device handle
+ * @val:    Pointer to returned value
+ *
+ * Search a device and its parents for a _CCA method and return
+ * its value.
+ */
+acpi_status acpi_check_coherency(acpi_handle handle, int *val)
+{
+	unsigned long long data;
+	acpi_status status;
+
+	do {
+		status = acpi_evaluate_integer(handle, "_CCA", NULL, &data);
+		if (!ACPI_FAILURE(status)) {
+			*val = data;
+			break;
+		}
+		status = acpi_get_parent(handle, &handle);
+	} while (!ACPI_FAILURE(status));
+
+	return status;
+}
+EXPORT_SYMBOL(acpi_check_coherency);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bcfd808..b97f09d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -68,6 +68,8 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
 			int rev, int func, union acpi_object *argv4);
 
+acpi_status acpi_check_coherency(acpi_handle handle, int *val);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const u8 *uuid, int rev, int func,
 			union acpi_object *argv4, acpi_object_type type)
-- 
1.8.3.1

