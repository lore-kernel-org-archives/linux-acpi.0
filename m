From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 12/12] acpi: select ACPI_EC for SONY_LAPTOP
Date: Wed, 20 Jun 2007 00:52:25 +0200
Message-ID: <20070619225225.GN5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:10122 "EHLO
	outbound3-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761119AbXFSWwK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 18:52:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Fix kernel build problem as SONY_LAPTOP depends on ACPI_EC.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/misc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0d6f369..463fa41 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -119,6 +119,7 @@ config MSI_LAPTOP
 config SONY_LAPTOP
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
+	select ACPI_EC
 	select BACKLIGHT_CLASS_DEVICE
 	  ---help---
 	  This mini-driver drives the SNC and SPIC devices present in the ACPI
-- 
1.5.0.7




