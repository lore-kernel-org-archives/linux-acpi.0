From: tianyu.lan@intel.com
Subject: [Resend PATCH 1/5] ACPI/Resource: Add memory prefetch check support
Date: Fri, 11 Oct 2013 20:18:57 +0800
Message-ID: <1381493941-4650-2-git-send-email-tianyu.lan@intel.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, bhelgaas@google.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

This patch is to check mem address space's acpi resource caching ability
and set prefetch flag of struct resource if it's prefetchable.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b7201fc..929f416 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -202,6 +202,9 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 		res->flags = acpi_dev_memresource_flags(len,
 						addr.info.mem.write_protect,
 						window);
+
+		if (addr.info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
+			res->flags |= IORESOURCE_PREFETCH;
 		break;
 	case ACPI_IO_RANGE:
 		io_decode = addr.granularity == 0xfff ?
-- 
1.8.2.1
