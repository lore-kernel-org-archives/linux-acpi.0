From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] ACPI / PCI: make pci_slot explicitly non-modular
Date: Mon, 11 Jul 2016 18:17:23 -0400
Message-ID: <20160711221723.5072-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:56714 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcGKWRt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2016 18:17:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The Kconfig for this file is:

drivers/acpi/Kconfig:config ACPI_PCI_SLOT
drivers/acpi/Kconfig:   bool "PCI slot detection driver"

...and so it is not built as a module.  Hence including module.h
and everything that comes with it just for the no-op MODULE_LICENSE
and friends is rather heavy handed.

The license/author info is found at the top of the file, so we
just remove the MODULE_LICENSE etc and the include of module.h

We delete the DRIVER_VERSION macro as well since it is unused.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/pci_slot.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 1236fb04a708..f62c68e24317 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -25,7 +25,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -37,13 +36,6 @@
 
 static int check_sta_before_sun;
 
-#define DRIVER_VERSION 	"0.1"
-#define DRIVER_AUTHOR	"Alex Chiang <achiang@hp.com>"
-#define DRIVER_DESC	"ACPI PCI Slot Detection Driver"
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_slot");
 
-- 
2.8.4

