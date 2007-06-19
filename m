From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 2/12] acpi: select ACPI_EC for THINKPAD_ACPI
Date: Wed, 20 Jun 2007 00:48:36 +0200
Message-ID: <20070619224836.GD5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:43504 "EHLO
	outbound3-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759621AbXFSWrs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 18:47:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Fix kernel build problem:

 thinkpad_acpi.c:(.text+0x7486a): undefined reference to `ec_write'

(as THINKPAD_ACPI depends on ACPI_EC)

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/misc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2f2fbff..72774c9 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -139,6 +139,7 @@ config SONYPI_COMPAT
 config THINKPAD_ACPI
 	tristate "ThinkPad ACPI Laptop Extras"
 	depends on X86 && ACPI
+	select ACPI_EC
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	---help---
-- 
1.5.0.7




