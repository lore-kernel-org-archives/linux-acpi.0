From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/18] ACPICA: Update for _PRP predefined name.
Date: Wed, 26 Feb 2014 10:33:08 +0800
Message-ID: <94bd6f0df6337744d5981080c3b2ca617f72fe77.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65108 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaBZCdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:33:15 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Allow objects of type "reference" in the second subpackage element.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index c99bc04..08c359f 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -704,7 +704,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each: 1 Str, 1 Int/Str/Pkg */
 	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_STRING, 1,
 		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
-		     ACPI_RTYPE_PACKAGE, 1, 0),
+		     ACPI_RTYPE_PACKAGE | ACPI_RTYPE_REFERENCE, 1, 0),
 
 	{{"_PRS", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
-- 
1.7.10

