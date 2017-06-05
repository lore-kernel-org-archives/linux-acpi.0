From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/53] ACPICA: Add support for _LSR as a predefined method
Date: Mon,  5 Jun 2017 16:38:04 +0800
Message-ID: <33aebdded7a2cc0b657d0f63ea78c6b67be1e8f9.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:43514 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdFEIiI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:08 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 89020347ada3f0ff5499a804178d574359e4730f

Link: https://github.com/acpica/acpica/commit/89020347
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index d55ff5d..1b7ad31 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -630,6 +630,11 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},
 	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0, 0, 0),
 
+	{{"_LSR", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 1,
+		     ACPI_RTYPE_BUFFER, 1, 0),
+
 	{{"_MAT", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
-- 
2.7.4

