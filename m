From: akpm@linux-foundation.org
Subject: [patch 1/8] x86: oqo: depends on INPUT_POLLDEV
Date: Wed, 04 Mar 2009 11:55:24 -0800
Message-ID: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59131 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756207AbZCDT4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

From: Randy Dunlap <randy.dunlap@oracle.com>

oqo driver uses polled input functions, so make it depend
on INPUT_POLLDEV.

ERROR: "input_register_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
ERROR: "input_allocate_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
ERROR: "input_free_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!
ERROR: "input_unregister_polled_device" [drivers/platform/x86/oqo-wmi.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev drivers/platform/x86/Kconfig
--- a/drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev
+++ a/drivers/platform/x86/Kconfig
@@ -137,7 +137,7 @@ config MSI_LAPTOP
 config OQO_WMI
        tristate "OQO WMI extras"
        depends on ACPI_WMI
-       depends on INPUT
+       depends on INPUT && INPUT_POLLDEV
        depends on RFKILL
        depends on BACKLIGHT_CLASS_DEVICE
        help
_
