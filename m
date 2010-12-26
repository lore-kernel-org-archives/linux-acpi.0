From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/33] PNP: Compile all pnp built-in stuff in one module
 namespace
Date: Sun, 26 Dec 2010 17:43:22 -0500
Message-ID: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:61058 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0LZWoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:44:16 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200ETP4HDC0J8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:44:07 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

This is cleanup mostly, nothing urgent.
I came up with it when looking at dynamic debug which can
enable pr_debug messages at runtime or boot param
for a specific module.

Advantages:
  - Any pnp code can make use of the moduleparam.h interface, the modules
    will show up as pnp.param.
  - Passing pnp.ddebug as kernel boot param will enable all pnp debug messages
    with my previous patch and CONFIG_DYNAMIC_DEBUG enabled.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/Makefile         |    6 ++++--
 drivers/pnp/isapnp/Makefile  |    6 +++---
 drivers/pnp/pnpacpi/Makefile |    3 ++-
 drivers/pnp/pnpbios/Makefile |    5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pnp/Makefile b/drivers/pnp/Makefile
index 8de3775..bfba893 100644
--- a/drivers/pnp/Makefile
+++ b/drivers/pnp/Makefile
@@ -2,11 +2,13 @@
 # Makefile for the Linux Plug-and-Play Support.
 #
 
-obj-y		:= core.o card.o driver.o resource.o manager.o support.o interface.o quirks.o
+obj-y		:= pnp.o
+
+pnp-y		:= core.o card.o driver.o resource.o manager.o support.o interface.o quirks.o
 
 obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
 
 # pnp_system_init goes after pnpacpi/pnpbios init
-obj-y				+= system.o
+pnp-y				+= system.o
diff --git a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
index cac18bb..6e607aa 100644
--- a/drivers/pnp/isapnp/Makefile
+++ b/drivers/pnp/isapnp/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the kernel ISAPNP driver.
 #
+obj-y			+= pnp.o
+pnp-y			:= core.o compat.o
 
-isapnp-proc-$(CONFIG_PROC_FS) = proc.o
-
-obj-y := core.o compat.o $(isapnp-proc-y)
+pnp-$(CONFIG_PROC_FS)	+= proc.o
diff --git a/drivers/pnp/pnpacpi/Makefile b/drivers/pnp/pnpacpi/Makefile
index 905326f..40c93da 100644
--- a/drivers/pnp/pnpacpi/Makefile
+++ b/drivers/pnp/pnpacpi/Makefile
@@ -1,5 +1,6 @@
 #
 # Makefile for the kernel PNPACPI driver.
 #
+obj-y += pnp.o
 
-obj-y := core.o rsparser.o
+pnp-y := core.o rsparser.o
diff --git a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
index 3cd3ed7..240b0ff 100644
--- a/drivers/pnp/pnpbios/Makefile
+++ b/drivers/pnp/pnpbios/Makefile
@@ -1,7 +1,8 @@
 #
 # Makefile for the kernel PNPBIOS driver.
 #
+obj-y := pnp.o
 
-pnpbios-proc-$(CONFIG_PNPBIOS_PROC_FS) = proc.o
+pnp-y := core.o bioscalls.o rsparser.o
 
-obj-y := core.o bioscalls.o rsparser.o $(pnpbios-proc-y)
+pnp-$(CONFIG_PNPBIOS_PROC_FS) += proc.o
-- 
1.7.3.3.557.gb5c17

