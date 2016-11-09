From: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH] acpi: remove redundant declare of acpi_table_parse_entries
Date: Wed, 9 Nov 2016 10:51:23 +0800
Message-ID: <1478659883-371928-1-git-send-email-longpeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53330 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbcKICwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2016 21:52:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, zhaoshenglong@huawei.com, wu.wubin@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

This function declared twice, so remove one.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 include/linux/acpi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 689a8b9..017849e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -220,10 +220,6 @@ int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
 			      acpi_tbl_entry_handler handler,
 			      unsigned int max_entries);
-int __init acpi_table_parse_entries(char *id, unsigned long table_size,
-			      int entry_id,
-			      acpi_tbl_entry_handler handler,
-			      unsigned int max_entries);
 int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
 			      struct acpi_subtable_proc *proc, int proc_num,
 			      unsigned int max_entries);
-- 
1.8.3.1


