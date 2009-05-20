From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: x86 platform: oqo: select INPUT_POLLDEV
Date: Tue, 19 May 2009 18:22:10 -0700
Message-ID: <4A135B42.2020208@oracle.com>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org> <200904131916.40428.dmitry.torokhov@gmail.com> <49E4C700.6010309@oracle.com> <alpine.LFD.2.00.0904200026490.10996@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:19949 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbZETBVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 21:21:35 -0400
In-Reply-To: <alpine.LFD.2.00.0904200026490.10996@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

From: Randy Dunlap <randy.dunlap@oracle.com>

OQO_WMI uses INPUT_POLLDEV, but it can select that instead of
depending on it, since it represents library code.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/platform/x86/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20090519.orig/drivers/platform/x86/Kconfig
+++ linux-next-20090519/drivers/platform/x86/Kconfig
@@ -146,9 +146,10 @@ config MSI_LAPTOP
 config OQO_WMI
        tristate "OQO WMI extras"
        depends on ACPI_WMI
-       depends on INPUT && INPUT_POLLDEV
+       depends on INPUT
        depends on RFKILL
        depends on BACKLIGHT_CLASS_DEVICE
+	select INPUT_POLLDEV
        help
          Say Y here if you want to support rfkill and backlight control on
          series 2 OQO handheld devices.


-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
