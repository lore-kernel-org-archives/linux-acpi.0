From: Len Brown <lenb@kernel.org>
Subject: [PATCH 031/122] toshiba_acpi: depends on INPUT
Date: Thu, 23 Oct 2008 02:38:05 -0400
Message-ID: <b3cef8f6eba47a10b80aa3e7a99e27110e34f3df.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40876 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbYJWGjz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:55 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96000X1IIHXXG2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:54 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

CONFIG_ACPI_TOSHIBA can =y when CONFIG_INPUT=m, so prevent that
combination and its subsequent build errors:

toshiba_acpi.c:(.text+0x3e877): undefined reference to `input_event'
toshiba_acpi.c:(.text+0x3e98a): undefined reference to `input_unregister_polled_device'
toshiba_acpi.c:(.text+0x3e994): undefined reference to `input_free_polled_device'
toshiba_acpi.c:(.init.text+0x21b4): undefined reference to `input_allocate_polled_device'
toshiba_acpi.c:(.init.text+0x2263): undefined reference to `input_register_polled_device'
make[1]: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 735f5ea..79540db 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -259,7 +259,7 @@ config ACPI_ASUS
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86
+	depends on X86 && INPUT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to certain system settings
-- 
1.5.5.1

