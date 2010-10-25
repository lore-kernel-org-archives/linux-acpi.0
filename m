From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/60] ACPI: remove unused declaration of proc_fs.h
Date: Mon, 25 Oct 2010 02:20:36 -0400
Message-ID: <03e7c3432d40d067476eaf49ede29128b637998f.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:07 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:07 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Remove unused declaration of proc_fs.h.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_irq.c  |    1 -
 drivers/acpi/pci_link.c |    1 -
 drivers/acpi/pci_root.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index e4804fb..f907cfb 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 8d47a58..9ff80a7 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 3ba8d1f..96668ad 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-- 
1.7.3.2.90.gd4c43

