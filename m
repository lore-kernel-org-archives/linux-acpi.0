From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 06/11] ACPI/extlog: Add EDAC dependency
Date: Thu,  6 Apr 2017 11:06:29 +0200
Message-ID: <20170406090634.30950-7-bp@alien8.de>
References: <20170406090634.30950-1-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:58786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756054AbdDFJHT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Apr 2017 05:07:19 -0400
In-Reply-To: <20170406090634.30950-1-bp@alien8.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac <linux-edac@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

We are calling EDAC functions - make the proper dependencies explicit.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 83e5f7e1a20d..a71874df3410 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -469,7 +469,7 @@ config ACPI_WATCHDOG
 
 config ACPI_EXTLOG
 	tristate "Extended Error Log support"
-	depends on X86_MCE && X86_LOCAL_APIC
+	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
 	select RAS
 	default n
-- 
2.11.0

