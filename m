From: al.stone@linaro.org
Subject: [PATCH 06/12] ACPI: ensure several FADT fields are only used in HW reduced mode
Date: Sat,  9 Nov 2013 18:36:16 -0700
Message-ID: <1384047382-20623-7-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53853 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611Ab3KJBgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:38 -0500
Received: by mail-ie0-f177.google.com with SMTP id e14so5560446iej.8
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:37 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

In acpi_os_terminate(), it was assumed that several FADT entries were
mapped into memory.  For HW reduced mode, that will not be the case.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/osl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 017b85c..075545e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1812,10 +1812,12 @@ acpi_status acpi_os_terminate(void)
 						 acpi_irq_handler);
 	}
 
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
-	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	if (!acpi_gbl_reduced_hardware) {
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	}
 
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
-- 
1.8.3.1

