From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/53] ACPICA: Add support for _LSW as a predefined method
Date: Mon,  5 Jun 2017 16:38:09 +0800
Message-ID: <3fd966fc7e0bc00e127f703a25015426a751b0d2.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42146 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdFEIiM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:12 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 8e425bdd9fa27264c217a3a449eb3c2da3769542

Link: https://github.com/acpica/acpica/commit/8e425bdd
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 1b7ad31..c777f02 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -635,6 +635,10 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 1,
 		     ACPI_RTYPE_BUFFER, 1, 0),
 
+	{{"_LSW",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_BUFFER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
 	{{"_MAT", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
-- 
2.7.4

