From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/25] ACPICA: Utilities: Fix memory leak in acpi_ut_copy_iobject_to_iobject
Date: Tue,  8 Jul 2014 10:05:52 +0800
Message-ID: <d2ff6d53cf474fd016ad8e3d53bd7ad92cd9e02e.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31359 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbaGHCF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:05:56 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

Adds return status check on copy routines to delete the allocated destination
object if either copy fails. Reported by Colin Ian King on bugs.acpica.org,
Bug 1087.
The last applicable commit:
 Commit: 3371c19c294a4cb3649aa4e84606be8a1d999e61
 Subject: ACPICA: Remove ACPI_GET_OBJECT_TYPE macro

Reference: https://bugs.acpica.org/show_bug.cgi?id=1087
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: stable <stable@kernel.org>		[3.9.8.x]
---
 drivers/acpi/acpica/utcopy.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 270c164..ff601c0 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -1001,5 +1001,11 @@ acpi_ut_copy_iobject_to_iobject(union acpi_operand_object *source_desc,
 		status = acpi_ut_copy_simple_object(source_desc, *dest_desc);
 	}
 
+	/* Delete the allocated object if copy failed */
+
+	if (ACPI_FAILURE(status)) {
+		acpi_ut_remove_reference(*dest_desc);
+	}
+
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10

