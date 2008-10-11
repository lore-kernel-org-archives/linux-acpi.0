From: Len Brown <lenb@kernel.org>
Subject: [PATCH 66/85] PNP: add CONFIG_PNP_DEBUG_MESSAGES and pnp_dbg()
Date: Sat, 11 Oct 2008 02:36:26 -0400
Message-ID: <97ef062bbe08f46903f29ecdf432be302c977f3b.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:58897 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbYJKGhR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:17 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This adds the core function pnp_dbg() and a new config option to
enable it.

The PNP core debugging messages can be enabled at boot-time with the
"pnp.debug" kernel parameter.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/pnp/Kconfig                 |   14 ++++++++++++++
 drivers/pnp/base.h                  |   10 ++++++++++
 drivers/pnp/core.c                  |   11 +++++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1150444..7164d4e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1660,6 +1660,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
+	pnp.debug	[PNP]
+			Enable PNP debug messages.  This depends on the
+			CONFIG_PNP_DEBUG_MESSAGES option.
+
 	pnpacpi=	[ACPI]
 			{ off }
 
diff --git a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
index 821933f..8a3237f 100644
--- a/drivers/pnp/Kconfig
+++ b/drivers/pnp/Kconfig
@@ -20,6 +20,20 @@ menuconfig PNP
 
 	  If unsure, say Y.
 
+config PNP_DEBUG_MESSAGES
+	default y
+	bool "PNP debugging messages"
+	depends on PNP
+	help
+	  Say Y here if you want the PNP layer to be able to produce debugging
+	  messages if needed.  The messages can be enabled at boot-time with
+	  the pnp.debug kernel parameter.
+
+	  This option allows you to save a bit of space if you do not want
+	  the messages to even be built into the kernel.
+
+	  If you have any doubts about this, say Y here.
+
 if PNP
 
 config PNP_DEBUG
diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 9fd7bb9..5e4e82c 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -166,3 +166,13 @@ struct pnp_resource *pnp_add_io_resource(struct pnp_dev *dev,
 struct pnp_resource *pnp_add_mem_resource(struct pnp_dev *dev,
 					  resource_size_t start,
 					  resource_size_t end, int flags);
+
+extern int pnp_debug;
+
+#if defined(CONFIG_PNP_DEBUG_MESSAGES)
+#define pnp_dbg(dev, format, arg...)					\
+	({ if (pnp_debug) dev_printk(KERN_DEBUG, dev, format, ## arg); 0; })
+#else
+#define pnp_dbg(dev, format, arg...)					\
+	({ if (0) dev_printk(KERN_DEBUG, dev, format, ## arg); 0; })
+#endif
diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 7cb1ffc..61291b5 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -221,3 +221,14 @@ static int __init pnp_init(void)
 }
 
 subsys_initcall(pnp_init);
+
+int pnp_debug;
+
+#if defined(CONFIG_PNP_DEBUG_MESSAGES)
+static int __init pnp_debug_setup(char *__unused)
+{
+	pnp_debug = 1;
+	return 1;
+}
+__setup("pnp.debug", pnp_debug_setup);
+#endif
-- 
1.5.5.1

