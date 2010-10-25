From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] PNP: Compile all pnp built-in stuff in one module namespace
Date: Mon, 25 Oct 2010 21:11:15 +0200
Message-ID: <1288033876-22929-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59739 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab0JYTLr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 15:11:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, bjorn.helgaas@hp.com
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

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
CC: linux-acpi@vger.kernel.org
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
1.6.3

