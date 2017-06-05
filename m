From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/53] ACPICA: Add support for _HMA as a predefined method
Date: Mon,  5 Jun 2017 16:38:15 +0800
Message-ID: <064bf306abdd9c6540c067916f825dd84ac009b9.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbdFEIiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:18 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 223a647c72243359231865a64c1be04d208dcdbd

Link: https://github.com/acpica/acpica/commit/223a647c
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index c777f02..cdfcad8 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -581,6 +581,9 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_HID", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING)}},
 
+	{{"_HMA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
 	{{"_HOT", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
-- 
2.7.4

