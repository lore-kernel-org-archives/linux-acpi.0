From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/5] ACPI / debugger: Fix regressions that AML debugger stops working
Date: Tue,  5 Jul 2016 19:18:07 +0800
Message-ID: <c42921c3de9a94fcff97a2de7ac5599cc38ec41f.1467717305.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2792 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbcGELSZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2016 07:18:25 -0400
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

The FIFO unlocking mechanism in acpi_dbg has been messed up by the
following commit:
  Commit: 287980e49ffc0f6d911601e7e352a812ed27768e
  Subject: remove lots of IS_ERR_VALUE abuses
It converts !IS_ERR_VALUE(ret) into !ret. This patch fixes the
regression.

Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/acpi_dbg.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 1f41284..ebc8d18 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -602,7 +602,8 @@ static int acpi_aml_read_user(char __user *buf, int len)
 	crc->tail = (crc->tail + n) & (ACPI_AML_BUF_SIZE - 1);
 	ret = n;
 out:
-	acpi_aml_unlock_fifo(ACPI_AML_OUT_USER, !ret);
+	acpi_aml_unlock_fifo(ACPI_AML_OUT_USER,
+			     ret < 0 ? false : true);
 	return ret;
 }
 
@@ -672,7 +673,8 @@ static int acpi_aml_write_user(const char __user *buf, int len)
 	crc->head = (crc->head + n) & (ACPI_AML_BUF_SIZE - 1);
 	ret = n;
 out:
-	acpi_aml_unlock_fifo(ACPI_AML_IN_USER, !ret);
+	acpi_aml_unlock_fifo(ACPI_AML_IN_USER,
+			     ret < 0 ? false : true);
 	return n;
 }
 
-- 
1.7.10

