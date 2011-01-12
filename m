From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/9] ACPICA: Remove unused function declarations
Date: Wed, 12 Jan 2011 04:38:05 -0500
Message-ID: <84f6b2a681cd2cc55ecc3fa94bfbe672d7ef4126.1294824789.git.len.brown@intel.com>
References: <1294825090-21150-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:44707 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab1ALJiZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 04:38:25 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW00FDSLG0AQF0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 03:38:25 -0600 (CST)
In-reply-to: <1294825090-21150-1-git-send-email-lenb@kernel.org>
In-reply-to: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
References: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.4.rc1.7.g2cf08

