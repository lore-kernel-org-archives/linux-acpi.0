From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 4/6] ACPICA: Add a missing pair of parentheses
Date: Wed, 24 Jan 2018 15:42:32 -0800
Message-ID: <20180124234234.19828-5-erik.schmauss@intel.com>
References: <20180124234234.19828-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbeAXXnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jan 2018 18:43:21 -0500
In-Reply-To: <20180124234234.19828-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jung-uk Kim <jkim@FreeBSD.org>, Jung-uk Kim <jkim@free_BSD.org>, Erik Schmauss <erik.schmauss@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 0b6b55f1e597..4fed3310235a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -532,7 +532,7 @@ typedef u64 acpi_integer;
 #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
 #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
 #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
-#define ACPI_PTR_DIFF(a, b)             (acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b)))
+#define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
 
 /* Pointer/Integer type conversions */
 
-- 
2.14.3

