From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI: remove unused static functions
Date: Tue, 07 Dec 2010 14:50:57 +0000
Message-ID: <4CFE57E102000078000266E6@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

..., fixing respective compiler warnings when !CPU_FREQ.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/processor_thermal.c |   10 ----------
 1 file changed, 10 deletions(-)

--- linux-2.6.37-rc5/drivers/acpi/processor_thermal.c
+++ 2.6.37-rc5-acpi-cpufreq-warning/drivers/acpi/processor_thermal.c
@@ -155,16 +155,6 @@ static int cpufreq_set_cur_state(unsigne
 {
 	return 0;
 }
-
-static int acpi_thermal_cpufreq_increase(unsigned int cpu)
-{
-	return -ENODEV;
-}
-static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
-{
-	return -ENODEV;
-}
-
 #endif
 
 int acpi_processor_get_limit_info(struct acpi_processor *pr)



