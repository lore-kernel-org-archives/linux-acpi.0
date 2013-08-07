From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] ACPI / Sleep: Fix incorrect placement of __initdata
Date: Wed,  7 Aug 2013 17:16:57 +0530
Message-ID: <1375876017-22420-3-git-send-email-sachin.kamat@linaro.org>
References: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48937 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932681Ab3HGMDr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Aug 2013 08:03:47 -0400
Received: by mail-pd0-f175.google.com with SMTP id 5so1297533pdd.20
        for <linux-acpi@vger.kernel.org>; Wed, 07 Aug 2013 05:03:46 -0700 (PDT)
In-Reply-To: <1375876017-22420-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, sachin.kamat@linaro.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/acpi/sleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 81b0f03..0fa6427 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -138,7 +138,7 @@ static int __init init_nvs_nosave(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
+static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 	{
 	.callback = init_old_suspend_ordering,
 	.ident = "Abit KN9 (nForce4 variant)",
-- 
1.7.9.5

