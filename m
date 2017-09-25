From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] acpi/arm64: pr_err() strings should end with newlines
Date: Mon, 25 Sep 2017 12:15:46 +0530
Message-ID: <d81bee42b06beefa9a7149b5b35bf884836c2595.1506321825.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33675 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbdIYGqw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Sep 2017 02:46:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 597a737..92f9edf 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -199,7 +199,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 	struct acpi_gtdt_timer_entry *gtdt_frame;
 
 	if (!block->timer_count) {
-		pr_err(FW_BUG "GT block present, but frame count is zero.");
+		pr_err(FW_BUG "GT block present, but frame count is zero.\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1

