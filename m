From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 11/12] ACPI/IPMI: Cleanup some
	Kconfig codes
Date: Fri, 13 Sep 2013 13:14:51 +0800
Message-ID: <69d4c328b10e0deab9c94e62765f2df3122fc733.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com>
	<cover.1379048860.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Lv Zheng <lv.zheng@intel.com>
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


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
