From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH RESEND] pnp: pnpbios: Add explicit X86_32 dependency to
 PNPBIOS
Date: Sun, 1 May 2016 11:46:17 -0400
Message-ID: <20160501154617.GA14421@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33217 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbcEAPq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 May 2016 11:46:26 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The PNPBIOS driver requires preprocessor defines (located in
include/asm/segment.h) only declared if the architecture is set to
X86_32. If the architecture is set to X86_64, the PNPBIOS driver will
not build properly. The X86 dependecy for the PNPBIOS configuration
option is changed to an explicit X86_32	dependency in order to prevent
an attempt to build for an unsupported architecture.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/pnp/pnpbios/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpbios/Kconfig b/drivers/pnp/pnpbios/Kconfig
index 50c3dd0..a786086 100644
--- a/drivers/pnp/pnpbios/Kconfig
+++ b/drivers/pnp/pnpbios/Kconfig
@@ -3,7 +3,7 @@
 #
 config PNPBIOS
 	bool "Plug and Play BIOS support"
-	depends on ISA && X86
+	depends on ISA && X86_32
 	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
-- 
2.7.3

