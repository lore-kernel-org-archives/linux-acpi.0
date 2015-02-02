From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 12/23] ACPI: Enforce stricter checks for address space descriptors
Date: Mon,  2 Feb 2015 10:42:57 +0800
Message-ID: <1422844988-13854-13-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26055 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbbBBClL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Feb 2015 21:41:11 -0500
In-Reply-To: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

Enforce stricter checks for address space descriptors according to
ACPI spec.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5bf73a9f26d9..57891a621b96 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -192,6 +192,15 @@ static bool acpi_decode_space(struct resource *res,
 	bool wp = addr->info.mem.write_protect;
 	u64 len = attr->address_length;
 
+	/*
+	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
+	 * 6.4.3.5 Address Space Resource Descriptors.
+	 */
+	if ((addr->min_address_fixed != addr->max_address_fixed && len) ||
+	    (addr->min_address_fixed && addr->max_address_fixed && !len))
+		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
+			 addr->min_address_fixed, addr->max_address_fixed, len);
+
 	res->start = attr->minimum;
 	res->end = attr->maximum;
 
-- 
1.7.10.4

