From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / Kconfig: Remove redundant depends on ACPI
Date: Fri, 14 Nov 2014 17:44:07 +0800
Message-ID: <1415958247-7143-1-git-send-email-hanjun.guo@linaro.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40022 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931AbaKNJoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2014 04:44:32 -0500
Received: by mail-pd0-f173.google.com with SMTP id v10so16430455pde.32
        for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2014 01:44:31 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.com>

Since config ACPI_REDUCED_HARDWARE_ONLY is already depended
on ACPI (inside if ACPI / endif), so depdens on ACPI is redundant,
remove it and fix the minor syntax problem also.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.com>
---
 drivers/acpi/Kconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b23fe37..79078b8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -360,15 +360,14 @@ config ACPI_BGRT
 config ACPI_REDUCED_HARDWARE_ONLY
 	bool "Hardware-reduced ACPI support only" if EXPERT
 	def_bool n
-	depends on ACPI
 	help
-	This config item changes the way the ACPI code is built.  When this
-	option is selected, the kernel will use a specialized version of
-	ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
-	resulting kernel will be smaller but it will also be restricted to
-	running in ACPI reduced hardware mode ONLY.
+	  This config item changes the way the ACPI code is built.  When this
+	  option is selected, the kernel will use a specialized version of
+	  ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
+	  resulting kernel will be smaller but it will also be restricted to
+	  running in ACPI reduced hardware mode ONLY.
 
-	If you are unsure what to do, do not enable this option.
+	  If you are unsure what to do, do not enable this option.
 
 source "drivers/acpi/apei/Kconfig"
 
-- 
1.9.1

