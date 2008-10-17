From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] panasonic-laptop: depends on ACPI
Date: Fri, 17 Oct 2008 13:46:08 -0700
Message-ID: <48F8F990.1060807@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:31458 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbYJQUqk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 16:46:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: laforge@gnumonks.org, lenb@kernel.org, linux-acpi@vger.kernel.org, akpm <akpm@osdl.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

panasonic-laptop uses many acpi_*() functions so it should
depend on ACPI; otherwise there are approximately 70
warnings/errors generated.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/misc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20081017.orig/drivers/misc/Kconfig
+++ linux-next-20081017/drivers/misc/Kconfig
@@ -248,7 +248,7 @@ config MSI_LAPTOP
 
 config PANASONIC_LAPTOP
 	tristate "Panasonic Laptop Extras"
-	depends on X86 && INPUT
+	depends on X86 && INPUT && ACPI
         depends on BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to backlight control and hotkeys
