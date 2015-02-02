From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 09/23] ACPI: Fix a bug in parsing ACPI Memory24 resource
Date: Mon,  2 Feb 2015 10:42:54 +0800
Message-ID: <1422844988-13854-10-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11954 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbbBBClA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Feb 2015 21:41:00 -0500
In-Reply-To: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

According to ACPI spec 5, section 6.4.3.1 "24-Bit Memory Range Descriptor",
minimum, maximum and address_length field in struct acpi_resource_memory24
is in granularity of 256-bytes. So shift 8-bit left to get correct address.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7ce00a63f695..5544c6d26f32 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -90,8 +90,8 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		memory24 = &ares->data.memory24;
-		acpi_dev_get_memresource(res, memory24->minimum,
-					 memory24->address_length,
+		acpi_dev_get_memresource(res, memory24->minimum << 8,
+					 memory24->address_length << 8,
 					 memory24->write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
-- 
1.7.10.4

