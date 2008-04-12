From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/73] ACPICA: Fixed a couple compiler warnings for extra extern statements
Date: Sat, 12 Apr 2008 00:24:49 -0400
Message-ID: <eff46b17b9d1a182bf7ead65f26397257a7ab022.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752461AbYDLE16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:58 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acglobal.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index e91008e..44e718e 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -238,6 +238,10 @@ ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 
+#ifndef DEFINE_ACPI_GLOBALS
+
+/* Other miscellaneous */
+
 extern u8 acpi_gbl_shutdown;
 extern u32 acpi_gbl_startup_flags;
 extern const char *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT];
@@ -245,6 +249,8 @@ extern const char *acpi_gbl_highest_dstate_names[4];
 extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 
+#endif
+
 /* Exception codes */
 
 extern char const *acpi_gbl_exception_names_env[];
-- 
1.5.5.29.g7134

