From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/4] ACPI: WMI: Unmark as 'experimental'
Date: Sat, 14 Feb 2009 09:53:53 +0000
Message-ID: <20090214095353.18550.65697.stgit@localhost>
References: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:33145 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751319AbZBNKNR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Feb 2009 05:13:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pegasus. (8.14.3/8.13.8) with ESMTP id n1E9rrLo018610
	for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 09:53:53 GMT
In-Reply-To: <20090214095342.18550.24339.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

ACPI-WMI isn't experimental anymore, and there are other drivers that now
depend on it that aren't either.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/platform/x86/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9436311..7192f0a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -313,9 +313,8 @@ config EEEPC_LAPTOP
 
 
 config ACPI_WMI
-	tristate "WMI (EXPERIMENTAL)"
+	tristate "WMI"
 	depends on ACPI
-	depends on EXPERIMENTAL
 	help
 	  This driver adds support for the ACPI-WMI (Windows Management
 	  Instrumentation) mapper device (PNP0C14) found on some systems.

