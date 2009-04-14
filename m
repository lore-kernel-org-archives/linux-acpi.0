From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH 1/2]: ACPI: Check whether the acpi video is deferrable only
	when KMS is enabled
Date: Tue, 14 Apr 2009 11:05:45 +0800
Message-ID: <1239678345.5564.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38979 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbZDNDEY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 23:04:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

weaken the dependency between the I915 driver and ACPI video driver.
When the KMS is not enabled in kernel configuration, it will contine
the current flowchart. 

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Matthew Garrett <mjg59@srcf.ucam.org>
---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-04-14 10:26:30.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-04-14 10:28:12.000000000 +0800
@@ -2242,7 +2242,7 @@
 
 static int __init intel_opregion_present(void)
 {
-#if defined(CONFIG_DRM_I915) || defined(CONFIG_DRM_I915_MODULE)
+#if defined(CONFIG_DRM_I915_KMS)
 	struct pci_dev *dev = NULL;
 	u32 address;
 


