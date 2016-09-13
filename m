From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/3] ACPICA: Tables: Fix a regression in acpi_tb_find_table()
Date: Tue, 13 Sep 2016 17:48:21 +0800
Message-ID: <f3df7cb5ed15f2aec870c99f0b4ae68ed75bc002.1473759814.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com> <cover.1473759814.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7156 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbcIMJs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 05:48:27 -0400
In-Reply-To: <cover.1473759814.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

In the following commit, returning value of acpi_tb_find_table() is wrong:
 Subject: ACPICA: Tables: Tune table mutex to be a leaf lock
This causes LoadTable opcode to fail. This patch fixes this mistake.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbfind.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index a3f7b37..f6b9b4e 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -152,5 +152,5 @@ acpi_tb_find_table(char *signature,
 
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-	return_ACPI_STATUS(AE_NOT_FOUND);
+	return_ACPI_STATUS(status);
 }
-- 
1.7.10

