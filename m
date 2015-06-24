From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 18/28] ACPICA: Update for acpi_install_table memory types.
Date: Wed, 24 Jun 2015 11:04:46 +0800
Message-ID: <ec5dc87a4008c23bfc182a2f39ad435bdba26fbe.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51648 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964795AbbFXDEx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:04:53 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Bob Moore <robert.moore@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

ACPICA commit 3f78b7fb3f98f35d62f532c1891deb748ad196c9

Physical/virtual address flags were reversed.

Link: https://github.com/acpica/acpica/commit/3f78b7fb
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 960bd99..cf56e18 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -224,9 +224,9 @@ acpi_install_table(acpi_physical_address address, u8 physical)
 	ACPI_FUNCTION_TRACE(acpi_install_table);
 
 	if (physical) {
-		flags = ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL;
-	} else {
 		flags = ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL;
+	} else {
+		flags = ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL;
 	}
 
 	status = acpi_tb_install_standard_table(address, flags,
-- 
1.7.10

