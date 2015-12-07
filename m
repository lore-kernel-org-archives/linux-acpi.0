From: fu.wei@linaro.org
Subject: [PATCH] acpi, apei, hest: Move HEST table initialization where it belongs.
Date: Mon,  7 Dec 2015 16:43:17 +0800
Message-ID: <1449477797-12086-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbbLGInr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Dec 2015 03:43:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, tomasz.nowicki@linaro.org, tn@semihalf.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, jcm@redhat.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, Fu Wei <fu.wei@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Since HEST (hardware error sources table) can describe more than PCI
specific errors, it needs to be moved out of acpi_pci_root_init.

Changelog:
v1: This patch - the first upstream patch to linux mailing lists.
    Fu Wei:
    (1)Rebase to v4.4-rc4;
    (2)Remove "#include <acpi/apei.h>" from drivers/acpi/pci_root.c]

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/acpi/pci_root.c | 2 --
 drivers/acpi/scan.c     | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ae3fe4e..a35dd23 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -33,7 +33,6 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
-#include <acpi/apei.h>	/* for acpi_hest_init() */
 
 #include "internal.h"
 
@@ -865,7 +864,6 @@ out_release_info:
 
 void __init acpi_pci_root_init(void)
 {
-	acpi_hest_init();
 	if (acpi_pci_disabled)
 		return;
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78d5f02..a52e776 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -13,6 +13,8 @@
 #include <linux/nls.h>
 #include <linux/dma-mapping.h>
 
+#include <acpi/apei.h> /* for acpi_hest_init() */
+
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -1912,6 +1914,7 @@ int __init acpi_scan_init(void)
 {
 	int result;
 
+	acpi_hest_init();
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();
-- 
2.5.0

