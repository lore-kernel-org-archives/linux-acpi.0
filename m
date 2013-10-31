From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/15] ACPICA: Remove dead AOPOBJ_INVALID check.
Date: Thu, 31 Oct 2013 09:30:53 +0800
Message-ID: <2ded4de275d723862117abb842a15030b9b2d700.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39786 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727Ab3JaBb3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:29 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 16 lines of divergences.

The following reversion commit restored a piece of dead code related to an
obselete AOPOBJ_INVALID flag.
   Commit: 7cb7f45c7feef43c8f71f5cfedfc0b19be2142f7
   Subject: Revert "ACPICA: Remove obsolete acpi_os_validate_address
            interface"

This patch fixes wrong release commit to reduce the source code differences
between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exfldio.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 8ab01b6..49fb742 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -123,12 +123,6 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		}
 	}
 
-	/* Exit if Address/Length have been disallowed by the host OS */
-
-	if (rgn_desc->common.flags & AOPOBJ_INVALID) {
-		return_ACPI_STATUS(AE_AML_ILLEGAL_ADDRESS);
-	}
-
 	/*
 	 * Exit now for SMBus, GSBus or IPMI address space, it has a non-linear
 	 * address space and the request cannot be directly validated
-- 
1.7.10

