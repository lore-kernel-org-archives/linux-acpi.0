From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 10/15] ACPICA: Small typo fix, no functional change.
Date: Fri, 17 Nov 2017 15:42:25 -0800
Message-ID: <20171117234230.913-11-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39439 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759944AbdKQXqm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:42 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9b03c05305d856274c39f3adbddd8a98ef5d018e

acpi table header.

Link: https://github.com/acpica/acpica/commit/9b03c053
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 867f4136dbac..178661f1b896 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1373,7 +1373,7 @@ struct acpi_pdtt_channel {
 /* Flags for above */
 
 #define ACPI_PDTT_RUNTIME_TRIGGER           (1)
-#define ACPI_PPTT_WAIT_COMPLETION           (1<<1)
+#define ACPI_PDTT_WAIT_COMPLETION           (1<<1)
 
 /*******************************************************************************
  *
-- 
2.13.6

