From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state
 limit
Date: 09 Oct 2004 01:52:00 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097301120.16784.2.camel@d845pe>
References: <200408071959.10529.jos.delbar@ugent.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4xfljjOQzb7QfWUzFbqr"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408071959.10529.jos.delbar-Cru1EgDzd7c@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-4xfljjOQzb7QfWUzFbqr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Jos,
Can you modify this patch to use a kernel boot parameter
rather than a module load parameter?  Some folks don't
load this driver as a module.  Also, it gives you the
chance to add a couple of lines to Documentation/kernel-parameters.txt

thanks,
-Len

On Sat, 2004-08-07 at 13:59, Jos Delbar wrote:
> On Monday 02 August 2004 02:54, you wrote:
> > I think we need a patch like this for a number of reasons.
> > Some systems experience data corruption with C3,
> > so until it is fixed we need an easy way to disable C3.
> >
> > boot parameter names must begin with acpi though.
> > maybe acpi_cstate_limit=3 or something?
> >
> > Please send me the exact model numbers of the Dells
> > that you know have this problem.  I met a guy from
> > Dell who I may be able to get to help us with
> > those models.
> >
> > thanks,
> > -Len
> 
> I browsed through the Dell community forums and I believe it is safe
> to 
> conclude that at least the following notebook models may have this
> problem:
> 
> - Inspiron 300m, 500m, 600m
> - Inspiron 4000, 4100, 4150
> - Inspiron 8100, 8200, 8500, 8600
> - Latitude C840
> - Latitude D500, D600, D800
> 
> As expected, all of these systems use a mobile processor chipset, with
> either 
> an Intel Celeron-M, Pentium III-M, Pentium 4-M or Pentium M processor.
> All of 
> the people who have posted about this buzzing noise are using an
> ACPI-enabled 
> operating system, the majority Windows 2000/XP. Windows 98 does not
> have this 
> problem, for example. On systems that support it, disabling the power 
> management of the USB Root Hub(s) apparently softens--but does not 
> eliminate--the buzzing.
> 
> I updated the patch with the new module parameter name
> "acpi_cstate_limit" and 
> cleaned up the results of /proc/acpi/processor/.../power a little. The
> output 
> using acpi_cstate_limit=2 will now resemble:
> 
> active state: C2
> default state: C1
> user limit: C2
> bus master activity: ffffffff
> states:
> C1: promotion[C2] demotion[--] latency[000] usage[00300510]
> *C2: promotion[--] demotion[C1] latency[050] usage[04964774]
> C3: <disabled>
> 
> If acpi_cstate_limit is passed as a kernel boot parameter, the kernel
> ring 
> buffer will reflect this. For example, using
> "processor.acpi_cstate_limit=1", 
> the relevant output for my system is:
> 
> ACPI: Processor [CPU0] (supports C0 C1, 8 throttling states)
> 
> I chose to always display C0 so this message will still make sense
> when using 
> acpi_cstate_limit=0.
> 
> One of the changes that I made, is unrelated to the C state limit.
> 
> @@ -2417,7 +2446,7 @@
>         pr = (struct acpi_processor *) acpi_driver_data(device);
> 
>         /* Unregister the idle handler when processor #0 is removed.
> */
> -       if (pr->id == 0)
> +       if ((pr->id == 0) && (pr->flags.power))
>                 pm_idle = pm_idle_save;
> 
>         status = acpi_remove_notify_handler(pr->handle,
> ACPI_DEVICE_NOTIFY,
> 
> Without the check for pr->flags.power, it's possible that the old idle
> handler 
> would be "restored" without ever being stored in the function 
> acpi_processor_add(). In practice this shouldn't cause a problem since
> the 
> pm_idle_save global variable is implicitly initialized to NULL, but it
> feels 
> safer to do the check anyway.
> 
> Regards,
> 
> - Jos Delbar
>   jos.delbar-Cru1EgDzd7c@public.gmane.org
> 

--=-4xfljjOQzb7QfWUzFbqr
Content-Disposition: attachment; filename=processor.c.diff
Content-Type: text/plain; name=processor.c.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- /usr/src/linux/drivers/acpi/processor.c	2004-08-07 18:25:15.064497551 +0200
+++ processor.c	2004-08-07 18:31:24.013809421 +0200
@@ -30,6 +30,14 @@
  *	4. Need C1 timing -- must modify kernel (IRQ handler) to get this.
  */
 
+/*
+ * 07/08/04; Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>:
+ * Recognize power state limit as a boot parameter.
+ *
+ * 31/07/04; Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>:
+ * Add user-definable processor power state limit.
+ */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -80,6 +88,16 @@
 MODULE_DESCRIPTION(ACPI_PROCESSOR_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+/*
+ * The acpi_cstate_limit module parameter represents the maximum processor power state or
+ * C state to promote to. Values of 1, 2 and 3 are equivalent to the C1, C2 and C3 sleep
+ * states, respectively. A value of 0 disables processor power management altogether.
+ */
+
+static int acpi_cstate_limit = ACPI_C_STATES_MAX;
+
+module_param(acpi_cstate_limit, int, S_IRUSR | S_IRGRP | S_IROTH);
+MODULE_PARM_DESC(acpi_cstate_limit, "Limit the processor power state (0 = disable power management)");
 
 static int acpi_processor_add (struct acpi_device *device);
 static int acpi_processor_remove (struct acpi_device *device, int type);
@@ -449,6 +467,7 @@
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
 		break;
 
+	case ACPI_STATE_C0:
 	default:
 		local_irq_enable();
 		return;
@@ -535,7 +554,7 @@
 	 * C0/C1
 	 * -----
 	 */
-	pr->power.state = ACPI_STATE_C1;
+	pr->power.state = (acpi_cstate_limit != ACPI_STATE_C0 ? ACPI_STATE_C1 : ACPI_STATE_C0);
 	pr->power.default_state = ACPI_STATE_C1;
 
 	/*
@@ -554,7 +573,7 @@
 	 * TBD: Demote to default C-State after long periods of activity.
 	 * TBD: Investigate policy's use of CPU utilization -vs- sleep duration.
 	 */
-	if (pr->power.states[ACPI_STATE_C2].valid) {
+	if (pr->power.states[ACPI_STATE_C2].valid && (acpi_cstate_limit >= ACPI_STATE_C2)) {
 		pr->power.states[ACPI_STATE_C1].promotion.threshold.count = 10;
 		pr->power.states[ACPI_STATE_C1].promotion.threshold.ticks =
 			pr->power.states[ACPI_STATE_C2].latency_ticks;
@@ -575,7 +594,7 @@
 	 * short or whenever bus mastering activity occurs.
 	 */
 	if ((pr->power.states[ACPI_STATE_C2].valid) &&
-		(pr->power.states[ACPI_STATE_C3].valid)) {
+		(pr->power.states[ACPI_STATE_C3].valid) && (acpi_cstate_limit >= ACPI_STATE_C3)) {
 		pr->power.states[ACPI_STATE_C2].promotion.threshold.count = 4;
 		pr->power.states[ACPI_STATE_C2].promotion.threshold.ticks =
 			pr->power.states[ACPI_STATE_C3].latency_ticks;
@@ -1859,10 +1878,15 @@
 		goto end;
 
 	seq_printf(seq, "active state:            C%d\n"
-			"default state:           C%d\n"
-			"bus master activity:     %08x\n",
+			"default state:           C%d\n",
 			pr->power.state,
-			pr->power.default_state,
+			pr->power.default_state);
+
+	if (acpi_cstate_limit < ACPI_C_STATES_MAX) seq_printf(seq,
+			"user limit:              C%d\n",
+			acpi_cstate_limit);
+
+	seq_printf(seq, "bus master activity:     %08x\n",
 			pr->power.bm_activity);
 
 	seq_puts(seq, "states:\n");
@@ -1876,6 +1900,11 @@
 			continue;
 		}
 
+		if (i > acpi_cstate_limit) {
+			seq_puts(seq, "<disabled>\n");
+			continue;
+		}
+
 		if (pr->power.states[i].promotion.state)
 			seq_printf(seq, "promotion[C%d] ",
 				pr->power.states[i].promotion.state);
@@ -2384,7 +2413,7 @@
 	
 	printk(KERN_INFO PREFIX "%s [%s] (supports",
 		acpi_device_name(device), acpi_device_bid(device));
-	for (i=1; i<ACPI_C_STATE_COUNT; i++)
+	for (i=0; i<=acpi_cstate_limit; i++)
 		if (pr->power.states[i].valid)
 			printk(" C%d", i);
 	if (pr->flags.throttling)
@@ -2417,7 +2446,7 @@
 	pr = (struct acpi_processor *) acpi_driver_data(device);
 
 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if ((pr->id == 0) && (pr->flags.power))
 		pm_idle = pm_idle_save;
 
 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY, 
@@ -2447,6 +2476,10 @@
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
+	/* Check for illegal user limits. */
+	if(acpi_cstate_limit < ACPI_STATE_C0 || acpi_cstate_limit > ACPI_C_STATES_MAX)
+		return_VALUE(-EINVAL);
+
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return_VALUE(-ENODEV);

--=-4xfljjOQzb7QfWUzFbqr--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
