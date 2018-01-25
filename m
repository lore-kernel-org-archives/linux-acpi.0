From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] acpi: osl: Replace GFP_ATOMIC with GFP_KERNEL in acpi_os_execute
Date: Thu, 25 Jan 2018 18:13:41 +0800
Message-ID: <1516875222-12293-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:38026 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeAYKJM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jan 2018 05:09:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

After checking all possible call chains to acpi_os_execute here,
my tool finds that acpi_os_execute is never called in atomic context.
And acpi_os_execute calls acpi_debugger_create_thread 
which calls mutex_lock,
thus it proves again that acpi_os_execute can 
call functions which may sleep.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3bb46cb..8ee605e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1066,7 +1066,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 * having a static work_struct.
 	 */
 
-	dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
+	dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
 	if (!dpc)
 		return AE_NO_MEMORY;
 
-- 
1.7.9.5

