From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch 04/19] ACPI: Let the parser return false for disabled resources
Date: Thu,  8 Jan 2015 10:32:51 +0800
Message-ID: <1420684386-5975-5-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If the parser disables a resource during parsing, let it return false,
so the calling code does not need to implement further checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c0578c05e2c2..deb70a839f80 100644
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
 
@@ -267,10 +267,10 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
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
