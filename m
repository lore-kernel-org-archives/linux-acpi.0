From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] SFI, x86: hook e820() for memory map initialization
Date: Wed, 08 Jul 2009 00:13:54 -0400
Message-ID: <5bf6b3c7c08a76ea8dc52e9e07728c2958938952.1247025117.git.len.brown@intel.com>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:19783 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710AbZGHEOZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 00:14:25 -0400
In-reply-to: <1247026438-20891-1-git-send-email-lenb@kernel.org>
In-reply-to: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
References: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>

From: Feng Tang <feng.tang@intel.com>

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/e820.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c4ca89d..e399d0e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -20,6 +20,7 @@
 #include <linux/pfn.h>
 #include <linux/suspend.h>
 #include <linux/firmware-map.h>
+#include <linux/sfi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -1437,6 +1438,10 @@ char *__init default_machine_specific_memory_setup(void)
 	  < 0) {
 		u64 mem_size;
 
+		/* if SFI mmap table exists, use SFI to setup e820 mmap */
+		if (!sfi_init_memory_map())
+			return "SFI";
+
 		/* compare results from other methods and take the greater */
 		if (boot_params.alt_mem_k
 		    < boot_params.screen_info.ext_mem_k) {
-- 
1.6.0.6

