From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/84] fujitsu-laptop: depends on INPUT
Date: Sat, 28 Jun 2008 01:43:34 -0400
Message-ID: <770c091f85a922d92505e2da8b30cf30dd6bc2f3.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61906 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbYF1FpI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:08 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500F6VRZ4LM9B@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:05 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

fujitsu-laptop uses input_* functions, so it should depend on INPUT.

drivers/built-in.o: In function `acpi_fujitsu_add':
fujitsu-laptop.c:(.text+0xaaec7): undefined reference to `input_allocate_device'
fujitsu-laptop.c:(.text+0xaaf39): undefined reference to `input_register_device'
fujitsu-laptop.c:(.text+0xab025): undefined reference to `input_free_device'
drivers/built-in.o: In function `acpi_fujitsu_notify':
fujitsu-laptop.c:(.text+0xab0d8): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab0e5): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab0f5): undefined reference to `input_event'
fujitsu-laptop.c:(.text+0xab102): undefined reference to `input_event'
drivers/built-in.o: In function `acpi_fujitsu_hotkey_notify':
fujitsu-laptop.c:(.text+0xab261): undefined reference to `input_event'
drivers/built-in.o:fujitsu-laptop.c:(.text+0xab26e): more undefined references to `input_event' follow
drivers/built-in.o: In function `acpi_fujitsu_hotkey_add':
fujitsu-laptop.c:(.text+0xab49c): undefined reference to `input_allocate_device'
fujitsu-laptop.c:(.text+0xab51a): undefined reference to `input_register_device'
fujitsu-laptop.c:(.text+0xab5e4): undefined reference to `input_free_device'
make[1]: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b4759ab..13a60bf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -179,6 +179,7 @@ config FUJITSU_LAPTOP
         tristate "Fujitsu Laptop Extras"
         depends on X86
         depends on ACPI
+        depends on INPUT
         depends on BACKLIGHT_CLASS_DEVICE
         ---help---
 	  This is a driver for laptops built by Fujitsu:
-- 
1.5.6.1.89.gd544

