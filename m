From: Len Brown <lenb@kernel.org>
Subject: [PATCH 039/122] PNP: remove old CONFIG_PNP_DEBUG option
Date: Thu, 23 Oct 2008 02:38:13 -0400
Message-ID: <ac88a8f3f7df04774b386ddaf586040adb819b58.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbYJWGkC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:02 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KT7IIKRP32@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:57 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

CONFIG_PNP_DEBUG is no longer used to turn on dev_dbg() in PNP,
since we have pnp_dbg() which can be enabled at boot-time, so
this patch removes the config option.

Note that pnp_dock_event() checks "#ifdef DEBUG".  But there's
never been a clear path for enabling that via configgery.  It
happened that CONFIG_PNP_DEBUG enabled it after 1bd17e63a068db6,
but that was accidental and only in 2.6.26.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/Kconfig          |    6 ------
 drivers/pnp/Makefile         |    4 ----
 drivers/pnp/isapnp/Makefile  |    4 ----
 drivers/pnp/pnpacpi/Makefile |    4 ----
 drivers/pnp/pnpbios/Makefile |    4 ----
 5 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
index 8a3237f..2a37b3f 100644
--- a/drivers/pnp/Kconfig
+++ b/drivers/pnp/Kconfig
@@ -36,12 +36,6 @@ config PNP_DEBUG_MESSAGES
 
 if PNP
 
-config PNP_DEBUG
-	bool "PnP Debug Messages"
-	help
-	  Say Y if you want the Plug and Play Layer to print debug messages.
-	  This is useful if you are developing a PnP driver or troubleshooting.
-
 comment "Protocols"
 
 source "drivers/pnp/isapnp/Kconfig"
diff --git a/drivers/pnp/Makefile b/drivers/pnp/Makefile
index 26f5abc..a381a92 100644
--- a/drivers/pnp/Makefile
+++ b/drivers/pnp/Makefile
@@ -7,7 +7,3 @@ obj-y		:= core.o card.o driver.o resource.o manager.o support.o interface.o quir
 obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
-
-ifeq ($(CONFIG_PNP_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
diff --git a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
index 3e38f06..cac18bb 100644
--- a/drivers/pnp/isapnp/Makefile
+++ b/drivers/pnp/isapnp/Makefile
@@ -5,7 +5,3 @@
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
 obj-y := core.o compat.o $(isapnp-proc-y)
-
-ifeq ($(CONFIG_PNP_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
diff --git a/drivers/pnp/pnpacpi/Makefile b/drivers/pnp/pnpacpi/Makefile
index 2d7a1e6..905326f 100644
--- a/drivers/pnp/pnpacpi/Makefile
+++ b/drivers/pnp/pnpacpi/Makefile
@@ -3,7 +3,3 @@
 #
 
 obj-y := core.o rsparser.o
-
-ifeq ($(CONFIG_PNP_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
diff --git a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
index 310e2b3..3cd3ed7 100644
--- a/drivers/pnp/pnpbios/Makefile
+++ b/drivers/pnp/pnpbios/Makefile
@@ -5,7 +5,3 @@
 pnpbios-proc-$(CONFIG_PNPBIOS_PROC_FS) = proc.o
 
 obj-y := core.o bioscalls.o rsparser.o $(pnpbios-proc-y)
-
-ifeq ($(CONFIG_PNP_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
-- 
1.5.5.1

