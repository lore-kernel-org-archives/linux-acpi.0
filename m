From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 3/6] ACPICA: Remove unused function declarations
Date: Mon, 06 Dec 2010 23:58:50 +0800
Message-ID: <1291651130.2197.85.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61700 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0LFP60 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 10:58:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

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




