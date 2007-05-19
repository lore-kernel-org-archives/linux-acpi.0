From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Workaround for _PPC (BIOS cpufreq limitations)
Date: Fri, 18 May 2007 21:59:28 -0500
Message-ID: <1179543568.16465.35.camel@sublime.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3/7ambbo2bfSSzTII3tA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46192 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbXESC70 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 May 2007 22:59:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk


--=-3/7ambbo2bfSSzTII3tA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Len, can you apply this one, pls.

Workaround for _PPC (BIOS cpufreq limitations)

There have been fixes using _PPC, which seem to unhide a problem
on HP nx6125 (double cpufreq switch freezes the machine for
several seconds).
This one should provide a workaround for the nx6125 and for
possible other machines that show any weird _PPC behaviour.


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/processor_perflib.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.21/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.21.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.21/drivers/acpi/processor_perflib.c
@@ -60,6 +60,11 @@ static DEFINE_MUTEX(performance_mutex);
  * policy is adjusted accordingly.
  */
 
+static unsigned int ignore_ppc = 0;
+module_param(ignore_ppc, uint, 0644);
+MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
+		 "limited by BIOS, this should help");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -72,6 +77,9 @@ static int acpi_processor_ppc_notifier(s
 	struct acpi_processor *pr;
 	unsigned int ppc = 0;
 
+	if (ignore_ppc)
+		return 0;
+
 	mutex_lock(&performance_mutex);
 
 	if (event != CPUFREQ_INCOMPATIBLE)
@@ -130,7 +138,13 @@ static int acpi_processor_get_platform_l
 
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 {
-	int ret = acpi_processor_get_platform_limit(pr);
+	int ret;
+
+	if (ignore_ppc)
+		return 0;
+
+	ret = acpi_processor_get_platform_limit(pr);
+
 	if (ret < 0)
 		return (ret);
 	else


--=-3/7ambbo2bfSSzTII3tA
Content-Disposition: attachment; filename=cpufreq_ppc_boot_option.patch
Content-Type: text/x-patch; name=cpufreq_ppc_boot_option.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Workaround for _PPC (BIOS cpufreq limitations)

There have been fixes using _PPC, which seem to unhide a problem
on HP nx6125 (double cpufreq switch freezes the machine for
several seconds). 
This one should provide a workaround for the nx6125 and for
possible other machines that show any weird _PPC behaviour.


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/processor_perflib.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.21/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.21.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.21/drivers/acpi/processor_perflib.c
@@ -60,6 +60,11 @@ static DEFINE_MUTEX(performance_mutex);
  * policy is adjusted accordingly.
  */
 
+static unsigned int ignore_ppc = 0;
+module_param(ignore_ppc, uint, 0644);
+MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
+		 "limited by BIOS, this should help");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -72,6 +77,9 @@ static int acpi_processor_ppc_notifier(s
 	struct acpi_processor *pr;
 	unsigned int ppc = 0;
 
+	if (ignore_ppc)
+		return 0;
+
 	mutex_lock(&performance_mutex);
 
 	if (event != CPUFREQ_INCOMPATIBLE)
@@ -130,7 +138,13 @@ static int acpi_processor_get_platform_l
 
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 {
-	int ret = acpi_processor_get_platform_limit(pr);
+	int ret;
+
+	if (ignore_ppc)
+		return 0;
+
+	ret = acpi_processor_get_platform_limit(pr);
+
 	if (ret < 0)
 		return (ret);
 	else

--=-3/7ambbo2bfSSzTII3tA--

