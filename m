From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 4/5] processor: nocst module parameter
Date: Thu, 23 Dec 2004 15:08:09 +0100
Message-ID: <20041223140809.GD7973@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a "nocst" module parameter which blocks _CST parsing and 
always uses FADT info instead.

Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
---

 drivers/acpi/processor_idle.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c	2004-12-23 14:25:28.737417644 +0100
+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c	2004-12-23 14:25:32.385908579 +0100
@@ -55,7 +55,10 @@
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 
 static void (*pm_idle_save)(void);
-module_param_named(max_cstate, max_cstate, uint, 0644);
+module_param(max_cstate, uint, 0644);
+
+static unsigned int nocst = 0;
+module_param(nocst, uint, 0000);
 
 /* --------------------------------------------------------------------------
                                 Power Management
@@ -506,6 +509,10 @@
 
 	if (errata.smp)
 		return_VALUE(-ENODEV);
+
+	if (nocst)
+		return_VALUE(-ENODEV);
+
 	pr->power.count = 0;
 	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
 		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
@@ -800,7 +807,7 @@
 	if (!pr)
  		return_VALUE(-EINVAL);
 
-	if (errata.smp) {
+	if (errata.smp || nocst) {
 		return_VALUE(-ENODEV);
 	}
 
@@ -917,7 +924,7 @@
 		first_run++;
 	}
 
-	if (!errata.smp && (pr->id == 0) && acpi_fadt.cst_cnt) {
+	if (!errata.smp && (pr->id == 0) && acpi_fadt.cst_cnt && !nocst) {
 		status = acpi_os_write_port(acpi_fadt.smi_cmd, acpi_fadt.cst_cnt, 8);
 		if (ACPI_FAILURE(status)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
