From: Len Brown <len.brown@intel.com>
Subject: [PATCH 067/105] ACPI: Improve acpi debug documentation
Date: Sun, 29 Apr 2007 00:51:07 -0400
Message-ID: <11778223673988-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146AbXD2Ews (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:48 -0400
In-Reply-To: <11778223663850-git-send-email-len.brown@intel.com>
Message-Id: <f989106cac719f8fe91da7734e73b3ca09146ecc.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Now we use acpi.debug_level and acpi.debug_layer as kernel boot
parameters instead of acpi_dbg_level and acpi_dbg_layer.
Thanks to Andi Kleen for pointing it out.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 12533a9..e3394eb 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -181,19 +181,41 @@ and is between 256 and 4096 characters. It is defined in the file
 			that require a timer override, but don't have
 			HPET
 
-	acpi_dbg_layer=	[HW,ACPI]
+	acpi.debug_layer=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug layer,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
-			via /proc/acpi/debug_layer.
-
-	acpi_dbg_level=	[HW,ACPI]
+			via /sys/module/acpi/parameters/debug_layer.
+			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
+			Available bits (add the numbers together) to enable debug output
+			for specific parts of the ACPI subsystem:
+			0x01 utilities 0x02 hardware 0x04 events 0x08 tables
+			0x10 namespace 0x20 parser 0x40 dispatcher
+			0x80 executer 0x100 resources 0x200 acpica debugger
+			0x400 os services 0x800 acpica disassembler.
+			The number can be in decimal or prefixed with 0x in hex.
+			Warning: Many of these options can produce a lot of
+			output and make your system unusable. Be very careful.
+
+	acpi.debug_level=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug level,
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
-			via /proc/acpi/debug_level.
+			via /sys/module/acpi/parameters/debug_level.
+			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
+			Available bits (add the numbers together) to enable different
+			debug output levels of the ACPI subsystem:
+			0x01 error 0x02 warn 0x04 init 0x08 debug object
+			0x10 info 0x20 init names 0x40 parse 0x80 load
+			0x100 dispatch 0x200 execute 0x400 names 0x800 operation region
+			0x1000 bfield 0x2000 tables 0x4000 values 0x8000 objects
+			0x10000 resources 0x20000 user requests 0x40000 package.
+			The number can be in decimal or prefixed with 0x in hex.
+			Warning: Many of these options can produce a lot of
+			output and make your system unusable. Be very careful.
+
 
 	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
 
-- 
1.5.2.rc0.34.gda94
