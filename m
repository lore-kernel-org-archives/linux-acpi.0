From: Len Brown <lenb@kernel.org>
Subject: [PATCH 80/94] ACPICA: Fixes for various ACPI data tables
Date: Fri, 09 Jan 2009 04:27:22 -0500
Message-ID: <7488c8d51134a152f022bc11547157f80a725ff1.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56614 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbZAIKR7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:17:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LXC8LRL4S7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:17:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Eliminate extraneous "zero length subtable" messages.
Fix subtable output for ERST, MCFG, EINJ tables.
Implement all subtables for HEST.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |    8 ++++++++
 include/acpi/actbl1.h   |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 0c1ed38..8eb1d48 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -173,6 +173,14 @@ extern struct acpi_dmtable_info acpi_dm_table_info_fadt2[];
 extern struct acpi_dmtable_info acpi_dm_table_info_gas[];
 extern struct acpi_dmtable_info acpi_dm_table_info_header[];
 extern struct acpi_dmtable_info acpi_dm_table_info_hest[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest0[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest1[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest3[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest4[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest5[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest6[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest7[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest8[];
 extern struct acpi_dmtable_info acpi_dm_table_info_hest9[];
 extern struct acpi_dmtable_info acpi_dm_table_info_hest_notify[];
 extern struct acpi_dmtable_info acpi_dm_table_info_hpet[];
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 63f5b4c..18963b9 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -627,7 +627,7 @@ struct acpi_hest_aer_common {
 	u32 uncorrectable_error_mask;
 	u32 uncorrectable_error_severity;
 	u32 correctable_error_mask;
-	u32 advanced_error_cababilities;
+	u32 advanced_error_capabilities;
 };
 
 /* Hardware Error Notification */
-- 
1.5.6.6

