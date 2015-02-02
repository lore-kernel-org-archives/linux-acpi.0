From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 05/23] ACPI: Let the parser return false for disabled resources
Date: Mon,  2 Feb 2015 10:42:50 +0800
Message-ID: <1422844988-13854-6-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31968 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbbBBCkq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Feb 2015 21:40:46 -0500
In-Reply-To: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>

From: Thomas Gleixner <tglx@linutronix.de>

If the parser disables a resource during parsing, let it return false,
so the calling code does not need to implement further checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 16d291c60277..cdb1a3c4a0b9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -219,10 +219,10 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 		res->flags = IORESOURCE_BUS;
 		break;
 	default:
-		res->flags = 0;
+		return false;
 	}
 
-	return true;
+	return !(res->flags & IORESOURCE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space);
 
@@ -268,10 +268,10 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 		res->flags = IORESOURCE_BUS;
 		break;
 	default:
-		res->flags = 0;
+		return false;
 	}
 
-	return true;
+	return !(res->flags & IORESOURCE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
 
-- 
1.7.10.4

