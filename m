From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/14] ACPICA: Fix possible fault if return Package objects
 contain NULL elements
Date: Wed, 09 Dec 2009 12:22:10 -0500
Message-ID: <419a909dd10142d015dd96457db1b1eda643f89e.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:65407 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbZLIRWh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:37 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00CTTAX8UOOK@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:26 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

For predefined name validation. Also adds a warning if a NULL
element is followed by any non-null elements.  ACPICA BZ 813, 814.

http://www.acpica.org/bugzilla/show_bug.cgi?id=813
http://www.acpica.org/bugzilla/show_bug.cgi?id=814

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c |   43 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index f8427af..4028098 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -601,7 +601,8 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		 * there is only one entry). We may be able to repair this by
 		 * wrapping the returned Package with a new outer Package.
 		 */
-		if ((*elements)->common.type != ACPI_TYPE_PACKAGE) {
+		if (*elements
+		    && ((*elements)->common.type != ACPI_TYPE_PACKAGE)) {
 
 			/* Create the new outer package and populate it */
 
@@ -673,6 +674,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	union acpi_operand_object *sub_package;
 	union acpi_operand_object **sub_elements;
 	acpi_status status;
+	u8 non_trailing_null = FALSE;
 	u32 expected_count;
 	u32 i;
 	u32 j;
@@ -680,6 +682,45 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	/* Validate each sub-Package in the parent Package */
 
 	for (i = 0; i < count; i++) {
+		/*
+		 * Handling for NULL package elements. For now, we will simply allow
+		 * a parent package with trailing NULL elements. This can happen if
+		 * the package was defined to be longer than the initializer list.
+		 * This is legal as per the ACPI specification. It is often used
+		 * to allow for dynamic initialization of a Package.
+		 *
+		 * A future enhancement may be to simply truncate the package to
+		 * remove the trailing NULL elements.
+		 */
+		if (!(*elements)) {
+			if (!non_trailing_null) {
+
+				/* Ensure the remaining elements are all NULL */
+
+				for (j = 1; j < (count - i + 1); j++) {
+					if (elements[j]) {
+						non_trailing_null = TRUE;
+					}
+				}
+
+				if (!non_trailing_null) {
+
+					/* Ignore the trailing NULL elements */
+
+					return (AE_OK);
+				}
+			}
+
+			/* There are trailing non-null elements, issue warning */
+
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      data->node_flags,
+					      "Found NULL element at package index %u",
+					      i));
+			elements++;
+			continue;
+		}
+
 		sub_package = *elements;
 		sub_elements = sub_package->package.elements;
 
-- 
1.6.0.6

