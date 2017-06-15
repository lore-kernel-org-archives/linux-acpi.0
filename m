From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 4/4] ACPI / EC: Add quirk for GL720VMK
Date: Thu, 15 Jun 2017 09:41:53 +0800
Message-ID: <d1f1b373d582ee756a5ed21a886d38c0a34cddbd.1497490457.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1497490457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:23899 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdFOBl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jun 2017 21:41:57 -0400
In-Reply-To: <cover.1497490457.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Carlo Caione <carlo@caione.org>

From: Carlo Caione <carlo@caione.org>

ASUS GL720VMK is also affected by the EC GPE preference issue.

Signed-off-by: Carlo Caione <carlo@caione.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2189048..ab04f0c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1788,7 +1788,7 @@ static int ec_correct_ecdt(const struct dmi_system_id *id)
 
 /*
  * Some DSDTs contain wrong GPE setting.
- * Asus FX502VD/VE, X550VXK, X580VD
+ * Asus FX502VD/VE, GL702VMK, X550VXK, X580VD
  * https://bugzilla.kernel.org/show_bug.cgi?id=195651
  */
 static int ec_honor_ecdt_gpe(const struct dmi_system_id *id)
@@ -1812,6 +1812,10 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "FX502VE"),}, NULL},
 	{
+	ec_honor_ecdt_gpe, "ASUS GL702VMK", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "GL702VMK"),}, NULL},
+	{
 	ec_honor_ecdt_gpe, "ASUS X550VXK", {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
-- 
2.7.4

