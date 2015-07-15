From: "Zhouyi Zhou" <yizhouzhou@ict.ac.cn>
Subject: [PATCH] ACPI: Fix indent for variable declaration
Date: Wed, 15 Jul 2015 10:39:48 +0800 (GMT+08:00)
Message-ID: <193d032.5dbd.14e8f95121f.Coremail.yizhouzhou@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp37.cstnet.cn ([159.226.251.37]:46563 "EHLO cstnet.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751018AbbGOCqC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jul 2015 22:46:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.orglinux-acpi@vger.kernel.org

In function acpi_ns_one_complete_parse, the variable declaration
aml_length is not correctly indented.

Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
---
 drivers/acpi/acpica/nsparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 57a4cfe..802afdc 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -70,7 +70,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
 {
        union acpi_parse_object *parse_root;
        acpi_status status;
-       u32 aml_length;
+       u32 aml_length;
        u8 *aml_start;
        struct acpi_walk_state *walk_state;
        struct acpi_table_header *table;
--
2.4.5







