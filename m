From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/16] ACPICA: Fix possible memory leak in GPE init error path
Date: Sat,  8 Jun 2013 09:00:07 +0800
Message-ID: <e66609edf3d7173197872a170fe8be2abe8fde69.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60857 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FHBAc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:00:32 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Some GPE blocks were not deleted.  ACPICA BZ 1018. Tomasz Nowicki
<tomasz.nowicki@linaro.org>

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1018
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evgpeblk.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index a2d688b..c1aa1ed 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -382,6 +382,8 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	status = acpi_ev_install_gpe_block(gpe_block, interrupt_number);
 	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(gpe_block->register_info);
+		ACPI_FREE(gpe_block->event_info);
 		ACPI_FREE(gpe_block);
 		return_ACPI_STATUS(status);
 	}
-- 
1.7.10

