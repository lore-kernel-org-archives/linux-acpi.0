From: Len Brown <len.brown@intel.com>
Subject: [PATCH 56/65] ACPICA: Fixes for parameter validation.
Date: Fri, 24 Nov 2006 02:19:06 -0500
Message-ID: <11643528173586-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14702 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934503AbWKXHQS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:18 -0500
In-Reply-To: <11643528161204-git-send-email-len.brown@intel.com>
Message-Id: <162f921f22ad8bc804e3c5de1b1e8e8433e35e2d.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Extra checks for valid handle/path combinations, BZ 478

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfname.c |   45 +++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfname.c b/drivers/acpi/namespace/nsxfname.c
index 978213a..408bd11 100644
--- a/drivers/acpi/namespace/nsxfname.c
+++ b/drivers/acpi/namespace/nsxfname.c
@@ -84,38 +84,41 @@ acpi_get_handle(acpi_handle parent,
 	/* Convert a parent handle to a prefix node */
 
 	if (parent) {
-		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-		if (ACPI_FAILURE(status)) {
-			return (status);
-		}
-
 		prefix_node = acpi_ns_map_handle_to_node(parent);
 		if (!prefix_node) {
-			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 			return (AE_BAD_PARAMETER);
 		}
+	}
+
+	/*
+	 * Valid cases are:
+	 * 1) Fully qualified pathname
+	 * 2) Parent + Relative pathname
+	 *
+	 * Error for <null Parent + relative path>
+	 */
+	if (acpi_ns_valid_root_prefix(pathname[0])) {
 
-		status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-		if (ACPI_FAILURE(status)) {
-			return (status);
+		/* Pathname is fully qualified (starts with '\') */
+
+		/* Special case for root-only, since we can't search for it */
+
+		if (!ACPI_STRCMP(pathname, ACPI_NS_ROOT_PATH)) {
+			*ret_handle =
+			    acpi_ns_convert_entry_to_handle(acpi_gbl_root_node);
+			return (AE_OK);
 		}
-	}
+	} else if (!prefix_node) {
 
-	/* Special case for root, since we can't search for it */
+		/* Relative path with null prefix is disallowed */
 
-	if (ACPI_STRCMP(pathname, ACPI_NS_ROOT_PATH) == 0) {
-		*ret_handle =
-		    acpi_ns_convert_entry_to_handle(acpi_gbl_root_node);
-		return (AE_OK);
+		return (AE_BAD_PARAMETER);
 	}
 
-	/*
-	 *  Find the Node and convert to a handle
-	 */
-	status = acpi_ns_get_node(prefix_node, pathname, ACPI_NS_NO_UPSEARCH,
-				  &node);
+	/* Find the Node and convert to a handle */
 
-	*ret_handle = NULL;
+	status =
+	    acpi_ns_get_node(prefix_node, pathname, ACPI_NS_NO_UPSEARCH, &node);
 	if (ACPI_SUCCESS(status)) {
 		*ret_handle = acpi_ns_convert_entry_to_handle(node);
 	}
-- 
1.4.4.1
