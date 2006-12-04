From: akpm@osdl.org
Subject: [patch 08/13] acpi: don't select PM
Date: Mon, 04 Dec 2006 14:49:42 -0800
Message-ID: <200612042250.kB4MoopU007376@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:50315 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967723AbWLDWvs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, len.brown@intel.com

From: Andrew Morton <akpm@osdl.org>

Make ACPI depend on PM rather than selecting it.  Otherwise it's a nightmare
working out why CONFIG_PM keeps getting set.

(And why does ACPI require power management?)

Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/Kconfig~acpi-dont-select-pm drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig~acpi-dont-select-pm
+++ a/drivers/acpi/Kconfig
@@ -11,7 +11,7 @@ config ACPI
 	bool "ACPI Support"
 	depends on IA64 || X86
 	depends on PCI
-	select PM
+	depends on PM
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
_
