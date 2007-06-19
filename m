From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 4/12] acpi: select ACPI_EC for MSI_LAPTOP
Date: Wed, 20 Jun 2007 00:49:32 +0200
Message-ID: <20070619224932.GF5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:56152 "EHLO
	outbound1-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754372AbXFSWtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 18:49:00 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Fix kernel build problem as MSI_LAPTOP depends on ACPI_EC.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/misc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 72774c9..0d6f369 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -99,8 +99,8 @@ config ASUS_LAPTOP
 
 config MSI_LAPTOP
         tristate "MSI Laptop Extras"
-        depends on X86
-        depends on ACPI_EC
+        depends on X86 && ACPI
+        select ACPI_EC
         depends on BACKLIGHT_CLASS_DEVICE
         ---help---
 	  This is a driver for laptops built by MSI (MICRO-STAR
-- 
1.5.0.7




