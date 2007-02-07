From: Len Brown <lenb@kernel.org>
Subject: [PATCH 97/140] ACPICA: Fixes for parameter validation.
Date: Wed,  7 Feb 2007 13:51:51 -0500
Message-ID: <11708745111301-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <f1c2b1daf040d2feebfbbd4a0cd80cde856fc031.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422838AbXBGSzP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:15 -0500
In-Reply-To: <11708745101255-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
1.5.0.rc3.39.gec804
