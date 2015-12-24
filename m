From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI / debugger: Fix an issue a flag is modified without locking
Date: Thu, 24 Dec 2015 14:16:26 +0800
Message-ID: <e23c86107f37c1c173056d55aded280c67244723.1450937683.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:16910 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbbLXGQa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Dec 2015 01:16:30 -0500
In-Reply-To: <cover.1446790780.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There is one line of code, executed out of locking due to rebase mistakes.
This patch fixes this issue.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_dbg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 381beb2..fa18bd0 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -516,10 +516,10 @@ static int acpi_aml_open(struct inode *inode, struct file *file)
 			ret = -EINVAL;
 			goto err_lock;
 		}
-		acpi_aml_io.flags |= ACPI_AML_OPENED;
 		pr_debug("Debugger thread initialized.\n");
 
 		mutex_lock(&acpi_aml_io.lock);
+		acpi_aml_io.flags |= ACPI_AML_OPENED;
 		acpi_aml_io.out_crc.head = acpi_aml_io.out_crc.tail = 0;
 		acpi_aml_io.in_crc.head = acpi_aml_io.in_crc.tail = 0;
 		pr_debug("Debugger interface opened.\n");
-- 
1.7.10

