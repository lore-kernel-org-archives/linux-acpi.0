From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] drivers: acpi: Fix dependency for ACPI_HOTPLUG_CPU
Date: Thu,  5 Jan 2012 10:47:58 -0200
Message-ID: <1325767678-12480-1-git-send-email-festevam@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47353 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2AEMsM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jan 2012 07:48:12 -0500
Received: by yhnn56 with SMTP id n56so81714yhn.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jan 2012 04:48:11 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

Fix the following build warning:

warning: (ACPI_HOTPLUG_CPU) selects ACPI_CONTAINER which has unmet direct dependencies (ACPI && EXPERIMENTAL)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7556913..2e4e2bd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -208,7 +208,7 @@ config ACPI_IPMI
 
 config ACPI_HOTPLUG_CPU
 	bool
-	depends on ACPI_PROCESSOR && HOTPLUG_CPU
+	depends on EXPERIMENTAL && ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
 	default y
 
-- 
1.7.1

