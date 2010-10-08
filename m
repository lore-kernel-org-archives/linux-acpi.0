From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 6/6] ACPI: remove unused declaration of proc_fs.h
Date: Fri, 08 Oct 2010 13:55:17 +0800
Message-ID: <1286517317.2111.3801.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58434 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0JHF53 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 01:57:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Remove unused declaration of proc_fs.h.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/pci_irq.c  |    1 -
 drivers/acpi/pci_link.c |    1 -
 drivers/acpi/pci_root.c |    1 -
 3 files changed, 3 deletions(-)

Index: linux-2.6/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_irq.c
+++ linux-2.6/drivers/acpi/pci_irq.c
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
Index: linux-2.6/drivers/acpi/pci_link.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_link.c
+++ linux-2.6/drivers/acpi/pci_link.c
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>


