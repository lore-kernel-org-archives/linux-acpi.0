From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/27] ACPICA: Do not repair _TSS return package if _PSS is
 present
Date: Tue, 02 Aug 2011 16:53:07 -0400
Message-ID: <8f9c91273e36e5762c617c23e4fd48d5172e0dac.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61225 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab1HBUxv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:53:51 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB004K7JDOVM2N@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:53:49 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

We can only sort the _TSS return package if there is no _PSS
in the same scope. This is because if _PSS is present, the ACPI
specification dictates that the _TSS Power Dissipation field is
to be ignored, and therefore some BIOSs leave garbage values in
the _TSS Power field(s).  In this case, it is best to just return
the _TSS package as-is.

Reported-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/nspredef.c  |    1 +
 drivers/acpi/acpica/nsrepair2.c |   15 +++++++++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index c7f743c..5552125 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -357,6 +357,7 @@ struct acpi_predefined_data {
 	char *pathname;
 	const union acpi_predefined_info *predefined;
 	union acpi_operand_object *parent_package;
+	struct acpi_namespace_node *node;
 	u32 flags;
 	u8 node_flags;
 };
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 607a9a0..c845c80 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -218,6 +218,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 		goto cleanup;
 	}
 	data->predefined = predefined;
+	data->node = node;
 	data->node_flags = node->flags;
 	data->pathname = pathname;
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 973883b..024c4f2 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -503,6 +503,21 @@ acpi_ns_repair_TSS(struct acpi_predefined_data *data,
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status;
+	struct acpi_namespace_node *node;
+
+	/*
+	 * We can only sort the _TSS return package if there is no _PSS in the
+	 * same scope. This is because if _PSS is present, the ACPI specification
+	 * dictates that the _TSS Power Dissipation field is to be ignored, and
+	 * therefore some BIOSs leave garbage values in the _TSS Power field(s).
+	 * In this case, it is best to just return the _TSS package as-is.
+	 * (May, 2011)
+	 */
+	status =
+	    acpi_ns_get_node(data->node, "^_PSS", ACPI_NS_NO_UPSEARCH, &node);
+	if (ACPI_SUCCESS(status)) {
+		return (AE_OK);
+	}
 
 	status = acpi_ns_check_sorted_list(data, return_object, 5, 1,
 					   ACPI_SORT_DESCENDING,
-- 
1.7.6.396.ge0613

