From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPI / EC: Fix a memory leak issue in acpi_ec_query()
Date: Thu, 24 Sep 2015 14:54:40 +0800
Message-ID: <9d9cdac8804ddc2ac5bebe6ea53330002b9664c2.1443076693.git.lv.zheng@intel.com>
References: <cover.1443076693.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443076693.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When query handler is not found, "result" is actually stil 0, and
"struct acpi_ec_query" is not NULL, so the deletion code of
"struct acpi_ec_query" at the end of the function cannot be invoked.
As a consequence, memory leak can be observed.

The issue is introduced by this commit:
  Commit: 02b771b64b73226052d6e731a0987db3b47281e9
  Subject: ACPI / EC: Fix an issue caused by the serialized _Qxx

This patch fixes such memory leakage.

Cc: stable@vger.kernel.org  # 4.3.1+
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2614a83..42c66b6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1044,8 +1044,10 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 		goto err_exit;
 
 	mutex_lock(&ec->mutex);
+	result = -ENODATA;
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
+			result = 0;
 			q->handler = acpi_ec_get_query_handler(handler);
 			ec_dbg_evt("Query(0x%02x) scheduled",
 				   q->handler->query_bit);
-- 
1.7.10
