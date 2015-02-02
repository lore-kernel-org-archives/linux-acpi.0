From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 02/23] ACPI: Remove redundant check in function acpi_dev_resource_address_space()
Date: Mon,  2 Feb 2015 10:42:47 +0800
Message-ID: <1422844988-13854-3-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31968 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbbBBCkg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Feb 2015 21:40:36 -0500
In-Reply-To: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>

From: Thomas Gleixner <tglx@linutronix.de>

The ACPI type is checked in acpi_resource_to_address64() anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d0a4d90c6bcc..1c616a56e007 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -189,15 +189,6 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 	u64 len;
 	u8 io_decode;
 
-	switch (ares->type) {
-	case ACPI_RESOURCE_TYPE_ADDRESS16:
-	case ACPI_RESOURCE_TYPE_ADDRESS32:
-	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		break;
-	default:
-		return false;
-	}
-
 	status = acpi_resource_to_address64(ares, &addr);
 	if (ACPI_FAILURE(status))
 		return false;
-- 
1.7.10.4

