From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 2/5] processor: C0, C1, C2 naming
Date: Thu, 23 Dec 2004 15:07:23 +0100
Message-ID: <20041223140723.GB7973@dominikbrodowski.de>
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

Current policy is to name both C-state-types and the actual C-States
"C[0-n]". Follow this rule...

Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
---

 drivers/acpi/processor_idle.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c	2004-12-23 14:24:13.328939202 +0100
+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c	2004-12-23 14:25:23.854099002 +0100
@@ -834,7 +834,7 @@
 	if (!pr)
 		goto end;
 
-	seq_printf(seq, "active state:            %d\n"
+	seq_printf(seq, "active state:            C%d\n"
 			"max_cstate:              C%d\n"
 			"bus master activity:     %08x\n",
 			pr->power.state ? pr->power.state - pr->power.states : 0,
@@ -844,7 +844,7 @@
 	seq_puts(seq, "states:\n");
 
 	for (i = 1; i <= pr->power.count; i++) {
-		seq_printf(seq, "   %c%d:                  ",
+		seq_printf(seq, "   %cC%d:                  ",
 			(&pr->power.states[i] == pr->power.state?'*':' '), i);
 
 		if (!pr->power.states[i].valid) {
@@ -868,18 +868,18 @@
 		}
 
 		if (pr->power.states[i].promotion.state)
-			seq_printf(seq, "promotion[%d] ",
+			seq_printf(seq, "promotion[C%d] ",
 				(pr->power.states[i].promotion.state -
 				 pr->power.states));
 		else
-			seq_puts(seq, "promotion[-] ");
+			seq_puts(seq, "promotion[--] ");
 
 		if (pr->power.states[i].demotion.state)
-			seq_printf(seq, "demotion[%d] ",
+			seq_printf(seq, "demotion[C%d] ",
 				(pr->power.states[i].demotion.state -
 				 pr->power.states));
 		else
-			seq_puts(seq, "demotion[-] ");
+			seq_puts(seq, "demotion[--] ");
 
 		seq_printf(seq, "latency[%03d] usage[%08d]\n",
 			pr->power.states[i].latency,
@@ -939,7 +939,7 @@
 		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
 		for (i = 1; i <= pr->power.count; i++)
 			if (pr->power.states[i].valid)
-				printk(" %d[C%d]", i, pr->power.states[i].type);
+				printk(" C%d[C%d]", i, pr->power.states[i].type);
 		printk(")\n");
 
 		if (pr->id == 0) {


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
