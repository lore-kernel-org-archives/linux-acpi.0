From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: [PATCH] acpi: processor_idle format warning
Date: Mon, 10 Jan 2005 14:52:03 -0800
Message-ID: <20050110145203.4e4c3a89.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Linux 2.6.10-bk13

Fix several format warnings in processor_idle.c:
drivers/acpi/processor_idle.c:846: warning: int format, different type arg (arg 3)
drivers/acpi/processor_idle.c:877: warning: int format, different type arg (arg 3)
drivers/acpi/processor_idle.c:884: warning: int format, different type arg (arg 3)

Signed-off-by: Randy Dunlap <rddunlap-3NddpPZAyC0@public.gmane.org>

diffstat:=
 drivers/acpi/processor_idle.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naurp ./drivers/acpi/processor_idle.c~acpi_types ./drivers/acpi/processor_idle.c
--- ./drivers/acpi/processor_idle.c~acpi_types	2005-01-10 10:38:39.479503496 -0800
+++ ./drivers/acpi/processor_idle.c	2005-01-10 11:37:18.142585400 -0800
@@ -839,9 +839,9 @@ static int acpi_processor_power_seq_show
 		goto end;
 
 	seq_printf(seq, "active state:            C%d\n"
-			"max_cstate:              C%d\n"
+			"max_cstate:              C%u\n"
 			"bus master activity:     %08x\n",
-			pr->power.state ? pr->power.state - pr->power.states : 0,
+			pr->power.state ? (int)(pr->power.state - pr->power.states) : 0,
 			max_cstate,
 			pr->power.bm_activity);
 
@@ -873,14 +873,14 @@ static int acpi_processor_power_seq_show
 
 		if (pr->power.states[i].promotion.state)
 			seq_printf(seq, "promotion[C%d] ",
-				(pr->power.states[i].promotion.state -
+				(int)(pr->power.states[i].promotion.state -
 				 pr->power.states));
 		else
 			seq_puts(seq, "promotion[--] ");
 
 		if (pr->power.states[i].demotion.state)
 			seq_printf(seq, "demotion[C%d] ",
-				(pr->power.states[i].demotion.state -
+				(int)(pr->power.states[i].demotion.state -
 				 pr->power.states));
 		else
 			seq_puts(seq, "demotion[--] ");
@@ -920,7 +920,7 @@ int acpi_processor_power_init(struct acp
 	if (!first_run) {
 		dmi_check_system(processor_power_dmi_table);
 		if (max_cstate < ACPI_C_STATES_MAX)
-			printk(KERN_NOTICE "ACPI: processor limited to max C-state %d\n", max_cstate);
+			printk(KERN_NOTICE "ACPI: processor limited to max C-state %u\n", max_cstate);
 		first_run++;
 	}
 

---


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
