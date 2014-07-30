From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/17] ACPICA: ACPI 5.1: Support for the _CCA predifined name.
Date: Wed, 30 Jul 2014 12:21:38 +0800
Message-ID: <69ac247287a8783d828249f44c24470077de236e.1406689494.git.lv.zheng@intel.com>
References: <cover.1406689493.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406689493.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Full support for _CCA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index c5bfadf..bd3908d 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -370,6 +370,9 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_CBA", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See PCI firmware spec 3.0 */
 
+	{{"_CCA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 5.1 */
+
 	{{"_CDM", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
-- 
1.7.10
