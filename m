From: "Andi Kleen" <ak@suse.de>
Subject: [PATCH] [6/8] x86_64: Fix up bogus defaults in ACPI Kconfig
Date: Thu, 06 Jul 2006 18:13:56 +0200
Message-ID: <44ad36c4.0CEAESzQ4STq7txj%ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030283AbWGFQN6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2006 12:13:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@osdl.org
Cc: akpm@osdl.org, discuss@x86-64.org, linux-acpi@vger.kernel.org, len.brown@intel.com


No need for video to be always in
No need for ACPI dock driver to be always in
No need for smart battery driver to be always in

Cc: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Andi Kleen <ak@suse.de>

---
 drivers/acpi/Kconfig |    3 ---
 1 files changed, 3 deletions(-)

Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig
+++ linux/drivers/acpi/Kconfig
@@ -107,7 +107,6 @@ config ACPI_BUTTON
 config ACPI_VIDEO
 	tristate "Video"
 	depends on X86
-	default y
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
@@ -136,7 +135,6 @@ config ACPI_FAN
 config ACPI_DOCK
 	tristate "Dock"
 	depends on !ACPI_IBM_DOCK
-	default y
 	help
 	  This driver adds support for ACPI controlled docking stations
 
@@ -357,7 +355,6 @@ config ACPI_SBS
 	tristate "Smart Battery System (EXPERIMENTAL)"
 	depends on X86 && I2C
 	depends on EXPERIMENTAL
-	default y
 	help
 	  This driver adds support for the Smart Battery System.
 	  Depends on I2C (Device Drivers ---> I2C support)
