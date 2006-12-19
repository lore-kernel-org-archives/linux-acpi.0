From: akpm@osdl.org
Subject: [patch 07/19] acpi: don't select PM
Date: Tue, 19 Dec 2006 12:56:13 -0800
Message-ID: <200612192056.kBJKuE4F010026@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34489 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948AbWLSU5B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:57:01 -0500
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
 1 files changed, 1 insertion(+), 1 deletion(-)

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
