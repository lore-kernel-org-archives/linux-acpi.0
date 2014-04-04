From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/28] ACPICA: utstring: Check array index bound before use.
Date: Fri,  4 Apr 2014 12:36:55 +0800
Message-ID: <f00174b1d89891d977f5cc127201fd7d56e91f61.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17087 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbaDDEhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:37:11 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, David Binderman <dcb314@hotmail.com>, Bob Moore <robert.moore@intel.com>

From: David Binderman <dcb314@hotmail.com>

ACPICA BZ 1077. David Binderman.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1077
Signed-off-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: <stable@vger.kernel.org> # 3.9.x: 42f8fb75: ACPICA: Source restructuring
---
 drivers/acpi/acpica/utstring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 7721933..6dc54b3 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -353,7 +353,7 @@ void acpi_ut_print_string(char *string, u16 max_length)
 	}
 
 	acpi_os_printf("\"");
-	for (i = 0; string[i] && (i < max_length); i++) {
+	for (i = 0; (i < max_length) && string[i]; i++) {
 
 		/* Escape sequences */
 
-- 
1.7.10

