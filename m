From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 1/5] processor: max_cstate means state not state type
Date: Thu, 23 Dec 2004 15:06:59 +0100
Message-ID: <20041223140659.GA7973@dominikbrodowski.de>
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

max_cstate shall limit C-states not C-state types.

Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
---

 drivers/acpi/osl.c            |    3 ++-
 drivers/acpi/processor_idle.c |   10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/osl.c
===================================================================
--- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/osl.c	2004-12-23 13:21:12.000000000 +0100
+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/osl.c	2004-12-23 14:09:10.928848851 +0100
@@ -40,6 +40,7 @@
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/processor.h>
 #include <asm/uaccess.h>
 
 #include <linux/efi.h>
@@ -1155,7 +1156,7 @@
  * max_cstate is defined in the base kernel so modules can
  * change it w/o depending on the state of the processor module.
  */
-unsigned int max_cstate = ACPI_C_STATES_MAX;
+unsigned int max_cstate = ACPI_PROCESSOR_MAX_POWER;
 
 
 EXPORT_SYMBOL(max_cstate);
Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c	2004-12-23 13:21:12.000000000 +0100
+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c	2004-12-23 14:24:13.328939202 +0100
@@ -69,11 +69,12 @@
  */
 static int no_c2c3(struct dmi_system_id *id)
 {
-	if (max_cstate > ACPI_C_STATES_MAX)
+	if (max_cstate > ACPI_PROCESSOR_MAX_POWER)
 		return 0;
 
 	printk(KERN_NOTICE PREFIX "%s detected - C2,C3 disabled."
-		" Override with \"processor.max_cstate=9\"\n", id->ident);
+		" Override with \"processor.max_cstate=%d\"\n", id->ident,
+	       ACPI_PROCESSOR_MAX_POWER + 1);
 
 	max_cstate = 1;
 
@@ -304,7 +305,8 @@
 	 * mastering activity may prevent promotions.
 	 * Do not promote above max_cstate.
 	 */
-	if (cx->promotion.state && (cx->promotion.state->type <= max_cstate)) {
+	if (cx->promotion.state &&
+	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
 		if (sleep_ticks > cx->promotion.threshold.ticks) {
 			cx->promotion.count++;
  			cx->demotion.count = 0;
@@ -344,7 +346,7 @@
 	/*
 	 * Demote if current state exceeds max_cstate
 	 */
-	if (pr->power.state->type > max_cstate) {
+	if ((pr->power.state - pr->power.states) > max_cstate) {
 		if (cx->demotion.state)
 			next_state = cx->demotion.state;
 	}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
