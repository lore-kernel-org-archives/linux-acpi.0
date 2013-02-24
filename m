From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] ACPI: processor: Remove redundant NULL check before kfree
Date: Mon, 25 Feb 2013 04:42:53 +0530
Message-ID: <1361747573-29485-1-git-send-email-s.syam@samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36163 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758354Ab3BXXNF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Feb 2013 18:13:05 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1317931pbc.7
        for <linux-acpi@vger.kernel.org>; Sun, 24 Feb 2013 15:13:03 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: syamsidhardh@gmail.com, lenb@kernel.org, rjw@sisk.pl

kfree on NULL pointer is a no-op.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/acpi/processor_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index eff7222..164d495 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -158,8 +158,7 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	}
 
 exit:
-	if (buffer.pointer)
-		kfree(buffer.pointer);
+	kfree(buffer.pointer);
 	return apic_id;
 }
 
-- 
1.7.9.5

