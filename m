From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] ACPI / processor: Fix incorrect placement of __initdata
Date: Wed,  7 Aug 2013 17:16:56 +0530
Message-ID: <1375876017-22420-2-git-send-email-sachin.kamat@linaro.org>
References: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57317 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932681Ab3HGMDp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Aug 2013 08:03:45 -0400
Received: by mail-pd0-f177.google.com with SMTP id u10so1314406pdi.22
        for <linux-acpi@vger.kernel.org>; Wed, 07 Aug 2013 05:03:44 -0700 (PDT)
In-Reply-To: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/acpi/processor_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a5e9f4a..cf34d90 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -28,7 +28,7 @@ static int __init set_no_mwait(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id __initdata processor_idle_dmi_table[] = {
+static struct dmi_system_id processor_idle_dmi_table[] __initdata = {
 	{
 	set_no_mwait, "Extensa 5220", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-- 
1.7.9.5

