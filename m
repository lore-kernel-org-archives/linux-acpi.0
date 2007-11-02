From: Len Brown <lenb@kernel.org>
Subject: [ACPICA PATCH] fixed event counters
Date: Fri, 2 Nov 2007 13:04:37 -0400
Message-ID: <200711021304.37251.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44199 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334AbXKBREv (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2007 13:04:51 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: Linux-acpi@vger.kernel.org

Bob,
I'm planning to add the following counters to the ACPICA code in Linux.

thanks,
-Len

diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index a1f87b5..8bf4dbe 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -261,7 +261,7 @@ u32 acpi_ev_fixed_event_detect(void)
 			enable_bit_mask)) {
 
 			/* Found an active (signalled) event */
-
+			acpi_fixed_event_count[i]++;
 			int_status |= acpi_ev_fixed_event_dispatch((u32) i);
 		}
 	}
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index af33358..fbb9bec 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -673,6 +673,8 @@ void acpi_ut_init_globals(void)
 	/* GPE support */
 
 	acpi_gpe_count = 0;
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
+		acpi_fixed_event_count[i] = 0;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 24c3f05..a27ba06 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -120,6 +120,7 @@ extern u32 acpi_gbl_nesting_level;
 /* Event counters */
 
 ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
 
 /* Support for dynamic control method tracing mechanism */
 
