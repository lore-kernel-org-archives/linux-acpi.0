From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/20] ACPICA: Fix a macro for the hardware-reduced case
Date: Tue, 29 Oct 2013 09:29:16 +0800
Message-ID: <bdebfedf9ee034ae63aa6ad1bd9195dc86112348.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52340 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757109Ab3J2B3d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:33 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This fix repairs a version of a macro that is used for the hardware
reduced case only. It adds a return statement to the macro definition
so that the AcpiSrc translation will not completely delete the second
line of the macro because it thinks that it is an empty block. It actually
clarifies the use of the macro anyway.

Reported-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c7b1475..ebab0d8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -106,7 +106,7 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
 	static ACPI_INLINE prototype {return(AE_OK);}
 
 #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
-	static ACPI_INLINE prototype {}
+	static ACPI_INLINE prototype {return;}
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
-- 
1.7.10

