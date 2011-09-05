From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI, APEI, fix ERST table size checking
Date: Mon,  5 Sep 2011 14:07:36 -0700
Message-ID: <1315256856-14170-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33602 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab1IEVHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2011 17:07:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Check ERST size against acpi_table_erst rather than
acpi_table_einj.  The original code just so happened to work
because the ERST and EINJ headers are the same size.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/apei/erst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 2ca59dc..5f6153e 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -917,7 +917,7 @@ static int erst_check_table(struct acpi_table_erst *erst_tab)
 {
 	if ((erst_tab->header_length !=
 	     (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
-	    && (erst_tab->header_length != sizeof(struct acpi_table_einj)))
+	    && (erst_tab->header_length != sizeof(struct acpi_table_erst)))
 		return -EINVAL;
 	if (erst_tab->header.length < sizeof(struct acpi_table_erst))
 		return -EINVAL;
-- 
1.7.0.4

