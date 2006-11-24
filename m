From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/65] ACPICA: Update function header
Date: Fri, 24 Nov 2006 02:18:11 -0500
Message-ID: <11643527561399-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757602AbWKXHPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:18 -0500
In-Reply-To: <1164352755500-git-send-email-len.brown@intel.com>
Message-Id: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evrgnini.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 203d135..790d49b 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -432,6 +432,9 @@ acpi_ev_default_region_setup(acpi_handle
  *              a PCI address in the scope of the definition.  This address is
  *              required to perform an access to PCI config space.
  *
+ * MUTEX:       Interpreter should be unlocked, because we may run the _REG
+ *              method for this region.
+ *
  ******************************************************************************/
 
 acpi_status
-- 
1.4.4.1
