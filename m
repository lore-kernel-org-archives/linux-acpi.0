From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/10] ACPICA: Events: Cleanup of resetting the GPE handler to NULL before removing.
Date: Thu,  5 Feb 2015 15:20:14 +0800
Message-ID: <03498d3612bdc7d67feb473f89de2beb88f65944.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit b2b18bb38045404e253f10787b8a4ae6e94cdee6

This patch prevents acpi_remove_gpe_handler() from leaking the stale
gpe_event_info->Dispatch.Handler to the caller to avoid possible NULL pointer
references. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/b2b18bb3
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxface.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 55a58f3..b6b0c23 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -896,6 +896,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	/* Remove the handler */
 
 	handler = gpe_event_info->dispatch.handler;
+	gpe_event_info->dispatch.handler = NULL;
 
 	/* Restore Method node (if any), set dispatch flags */
 
-- 
1.7.10
