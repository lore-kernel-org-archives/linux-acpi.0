From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: [RFC PATCH 1/3] acpi: Introduce prepare_remove operation in acpi_device_ops
Date: Thu,  8 Nov 2012 19:29:29 +0100
Message-ID: <1352399371-8015-2-git-send-email-vasilis.liaskovitis@profitbricks.com>
References: <1352399371-8015-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1352399371-8015-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Sender: owner-linux-mm@kvack.org
To: linux-acpi@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com
Cc: rjw@sisk.pl, wency@cn.fujitsu.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
List-Id: linux-acpi@vger.kernel.org


Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
---
 include/acpi/acpi_bus.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2242c10..6ef1692 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -94,6 +94,7 @@ typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
+typedef int (*acpi_op_prepare_remove) (struct acpi_device *device);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -107,6 +108,7 @@ struct acpi_device_ops {
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_notify notify;
+	acpi_op_prepare_remove prepare_remove;
 };
 
 #define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
-- 
1.7.9

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
