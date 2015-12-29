From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/42] ACPICA: Tools: Add spacing and missing options in acpibin tool
Date: Tue, 29 Dec 2015 13:59:27 +0800
Message-ID: <56917724b1f373a61dceeeb5a413e95849755692.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50288 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbbL2F7b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:59:31 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit e7c8ffbbef3f7ce340e012ae4db63ea16cd09714

The -e option is missing from the acpibin help options, so add
this.  Also, there should be spaces between the filenames for the
-c and -d optios, so add this and expand the field size from 18
to 20 characters in the ACPI_OPTION macro.

Link: https://github.com/acpica/acpica/commit/e7c8ffbb
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 578e37f..8b4ff40 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -87,7 +87,7 @@
 	acpi_os_printf (description);
 
 #define ACPI_OPTION(name, description) \
-	acpi_os_printf (" %-18s%s\n", name, description);
+	acpi_os_printf (" %-20s%s\n", name, description);
 
 /* Check for unexpected exceptions */
 
-- 
1.7.10

