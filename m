From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch 12/19] ACPI: Enforce stricter checks for address space descriptors
Date: Thu,  8 Jan 2015 10:32:59 +0800
Message-ID: <1420684386-5975-13-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Enforce stricter checks for address space descriptors according to
ACPI spec.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 26b47f1da523..e82149e44347 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -192,6 +192,14 @@ static bool acpi_decode_space(struct resource *res,
 	bool wp = base->info.mem.write_protect;
 	u64 len = addr->address_length;
 
+	/*
+	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
+	 * 6.4.3.5 Address Space Resource Descriptors.
+	 */
+	if ((base->min_address_fixed != base->max_address_fixed && len) ||
+	    (base->min_address_fixed && base->max_address_fixed && !len))
+		return false;
+
 	res->start = addr->minimum;
 	res->end = addr->maximum;
 
-- 
1.7.10.4
