From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/23] ACPICA: fix stray va_end() caused by mis-merge
Date: Wed, 11 Jun 2008 03:59:26 -0400
Message-ID: <ff3ea301109d4c6464250939c36123a923478473.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59222 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYFKH7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:38 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00I8ZGK907XV@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:52:58 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmisc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index e4ba719..1f057b7 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1048,6 +1048,7 @@ acpi_ut_exception(char *module_name,
 	va_start(args, format);
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
+	va_end(args);
 }
 
 EXPORT_SYMBOL(acpi_ut_exception);
@@ -1063,7 +1064,6 @@ acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 	va_end(args);
-	va_end(args);
 }
 
 void ACPI_INTERNAL_VAR_XFACE
-- 
1.5.6.rc2.23.gea81e

