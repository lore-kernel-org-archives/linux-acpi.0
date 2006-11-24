From: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/65] ACPICA: Add acpi_gpe_count global to track the number of GPE events
Date: Fri, 24 Nov 2006 02:18:28 -0500
Message-ID: <11643527804057-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41586 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757622AbWKXHPm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:42 -0500
In-Reply-To: <11643527782767-git-send-email-len.brown@intel.com>
Message-Id: <37c6794383d6d3c1c816a1ebedd0bcc49510c5d8.1164352293.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c       |    2 ++
 drivers/acpi/utilities/utglobal.c |    2 ++
 include/acpi/acglobal.h           |    4 ++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 1f98818..d9f71dd 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -618,6 +618,8 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
+	acpi_gpe_count++;
+
 	/*
 	 * If edge-triggered, clear the GPE status bit now.  Note that
 	 * level-triggered events are cleared after the GPE is serviced.
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 8809306..a524e75 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -720,6 +720,7 @@ void acpi_ut_init_globals(void)
 
 	/* GPE support */
 
+	acpi_gpe_count = 0;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
@@ -779,3 +780,4 @@ void acpi_ut_init_globals(void)
 
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+ACPI_EXPORT_SYMBOL(acpi_gpe_count)
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 88ad8f4..019b86e 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -80,6 +80,10 @@ extern u32 acpi_dbg_layer;
 
 extern u32 acpi_gbl_nesting_level;
 
+/* Event counters */
+
+ACPI_EXTERN u32 acpi_gpe_count;
+
 /* Support for dynamic control method tracing mechanism */
 
 ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
-- 
1.4.4.1
