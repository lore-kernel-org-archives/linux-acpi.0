From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/19] ACPICA: ACPI 6.0: Add ACPI_SUB_PTR().
Date: Thu, 21 May 2015 10:31:24 +0800
Message-ID: <ea6ffb5212c81332036e0a88c9738ee980c73414.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49923 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300AbbEUCbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 May 2015 22:31:42 -0400
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 5de82757aef5d6163e37064033aacbce193abbca

Using a minus number with ACPI_ADD_PTR() will cause compiler warnings, such
warnings cannot be eliminated by force casting an unsigned value to a
signed value. This patch thus introduces ACPI_SUB_PTR() to be used with
minus numbers. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/5de82757
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actypes.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a9d33e8..63fd7f5 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -525,6 +525,7 @@ typedef u64 acpi_integer;
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
 #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
 #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
+#define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
 #define ACPI_PTR_DIFF(a, b)             (acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b)))
 
 /* Pointer/Integer type conversions */
-- 
1.7.10

