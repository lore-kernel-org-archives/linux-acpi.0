From: al.stone@linaro.org
Subject: [PATCH 11/12] ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed in HW reduced mode
Date: Sat,  9 Nov 2013 18:36:21 -0700
Message-ID: <1384047382-20623-12-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41314 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab3KJBgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:43 -0500
Received: by mail-ie0-f181.google.com with SMTP id ar20so5804357iec.12
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:43 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/acpica/utxface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index be322c8..fe94b3e 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -187,7 +187,8 @@ acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
 
 	/* Timer resolution - 24 or 32 bits  */
 
-	if (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER) {
+	if (!acpi_gbl_reduced_hardware &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER)) {
 		info_ptr->timer_resolution = 24;
 	} else {
 		info_ptr->timer_resolution = 32;
-- 
1.8.3.1

