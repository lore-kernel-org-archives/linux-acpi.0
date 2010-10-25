From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/60] ACPICA: Make acpi_gbl_system_awake_and_running
 publically available
Date: Mon, 25 Oct 2010 02:20:18 -0400
Message-ID: <31b3d4c3b3c599a2329c3e66ffab7a045b169c85.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38306 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0JYJLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added extern for this boolean in acpixf.h. Some hosts utilize
this value during suspend/restore operations.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 include/acpi/acpixf.h          |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fe50f57..b8dbb9b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -132,6 +132,7 @@ struct acpi_table_fadt acpi_gbl_FADT;
 u32 acpi_current_gpe_count;
 u32 acpi_gbl_trace_flags;
 acpi_name acpi_gbl_trace_method_name;
+u8 acpi_gbl_system_awake_and_running;
 
 #endif
 
@@ -278,7 +279,6 @@ ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
 ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
 ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
-ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 ACPI_EXTERN u8 acpi_gbl_osi_data;
 ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bfa252b..c156e5e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -72,6 +72,7 @@ extern u8 acpi_gbl_truncate_io_addresses;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
+extern u8 acpi_gbl_system_awake_and_running;
 
 extern u32 acpi_rsdt_forced;
 /*
-- 
1.7.3.2.90.gd4c43

