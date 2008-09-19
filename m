From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] toshiba_acpi: depends on INPUT
Date: Fri, 19 Sep 2008 14:06:59 -0700
Message-ID: <20080919140659.2b526022.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:13651 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbYISVIC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Sep 2008 17:08:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: toshiba_acpi@memebeam.org, lenb@kernel.org, akpm <akpm@linux-foundation.org>

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
---
 drivers/acpi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20080918.orig/drivers/acpi/Kconfig
+++ linux-next-20080918/drivers/acpi/Kconfig
@@ -270,7 +270,7 @@ config ACPI_PANASONIC
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86
+	depends on X86 && INPUT
 	select INPUT_POLLDEV
 	select NET
 	select RFKILL
