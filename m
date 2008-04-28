From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 01/55] PNP: turn on -DDEBUG when CONFIG_PNP_DEBUG is set
Date: Mon, 28 Apr 2008 16:33:48 -0600
Message-ID: <20080428223616.616114896@ldl.fc.hp.com>
References: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:9194 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934495AbYD1WgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:19 -0400
Content-Disposition: inline; filename=pnp-turn-on-debug-in-makefiles
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Turn on -DDEBUG in CFLAGS when CONFIG_PNP_DEBUG=y.  This makes
dev_dbg() do what you expect.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>

Index: work10/drivers/pnp/isapnp/Makefile
===================================================================
--- work10.orig/drivers/pnp/isapnp/Makefile	2008-04-28 16:00:27.000000000 -0600
+++ work10/drivers/pnp/isapnp/Makefile	2008-04-28 16:09:03.000000000 -0600
@@ -5,3 +5,7 @@
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
 obj-y := core.o compat.o $(isapnp-proc-y)
+
+ifeq ($(CONFIG_PNP_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
Index: work10/drivers/pnp/pnpacpi/Makefile
===================================================================
--- work10.orig/drivers/pnp/pnpacpi/Makefile	2008-04-28 16:00:27.000000000 -0600
+++ work10/drivers/pnp/pnpacpi/Makefile	2008-04-28 16:09:03.000000000 -0600
@@ -3,3 +3,7 @@
 #
 
 obj-y := core.o rsparser.o
+
+ifeq ($(CONFIG_PNP_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
Index: work10/drivers/pnp/pnpbios/Makefile
===================================================================
--- work10.orig/drivers/pnp/pnpbios/Makefile	2008-04-28 16:00:27.000000000 -0600
+++ work10/drivers/pnp/pnpbios/Makefile	2008-04-28 16:09:03.000000000 -0600
@@ -5,3 +5,7 @@
 pnpbios-proc-$(CONFIG_PNPBIOS_PROC_FS) = proc.o
 
 obj-y := core.o bioscalls.o rsparser.o $(pnpbios-proc-y)
+
+ifeq ($(CONFIG_PNP_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif

-- 
