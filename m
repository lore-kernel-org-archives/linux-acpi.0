From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 1/2] Export acpi_processor_set_pdc to modules.
Date: Tue,  1 May 2012 13:24:53 -0400
Message-ID: <1335893094-6904-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

The Xen ACPI module calls acpi_processor_set_pdc for ACPI IDs
for CPUs that are not visible to an instance of a running Linux
kernel. Meaning it calls them on the ones that the generic
code has no control over. But without this being exported
the module will fail to compile.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/acpi/processor_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c850de4..7c7c2d9 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -352,6 +352,7 @@ void __cpuinit acpi_processor_set_pdc(acpi_handle handle)
 	kfree(obj_list->pointer);
 	kfree(obj_list);
 }
+EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 
 static acpi_status __init
 early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
-- 
1.7.7.5
