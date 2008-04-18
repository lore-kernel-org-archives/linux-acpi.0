From: akpm@linux-foundation.org
Subject: [patch 8/9] acpi: check a return value correctly in acpi_power_get_context()
Date: Fri, 18 Apr 2008 13:27:29 -0700
Message-ID: <200804182027.m3IKRTq7013561@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47020 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753124AbYDRU1y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Apr 2008 16:27:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, lizf@cn.fujitsu.com, yakui.zhao@intel.com

From: Li Zefan <lizf@cn.fujitsu.com>

We should check *resource != NULL rather than resource != NULL, which will be
always true.

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
Acked-by: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/power.c~acpi-check-a-return-value-correctly-in-acpi_power_get_context drivers/acpi/power.c
--- a/drivers/acpi/power.c~acpi-check-a-return-value-correctly-in-acpi_power_get_context
+++ a/drivers/acpi/power.c
@@ -121,7 +121,7 @@ acpi_power_get_context(acpi_handle handl
 	}
 
 	*resource = acpi_driver_data(device);
-	if (!resource)
+	if (!*resource)
 		return -ENODEV;
 
 	return 0;
_
