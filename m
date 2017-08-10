From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH] acpi: apei: fix the wrongly parse generic error status block
Date: Fri, 11 Aug 2017 02:06:52 +0800
Message-ID: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3502 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbdHJRnW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2017 13:43:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gengdongjiu@huawei.com

The revision 0x300 generic error data entry is different with the old
version. when ghes_do_proc traverses to get the data entry, it does not
consider this difference. so when error status block has revision 0x300
data entry, it will have issue.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/acpi/apei/apei-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 6e9f14c0a71b..6491f1c4a96e 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -122,8 +122,8 @@ struct dentry *apei_get_debugfs_dir(void);
 
 #define apei_estatus_for_each_section(estatus, section)			\
 	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
-	     (void *)section - (void *)estatus < estatus->data_length;	\
-	     section = (void *)(section+1) + section->error_data_length)
+	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
+	     section = acpi_hest_get_next(section))
 
 static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 {
-- 
2.14.0

