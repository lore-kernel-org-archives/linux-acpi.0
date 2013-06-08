From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/16] ACPICA: Clear events initialized flag upon event component termination
Date: Sat,  8 Jun 2013 09:00:23 +0800
Message-ID: <17a5d121655fce6e2438b10adaf8271dd05b454c.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13225 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FHBAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:00:43 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Clear this flag to allow clean startup and even double termination.
ACPICA BZ 1013. Tomasz Nowicki <tomasz.nowicki@linaro.org>

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1013
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evmisc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index db59fe3..1b111ef 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -276,6 +276,8 @@ void acpi_ev_terminate(void)
 			ACPI_ERROR((AE_INFO,
 				    "Could not remove Global Lock handler"));
 		}
+
+		acpi_gbl_events_initialized = FALSE;
 	}
 
 	/* Deallocate all handler objects installed within GPE info structs */
-- 
1.7.10

