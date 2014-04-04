From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/28] ACPICA: Add EXPORT_SYMBOL macros for install/remove SCI handler interfaces.
Date: Fri,  4 Apr 2014 12:36:47 +0800
Message-ID: <bd1b59f2b4f1913f4b4f36f957e74b0f3d7896c3.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9162 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbaDDEgx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:36:53 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

These recently added interfaces did not have these macros, used
by some hosts.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxface.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index a734b27..a41a0e7 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -457,6 +457,8 @@ exit:
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_install_sci_handler)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_sci_handler
@@ -468,7 +470,6 @@ exit:
  * DESCRIPTION: Remove a handler for a System Control Interrupt.
  *
  ******************************************************************************/
-
 acpi_status acpi_remove_sci_handler(acpi_sci_handler address)
 {
 	struct acpi_sci_handler_info *prev_sci_handler;
@@ -522,6 +523,8 @@ unlock_and_exit:
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_remove_sci_handler)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_global_event_handler
@@ -537,7 +540,6 @@ unlock_and_exit:
  *              Can be used to update event counters, etc.
  *
  ******************************************************************************/
-
 acpi_status
 acpi_install_global_event_handler(acpi_gbl_event_handler handler, void *context)
 {
-- 
1.7.10

