From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/21] ACPICA: Add parens within macros around parameter names
Date: Fri,  8 Mar 2013 17:22:03 +0800
Message-ID: <ccf76ad5560feb0fbee40dc63b5434ee9f90c5af.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19384 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933467Ab3CHJW1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:27 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 8b7ca40..53666bd 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -325,9 +325,9 @@
  * The "DescriptorType" field is the second field in both structures.
  */
 #define ACPI_GET_DESCRIPTOR_PTR(d)      (((union acpi_descriptor *)(void *)(d))->common.common_pointer)
-#define ACPI_SET_DESCRIPTOR_PTR(d, o)   (((union acpi_descriptor *)(void *)(d))->common.common_pointer = o)
+#define ACPI_SET_DESCRIPTOR_PTR(d, p)   (((union acpi_descriptor *)(void *)(d))->common.common_pointer = (p))
 #define ACPI_GET_DESCRIPTOR_TYPE(d)     (((union acpi_descriptor *)(void *)(d))->common.descriptor_type)
-#define ACPI_SET_DESCRIPTOR_TYPE(d, t)  (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = t)
+#define ACPI_SET_DESCRIPTOR_TYPE(d, t)  (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = (t))
 
 /*
  * Macros for the master AML opcode table
-- 
1.7.10

