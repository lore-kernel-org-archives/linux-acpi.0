From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 03/15] ACPICA: Add an additional error message for EC timeouts
Date: Fri, 17 Nov 2017 15:42:18 -0800
Message-ID: <20171117234230.913-4-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759944AbdKQXqg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:36 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 24dd370b14711b7b3f31d7ca6326f9e0bd177c4e

AE_TIME is seen to be returned from the EC driver/handler so
often that an additional error message is added to help
clarify the problem.

Link: https://github.com/acpica/acpica/commit/24dd370b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/evregion.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 28b447ff92df..bb58419f0d61 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -298,6 +298,16 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
 				acpi_ut_get_region_name(region_obj->region.
 							space_id)));
+
+		/*
+		 * Special case for an EC timeout. These are seen so frequently
+		 * that an additional error message is helpful
+		 */
+		if ((region_obj->region.space_id == ACPI_ADR_SPACE_EC) &&
+		    (status == AE_TIME)) {
+			ACPI_ERROR((AE_INFO,
+				    "Timeout from EC hardware or EC device driver"));
+		}
 	}
 
 	if (!(handler_desc->address_space.handler_flags &
-- 
2.13.6

