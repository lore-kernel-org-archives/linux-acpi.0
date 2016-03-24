From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/30] Utilities: Fix missing parentheses in ACPI_GET_BITS()/ACPI_SET_BITS()
Date: Thu, 24 Mar 2016 09:41:02 +0800
Message-ID: <0c84f0e10990bbb895cfdd86476cb26ab7cc15c3.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some compilers require parentheses to be enforced in the macro definition,
so that the macro caller side can be simpler.

This patch fixes this kind of macro issue in
ACPI_SET_BITS()/ACPI_GET_BITS(). Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1268
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index b461f55..73f6653 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -287,10 +287,10 @@
 /* Generic bitfield macros and masks */
 
 #define ACPI_GET_BITS(source_ptr, position, mask) \
-	((*source_ptr >> position) & mask)
+	((*(source_ptr) >> (position)) & (mask))
 
 #define ACPI_SET_BITS(target_ptr, position, mask, value) \
-	(*target_ptr |= ((value & mask) << position))
+	(*(target_ptr) |= (((value) & (mask)) << (position)))
 
 #define ACPI_1BIT_MASK      0x00000001
 #define ACPI_2BIT_MASK      0x00000003
-- 
1.7.10
