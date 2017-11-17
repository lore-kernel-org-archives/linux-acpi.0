From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 05/15] ACPICA: ACPICA: style edits to utility function output, no functional change
Date: Fri, 17 Nov 2017 15:42:20 -0800
Message-ID: <20171117234230.913-6-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759944AbdKQXqh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:37 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit 8070a23749f1c2eedec313f42f564b5375054137

Link: https://github.com/acpica/acpica/commit/8070a237
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/uttrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 3c8de88ecbd5..28a302eb2015 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -717,7 +717,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 	if (!num_outstanding) {
 		ACPI_INFO(("No outstanding allocations"));
 	} else {
-		ACPI_ERROR((AE_INFO, "%u(0x%X) Outstanding allocations",
+		ACPI_ERROR((AE_INFO, "%u (0x%X) Outstanding cache allocations",
 			    num_outstanding, num_outstanding));
 	}
 
-- 
2.13.6

