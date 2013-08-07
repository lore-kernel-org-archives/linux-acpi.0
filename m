From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] ACPI / EC: Fix incorrect placement of __initdata
Date: Wed,  7 Aug 2013 17:16:55 +0530
Message-ID: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42901 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab3HGMDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Aug 2013 08:03:42 -0400
Received: by mail-pd0-f175.google.com with SMTP id 5so1297459pdd.20
        for <linux-acpi@vger.kernel.org>; Wed, 07 Aug 2013 05:03:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 84bf06c..8dd2d4d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -948,7 +948,7 @@ static int ec_enlarge_storm_threshold(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id __initdata ec_dmi_table[] = {
+static struct dmi_system_id ec_dmi_table[] __initdata = {
 	{
 	ec_skip_dsdt_scan, "Compal JFL92", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
-- 
1.7.9.5

