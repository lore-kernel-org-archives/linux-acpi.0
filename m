From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 4/8] ACPICA: Remove unused function declarations
Date: Mon, 13 Dec 2010 13:38:55 +0800
Message-ID: <1292218735.10384.93.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20295 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab0LMFeX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 00:34:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ebb467f..04a83fe 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -51,8 +51,6 @@ acpi_status acpi_ev_initialize_events(void);
 
 acpi_status acpi_ev_install_xrupt_handlers(void);
 
-acpi_status acpi_ev_install_fadt_gpes(void);
-
 u32 acpi_ev_fixed_event_detect(void);
 
 /*
@@ -127,10 +125,6 @@ acpi_status
 acpi_ev_match_gpe_method(acpi_handle obj_handle,
 			 u32 level, void *context, void **return_value);
 
-acpi_status
-acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
-			  u32 level, void *context, void **return_value);
-
 /*
  * evgpeutil - GPE utilities
  */
-- 
1.5.3




