From: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state limit
Date: Mon, 11 Oct 2004 23:35:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410112335.19159.jos.delbar@ugent.be>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XyvaBDib/jAN5LB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_XyvaBDib/jAN5LB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here is a new version of the power state limit patch that applies to ACPI=20
20040816. I also fixed a few bugs I bumped into along the way...

in acpi_processor_get_power_info_cst()

> @@ -671,7 +696,7 @@
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* The first state is always C0, which is already=
 filled. */
> =A0=A0=A0=A0=A0=A0=A0=A0pr->power.count =3D 1;
> -=A0=A0=A0=A0=A0=A0=A0for (i =3D 1; i <=3D count; i++) {
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 1; i < count; i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0union acpi_object *elemen=
t;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0union acpi_object *obj;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct acpi_power_registe=
r *reg;

The count value extracted from _CST is the number of the highest C state pl=
us=20
1 and is not to be confused with the meaning of the=20
acpi_processor_power.count member (pr->power.count) which is simply the=20
highest C state. An extra iteration was made creating an invalid C4 state f=
or=20
my processor, visible in /proc/acpi/processor/CPU0/power.

I think the current usage of acpi_processor_power.count is misleading and=20
propose to either rename the member to something like "max_state", or to gi=
ve=20
the member a new meaning as the highest C state plus 1 and rework the code =
to=20
reflect that change.

in acpi_processor_get_power_info_fadt()

> @@ -901,7 +926,7 @@
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0memset(pr->power.states, 0,=
 sizeof(struct=20
acpi_processor_cx));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0memset(&pr->power.states[i]=
, 0, sizeof(struct=20
acpi_processor_cx));
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (pr->pblk) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr->power.states[ACPI_STA=
TE_C2].address =3D pr->pblk + 4;

The acpi_processor_power.states (pr->power.states) array was not properly=20
initialized.

=2D Jos

On Sunday 10 October 2004 18:56, you wrote:
> >Do you require a new version of the patch without the "acpi_" prefix?
>
> sure, and if you can re-send a version that applies cleanly
> to the current tree, that would be great.
>
> thanks,
> -Len
>
> ps. FYI, if patches are generated with "diff -Naur from "/usr/src/linux"
> then that is easier for me to deal with.  eg.
>
> a/drivers/acpi/processor.c
> vs.
> b/drivers/acpi/processor.c
>
> also, attachments are ok.

=2D-=20

Jos Delbar
jos.delbar-Cru1EgDzd7c@public.gmane.org

--Boundary-00=_XyvaBDib/jAN5LB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="processor.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="processor.c.diff"

--- a/drivers/acpi/processor.c	2004-10-11 22:09:52.000000000 +0200
+++ b/drivers/acpi/processor.c	2004-10-11 22:56:06.666140905 +0200
@@ -30,6 +30,13 @@
  *	4. Need C1 timing -- must modify kernel (IRQ handler) to get this.
  */
 
+/*
+ * 11/10/2004; Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>
+ * Add user-definable processor power state limit (cstate_limit).
+ * Various bug fixes.
+ * Patch applies to acpi-20040816-26-stable.
+ */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -80,6 +87,17 @@
 MODULE_DESCRIPTION(ACPI_PROCESSOR_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
+/*
+ * The cstate_limit module parameter represents the maximum processor power state or C
+ * state to promote to. Values of 1, 2 and 3 are equivalent to the C1, C2 and C3 sleep
+ * states, respectively. A value of 0 disables processor power management altogether.
+ */
+
+static int cstate_limit = ACPI_C_STATES_MAX;
+
+module_param(cstate_limit, int, S_IRUSR | S_IRGRP | S_IROTH);
+MODULE_PARM_DESC(cstate_limit, "Limit the processor power state (0 = disable power management)");
+
 
 static int acpi_processor_add (struct acpi_device *device);
 static int acpi_processor_remove (struct acpi_device *device, int type);
@@ -454,6 +472,7 @@
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
 		break;
 
+	case ACPI_STATE_C0:
 	default:
 		local_irq_enable();
 		return;
@@ -544,7 +563,7 @@
 	 * C0/C1
 	 * -----
 	 */
-	pr->power.state = ACPI_STATE_C1;
+	pr->power.state = (cstate_limit != ACPI_STATE_C0 ? ACPI_STATE_C1 : ACPI_STATE_C0);
 	pr->power.default_state = ACPI_STATE_C1;
 
 	for (i = 0; i <= pr->power.count; i++) {
@@ -571,15 +590,18 @@
 		 * TBD: Investigate policy's use of CPU utilization -vs- sleep duration.
 		 * XXX update comment.
 		 */
-		pr->power.states[i-1].promotion.threshold.count = 10;
-		pr->power.states[i-1].promotion.threshold.ticks =
-			pr->power.states[i].latency_ticks;
-		pr->power.states[i-1].promotion.state = i;
-
-		pr->power.states[i].demotion.threshold.count = 1;
-		pr->power.states[i].demotion.threshold.ticks =
-			pr->power.states[i].latency_ticks;
-		pr->power.states[i].demotion.state = i-1;
+		if (cstate_limit >= ACPI_STATE_C2)
+		{
+			pr->power.states[i-1].promotion.threshold.count = 10;
+			pr->power.states[i-1].promotion.threshold.ticks =
+				pr->power.states[i].latency_ticks;
+			pr->power.states[i-1].promotion.state = i;
+	
+			pr->power.states[i].demotion.threshold.count = 1;
+			pr->power.states[i].demotion.threshold.ticks =
+				pr->power.states[i].latency_ticks;
+			pr->power.states[i].demotion.state = i-1;
+		}
 			break;
   
 		case ACPI_STATE_C3:
@@ -593,17 +615,20 @@
 		 *
 		 * XXX update comment.
 		 */
-		pr->power.states[i-1].promotion.threshold.count = 4;
-		pr->power.states[i-1].promotion.threshold.ticks =
-			pr->power.states[i].latency_ticks;
-		pr->power.states[i-1].promotion.threshold.bm = 0x0F;
-		pr->power.states[i-1].promotion.state = i;
-
-		pr->power.states[i].demotion.threshold.count = 1;
-		pr->power.states[i].demotion.threshold.ticks =
-			pr->power.states[i].latency_ticks;
-		pr->power.states[i].demotion.threshold.bm = 0x0F;
-		pr->power.states[i].demotion.state = i-1;
+		if (cstate_limit >= ACPI_STATE_C3)
+		{
+			pr->power.states[i-1].promotion.threshold.count = 4;
+			pr->power.states[i-1].promotion.threshold.ticks =
+				pr->power.states[i].latency_ticks;
+			pr->power.states[i-1].promotion.threshold.bm = 0x0F;
+			pr->power.states[i-1].promotion.state = i;
+	
+			pr->power.states[i].demotion.threshold.count = 1;
+			pr->power.states[i].demotion.threshold.ticks =
+				pr->power.states[i].latency_ticks;
+			pr->power.states[i].demotion.threshold.bm = 0x0F;
+			pr->power.states[i].demotion.state = i-1;
+		}
 			break;
 		default:
 			return_VALUE(-EINVAL);
@@ -671,7 +696,7 @@
 
 	/* The first state is always C0, which is already filled. */
 	pr->power.count = 1;
-	for (i = 1; i <= count; i++) {
+	for (i = 1; i < count; i++) {
 		union acpi_object *element;
 		union acpi_object *obj;
 		struct acpi_power_register *reg;
@@ -901,7 +926,7 @@
 	 */
 
 	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
-		memset(pr->power.states, 0, sizeof(struct acpi_processor_cx));
+		memset(&pr->power.states[i], 0, sizeof(struct acpi_processor_cx));
 
 	if (pr->pblk) {
 		pr->power.states[ACPI_STATE_C2].address = pr->pblk + 4;
@@ -2185,10 +2210,15 @@
 		goto end;
 
 	seq_printf(seq, "active state:            C%d\n"
-			"default state:           C%d\n"
-			"bus master activity:     %08x\n",
+			"default state:           C%d\n",
 			pr->power.state,
-			pr->power.default_state,
+			pr->power.default_state);
+
+	if (cstate_limit < ACPI_C_STATES_MAX) seq_printf(seq,
+			"user limit:              C%d\n",
+			cstate_limit);
+
+	seq_printf(seq, "bus master activity:     %08x\n",
 			pr->power.bm_activity);
 
 	seq_puts(seq, "states:\n");
@@ -2204,6 +2234,11 @@
 
 		seq_printf(seq, "type[%d] ", pr->power.states[i].type);
 
+		if (i > cstate_limit) {
+			seq_puts(seq, "<disabled>\n");
+			continue;
+		}
+
 		if (pr->power.states[i].promotion.state)
 			seq_printf(seq, "promotion[C%d] ",
 				pr->power.states[i].promotion.state);
@@ -2727,7 +2762,7 @@
 
 	printk(KERN_INFO PREFIX "%s [%s] (supports",
 		acpi_device_name(device), acpi_device_bid(device));
-	for (i = 1; i <= pr->power.count; i++)
+	for (i = 0; i <= cstate_limit; i++)
 		if (pr->power.states[i].valid)
 			printk(" C%d", i);
 	if (pr->flags.throttling)
@@ -2770,7 +2805,7 @@
 	}
 
 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if ((pr->id == 0) && (pr->flags.power))
 		pm_idle = pm_idle_save;
 
 	acpi_processor_remove_fs(device);
@@ -2793,6 +2828,10 @@
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
+	/* Check for illegal user limits. */
+	if(cstate_limit < ACPI_STATE_C0 || cstate_limit > ACPI_C_STATES_MAX)
+		return_VALUE(-EINVAL);
+
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
 		return_VALUE(-ENODEV);

--Boundary-00=_XyvaBDib/jAN5LB--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
