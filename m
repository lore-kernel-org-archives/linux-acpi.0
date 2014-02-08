From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/10] ACPICA: Add support for extra, optional OS-specific header file.
Date: Sat,  8 Feb 2014 09:42:53 +0800
Message-ID: <cf0adddf74e5b5d0707ee02604754176f92cf5a4.1390438467.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55858 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaBHBm6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:58 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

If OSPMs have something should appear after actypes.h to reference type
definitions, the platform/acxxx.h is not sufficient as it is included by
platform/acenv.h before including actypes.h.

This patch introduce an OSPMs declarable headers to allow OSPMs to handle
such requirement for their own purposes.
This kind of header can also be used by Linux to collect the divergences
that haven't been back ported yet.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpi.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index a544d3e..ca0cb60 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -62,5 +62,8 @@
 #include <acpi/acrestyp.h>		/* Resource Descriptor structs */
 #include <acpi/acpiosxf.h>		/* OSL interfaces (ACPICA-to-OS) */
 #include <acpi/acpixf.h>		/* ACPI core subsystem external interfaces */
+#ifdef ACPI_NATIVE_INTERFACE_HEADER
+#include ACPI_NATIVE_INTERFACE_HEADER
+#endif
 
 #endif				/* __ACPI_H__ */
-- 
1.7.10

