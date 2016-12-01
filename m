From: Majun <majun258@huawei.com>
Subject: [RFC PATCH 3/3]irqchip/gicv3-its: Add a new flag to control indirect route in ACPI mode.
Date: Thu, 1 Dec 2016 15:46:00 +0800
Message-ID: <1480578360-9268-4-git-send-email-majun258@huawei.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:55059 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758717AbcLAHqj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 02:46:39 -0500
In-Reply-To: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com, majun258@huawei.com

From: MaJun <majun258@huawei.com>

Add a new flag to control indirect route function for ACPI mode.
To carry the user defined flags information, we used the reserved byte
in ITS MADT table

Signed-off-by: MaJun <majun258@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
 include/acpi/actbl1.h            | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ee54133..4420283 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1848,6 +1848,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 	struct fwnode_handle *dom_handle;
 	struct resource res;
 	int err;
+	u8 flags = 0;
 
 	its_entry = (struct acpi_madt_generic_translator *)header;
 	memset(&res, 0, sizeof(res));
@@ -1855,6 +1856,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
 	res.flags = IORESOURCE_MEM;
 
+	flags = its_entry->flags;
+
 	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
 	if (!dom_handle) {
 		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
@@ -1869,7 +1872,7 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE, 0);
+	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE, flags);
 	if (!err)
 		return 0;
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 796d6ba..42a08ae 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -930,7 +930,8 @@ struct acpi_madt_generic_translator {
 	u16 reserved;		/* reserved - must be zero */
 	u32 translation_id;
 	u64 base_address;
-	u32 reserved2;
+	u8 flags;
+	u8 reserved2[3];
 };
 
 /*
-- 
1.7.12.4


