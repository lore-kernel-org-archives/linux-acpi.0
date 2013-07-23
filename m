From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/13] ACPI/IPMI: Cleanup some Kconfig codes
Date: Tue, 23 Jul 2013 16:10:30 +0800
Message-ID: <7f0aa3cc70233fdb523fbb75dadadc03358e836f.1374566394.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1374566394.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1374566394.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

This is a trivial patch:
1. Deletes duplicate Kconfig dependency as there is "if IPMI_HANDLER"
   around "IPMI_SI".

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3278a21..d129869 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -181,9 +181,10 @@ config ACPI_PROCESSOR
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
+
 config ACPI_IPMI
 	tristate "IPMI"
-	depends on IPMI_SI && IPMI_HANDLER
+	depends on IPMI_SI
 	default n
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
-- 
1.7.10
