From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Sat, 6 Nov 2004 00:54:03 +0100
Message-ID: <20041105235403.GA21880@dominikbrodowski.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com> <200410112335.19159.jos.delbar@ugent.be> <1099683907.13837.1353.camel@d845pe> <20041105225438.GA8262@dominikbrodowski.de> <1099696293.13834.1639.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099696293.13834.1639.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[ACPI-PROCESSOR] Dynamic limitation of available C-State types

Some drivers and/or some operations need to disable certain types of ACPI
CPU power states (a.k.a. C-States). Drivers which have requirements >= 99%
of the time should do:

1.) during module_init, get a struct acpi_cstate_limit *acpi_set_cstate_limit
    and pass the appropriate limit to acpi_set_cstate_limit().
2.) pass the aquired struct acpi_cstate_limit * to acpi_remove_cstate_limit() in
    module_exit.

A driver with dynamic requirements can do the following

1.) get a struct acpi_cstate_limit *acpi_set_cstate_limit(0);
    [zero means no limit!]
2.) a critical section should be marked like:
	acpi_modify_cstate_limit(cstate_limit, NEW_LIMIT);
	/* no C3 may be going on here... */
	...
	/* the CPU can sleep safely again */
	acpi_modify_cstate_limit(cstate_limit, 0);
3.) pass the aquired struct acpi_cstate_limit * to acpi_remove_cstate_limit() in
    module_exit.

Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2004-11-05 23:59:49.586947488 +0100
+++ linux/drivers/acpi/processor.c	2004-11-06 00:46:45.852810000 +0100
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
+#include <linux/list.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -304,6 +305,80 @@
                                 Power Management
    -------------------------------------------------------------------------- */
 
+/* others shall not modify anything in here directly, so the layout isn't
+ * exported anywhere else 
+ */
+struct acpi_cstate_limit {
+	struct list_head	list;
+	unsigned int		limit;
+};
+
+static unsigned int cstate_limit;
+static LIST_HEAD(cstate_limit_list);
+static spinlock_t cstate_limit_lock = SPIN_LOCK_UNLOCKED;
+
+static inline void acpi_update_cstate_limit(void)
+{
+	struct acpi_cstate_limit *cur;
+	unsigned int new_limit = 0;
+
+	list_for_each_entry(cur, &cstate_limit_list, list) {
+		if (cur->limit > new_limit)
+			new_limit = cur->limit;
+	}
+	cstate_limit = new_limit;
+}
+
+struct acpi_cstate_limit *acpi_set_cstate_limit(unsigned int limit)
+{
+	struct acpi_cstate_limit *data;
+	unsigned long flags;
+
+	might_sleep();
+
+	data = kmalloc(sizeof(struct acpi_cstate_limit), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->limit = limit;
+	
+	spin_lock_irqsave(&cstate_limit_lock, flags);
+	list_add(&data->list, &cstate_limit_list);
+	acpi_update_cstate_limit();
+	spin_unlock_irqrestore(&cstate_limit_lock, flags);
+
+	return data;
+}
+
+int acpi_modify_cstate_limit(struct acpi_cstate_limit *data, unsigned int limit)
+{
+	unsigned long flags;
+	if (!data)
+		return -ENODEV;
+
+	spin_lock_irqsave(&cstate_limit_lock, flags);
+	data->limit = limit;
+	acpi_update_cstate_limit();
+	spin_unlock_irqrestore(&cstate_limit_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_modify_cstate_limit);
+
+void acpi_remove_cstate_limit(struct acpi_cstate_limit *data)
+{
+	unsigned long flags;
+	if (!data)
+		return;
+
+	spin_lock_irqsave(&cstate_limit_lock, flags);
+	list_del(&data->list);
+	acpi_update_cstate_limit();
+	spin_unlock_irqrestore(&cstate_limit_lock, flags);
+}
+EXPORT_SYMBOL(acpi_remove_cstate_limit);
+
+
 static inline u32
 ticks_elapsed (
 	u32			t1,
@@ -359,6 +434,8 @@
 	int			next_state = 0;
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
+	unsigned long flags;
+
 
 	pr = processors[smp_processor_id()];
 	if (!pr)
@@ -419,6 +496,21 @@
 		}
 	}
 
+	/* Dynamic limitation? */
+	spin_lock_irqsave(&cstate_limit_lock, flags);
+	if ((cstate_limit) && (cstate_limit <= pr->power.state)) {
+		next_state = cstate_limit;
+		while (next_state > 1) {
+			if (!pr->power.states[next_state].valid)
+				next_state--;
+		}
+		spin_unlock_irqrestore(&cstate_limit_lock, flags);
+		local_irq_enable();
+		goto end;
+	}
+	spin_unlock_irqrestore(&cstate_limit_lock, flags);
+
+
 	cx->usage++;
 
 	/*
@@ -487,6 +579,7 @@
 
 	next_state = pr->power.state;
 
+
 	/*
 	 * Promotion?
 	 * ----------
@@ -494,7 +587,7 @@
 	 * and promote when the count threshold is reached.  Note that bus
 	 * mastering activity may prevent promotions.
 	 */
-	if (cx->promotion.state) {
+	if (cx->promotion.state && !t2) {
 		if (sleep_ticks > cx->promotion.threshold.ticks) {
 			cx->promotion.count++;
  			cx->demotion.count = 0;
@@ -537,8 +630,16 @@
 	 * If we're going to start using a new Cx state we must clean up
 	 * from the previous and prepare to use the new.
 	 */
-	if (next_state != pr->power.state)
-		acpi_processor_power_activate(pr, next_state);
+	if (next_state != pr->power.state) {
+		/* Dynamic limitation? */
+		spin_lock_irqsave(&cstate_limit_lock, flags);
+		if (cstate_limit && (cstate_limit >= next_state)) {
+			spin_unlock_irqrestore(&cstate_limit_lock, flags);
+		} else {
+			spin_unlock_irqrestore(&cstate_limit_lock, flags);
+			acpi_processor_power_activate(pr, next_state);
+		}
+	}
 
 	return;
 }
diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
--- linux-original/include/acpi/processor.h	2004-11-05 23:59:51.923592264 +0100
+++ linux/include/acpi/processor.h	2004-11-06 00:46:39.284808488 +0100
@@ -44,6 +44,13 @@
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };
 
+struct acpi_cstate_limit;
+
+struct acpi_cstate_limit* acpi_set_cstate_limit(unsigned int limit);
+int acpi_modify_cstate_limit(struct acpi_cstate_limit *data, unsigned int limit);
+void acpi_remove_cstate_limit(struct acpi_cstate_limit *data);
+
+
 /* Performance Management */
 
 struct acpi_pct_register {


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
