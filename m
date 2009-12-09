From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/14] ACPICA: New internal utility function to create Integer
 objects
Date: Wed, 09 Dec 2009 12:22:12 -0500
Message-ID: <502f7efa6ae7c3f6d93dac417af521af1f56bcc7.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57852 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbZLIR6R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:58:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUE007Q3CKWILQ0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:58:19 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

acpi_ut_create_integer_object. This function (when deployed) should
simplify some of the object creation code.  ACPICA BZ 823.

http://www.acpica.org/bugzilla/show_bug.cgi?id=823

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 ++
 drivers/acpi/acpica/utobject.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index f920d89..3a451a2 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -386,6 +386,8 @@ u8 acpi_ut_valid_internal_object(void *object);
 
 union acpi_operand_object *acpi_ut_create_package_object(u32 count);
 
+union acpi_operand_object *acpi_ut_create_integer_object(u64 value);
+
 union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size);
 
 union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size);
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 0207b62..42e658b 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -190,6 +190,35 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_create_integer_object
+ *
+ * PARAMETERS:  initial_value       - Initial value for the integer
+ *
+ * RETURN:      Pointer to a new Integer object, null on failure
+ *
+ * DESCRIPTION: Create an initialized integer object
+ *
+ ******************************************************************************/
+
+union acpi_operand_object *acpi_ut_create_integer_object(u64 initial_value)
+{
+	union acpi_operand_object *integer_desc;
+
+	ACPI_FUNCTION_TRACE(ut_create_integer_object);
+
+	/* Create and initialize a new integer object */
+
+	integer_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	if (!integer_desc) {
+		return_PTR(NULL);
+	}
+
+	integer_desc->integer.value = initial_value;
+	return_PTR(integer_desc);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_create_buffer_object
  *
  * PARAMETERS:  buffer_size            - Size of buffer to be created
-- 
1.6.0.6

