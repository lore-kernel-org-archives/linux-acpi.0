From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: noise from Dell laptops
Date: 09 Aug 2004 13:14:34 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092071674.2229.23.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-C/MxYHVRK98ofnMqmCKM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-C/MxYHVRK98ofnMqmCKM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Do people with Dell laptops that are make noise in idle
find that Jos's patch along with acpi_cstate_limit=2
makes it quiet?

thanks,
-Len

--=-C/MxYHVRK98ofnMqmCKM
Content-Disposition: inline
Content-Description: Forwarded message - Re: Linux ACPI processor driver
	patch: user-definable power state limit
Content-Type: message/rfc822

X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Received: from hdsmsx404.amr.corp.intel.com ([10.127.2.66]) by
	hdsmsx403.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.6713); Sat, 7
	Aug 2004 13:59:17 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C47CA8.41974880"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by
	hdsmsx404.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.6713); Sat, 7
	Aug 2004 13:59:17 -0400
Received: from orsmsx311.amr.corp.intel.com ([192.168.65.40]) by
	fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sat, 7 Aug
	2004 10:59:16 -0700
Received: from orsmsx332.amr.corp.intel.com ([192.168.65.60]) by
	orsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sat, 7 Aug
	2004 10:59:16 -0700
Received: from orsmsxvs041.jf.intel.com ([192.168.65.54]) by
	orsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.0); Sat, 7 Aug
	2004 10:59:15 -0700
Received: from petasus.jf.intel.com ([10.7.209.6]) by
	orsmsxvs041.jf.intel.com (SAVSMTP 3.1.2.35) with SMTP id
	M2004080710591515311 for <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat, 07 Aug 2004 10:59:15
	-0700
Received: from caduceus.jf.intel.com (caduceus.jf.intel.com [10.7.208.8])
	by petasus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.11
	2004/07/29 22:51:53 root Exp $) with ESMTP id i77I1T5v002829 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat, 7 Aug 2004 18:01:29 GMT
Received: from pecan.UGent.be (pecan.ugent.be [157.193.49.18]) by
	caduceus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.15
	2004/01/30 18:16:28 root Exp $) with ESMTP id i77HwHBq020518 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat, 7 Aug 2004 17:58:18 GMT
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	pecan.UGent.be (Postfix) with ESMTP id 2A58535268F for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat,  7 Aug 2004 19:59:13 +0200 (CEST)
Received: from pecan.UGent.be ([127.0.0.1]) by localhost (gorilla.UGent.be
	[127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 00503-08 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat,  7 Aug 2004 19:59:11 +0200 (CEST)
Received: from tarzan.ugent.be (tarzan.ugent.be [157.193.40.45]) by
	pecan.UGent.be (Postfix) with ESMTP id B33ED352686 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat,  7 Aug 2004 19:59:11 +0200 (CEST)
Received: from vpna167.ugent.be (vpna167.ugent.be [157.193.1.167]) by
	tarzan.ugent.be (Postfix) with ESMTP id BDC2453D02B for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat,  7 Aug 2004 19:59:10 +0200 (CEST)
content-class: urn:content-classes:message
Subject: Re: Linux ACPI processor driver patch: user-definable power state
	limit
Date: Sat, 7 Aug 2004 13:59:10 -0400
Message-ID: <200408071959.10529.jos.delbar-Cru1EgDzd7c@public.gmane.org>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Linux ACPI processor driver patch: user-definable power state
	limit
Thread-Index: AcR8qEIlmjjv4pwDTra/CgFdrw2PPA==
X-Message-Flag: Follow up
From: "Jos Delbar" <jos.delbar-Cru1EgDzd7c@public.gmane.org>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


------_=_NextPart_001_01C47CA8.41974880
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 6.0.6487.1">
<TITLE>Re: Linux ACPI processor driver patch: user-definable power state limit</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=2>On Monday 02 August 2004 02:54, you wrote:</FONT>

<BR><FONT SIZE=2>&gt; I think we need a patch like this for a number of reasons.</FONT>

<BR><FONT SIZE=2>&gt; Some systems experience data corruption with C3,</FONT>

<BR><FONT SIZE=2>&gt; so until it is fixed we need an easy way to disable C3.</FONT>

<BR><FONT SIZE=2>&gt;</FONT>

<BR><FONT SIZE=2>&gt; boot parameter names must begin with acpi though.</FONT>

<BR><FONT SIZE=2>&gt; maybe acpi_cstate_limit=3 or something?</FONT>

<BR><FONT SIZE=2>&gt;</FONT>

<BR><FONT SIZE=2>&gt; Please send me the exact model numbers of the Dells</FONT>

<BR><FONT SIZE=2>&gt; that you know have this problem.&nbsp; I met a guy from</FONT>

<BR><FONT SIZE=2>&gt; Dell who I may be able to get to help us with</FONT>

<BR><FONT SIZE=2>&gt; those models.</FONT>

<BR><FONT SIZE=2>&gt;</FONT>

<BR><FONT SIZE=2>&gt; thanks,</FONT>

<BR><FONT SIZE=2>&gt; -Len</FONT>
</P>

<P><FONT SIZE=2>I browsed through the Dell community forums and I believe it is safe to </FONT>

<BR><FONT SIZE=2>conclude that at least the following notebook models may have this problem:</FONT>
</P>

<P><FONT SIZE=2>- Inspiron 300m, 500m, 600m</FONT>

<BR><FONT SIZE=2>- Inspiron 4000, 4100, 4150</FONT>

<BR><FONT SIZE=2>- Inspiron 8100, 8200, 8500, 8600</FONT>

<BR><FONT SIZE=2>- Latitude C840</FONT>

<BR><FONT SIZE=2>- Latitude D500, D600, D800</FONT>
</P>

<P><FONT SIZE=2>As expected, all of these systems use a mobile processor chipset, with either </FONT>

<BR><FONT SIZE=2>an Intel Celeron-M, Pentium III-M, Pentium 4-M or Pentium M processor. All of </FONT>

<BR><FONT SIZE=2>the people who have posted about this buzzing noise are using an ACPI-enabled </FONT>

<BR><FONT SIZE=2>operating system, the majority Windows 2000/XP. Windows 98 does not have this </FONT>

<BR><FONT SIZE=2>problem, for example. On systems that support it, disabling the power </FONT>

<BR><FONT SIZE=2>management of the USB Root Hub(s) apparently softens--but does not </FONT>

<BR><FONT SIZE=2>eliminate--the buzzing.</FONT>
</P>

<P><FONT SIZE=2>I updated the patch with the new module parameter name &quot;acpi_cstate_limit&quot; and </FONT>

<BR><FONT SIZE=2>cleaned up the results of /proc/acpi/processor/.../power a little. The output </FONT>

<BR><FONT SIZE=2>using acpi_cstate_limit=2 will now resemble:</FONT>
</P>

<P><FONT SIZE=2>active state: C2</FONT>

<BR><FONT SIZE=2>default state: C1</FONT>

<BR><FONT SIZE=2>user limit: C2</FONT>

<BR><FONT SIZE=2>bus master activity: ffffffff</FONT>

<BR><FONT SIZE=2>states:</FONT>

<BR><FONT SIZE=2>C1: promotion[C2] demotion[--] latency[000] usage[00300510]</FONT>

<BR><FONT SIZE=2>*C2: promotion[--] demotion[C1] latency[050] usage[04964774]</FONT>

<BR><FONT SIZE=2>C3: &lt;disabled&gt;</FONT>
</P>

<P><FONT SIZE=2>If acpi_cstate_limit is passed as a kernel boot parameter, the kernel ring </FONT>

<BR><FONT SIZE=2>buffer will reflect this. For example, using &quot;processor.acpi_cstate_limit=1&quot;, </FONT>

<BR><FONT SIZE=2>the relevant output for my system is:</FONT>
</P>

<P><FONT SIZE=2>ACPI: Processor [CPU0] (supports C0 C1, 8 throttling states)</FONT>
</P>

<P><FONT SIZE=2>I chose to always display C0 so this message will still make sense when using </FONT>

<BR><FONT SIZE=2>acpi_cstate_limit=0.</FONT>
</P>

<P><FONT SIZE=2>One of the changes that I made, is unrelated to the C state limit.</FONT>
</P>

<P><FONT SIZE=2>@@ -2417,7 +2446,7 @@</FONT>

<BR><FONT SIZE=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr = (struct acpi_processor *) acpi_driver_data(device);</FONT>
</P>

<P><FONT SIZE=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unregister the idle handler when processor #0 is removed. */</FONT>

<BR><FONT SIZE=2>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pr-&gt;id == 0)</FONT>

<BR><FONT SIZE=2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((pr-&gt;id == 0) &amp;&amp; (pr-&gt;flags.power))</FONT>

<BR><FONT SIZE=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_idle = pm_idle_save;</FONT>
</P>

<P><FONT SIZE=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = acpi_remove_notify_handler(pr-&gt;handle, ACPI_DEVICE_NOTIFY,</FONT>
</P>

<P><FONT SIZE=2>Without the check for pr-&gt;flags.power, it's possible that the old idle handler </FONT>

<BR><FONT SIZE=2>would be &quot;restored&quot; without ever being stored in the function </FONT>

<BR><FONT SIZE=2>acpi_processor_add(). In practice this shouldn't cause a problem since the </FONT>

<BR><FONT SIZE=2>pm_idle_save global variable is implicitly initialized to NULL, but it feels </FONT>

<BR><FONT SIZE=2>safer to do the check anyway.</FONT>
</P>

<P><FONT SIZE=2>Regards,</FONT>
</P>

<P><FONT SIZE=2>- Jos Delbar</FONT>

<BR><FONT SIZE=2>&nbsp; jos.delbar-Cru1EgDzd7c@public.gmane.org</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C47CA8.41974880
Content-Description: processor.c.diff
Content-Disposition: attachment; filename="processor.c.diff"
Content-Type: text/x-diff; name=processor.c.diff
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

------_=_NextPart_001_01C47CA8.41974880--


--=-C/MxYHVRK98ofnMqmCKM--

--=-C/MxYHVRK98ofnMqmCKM--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
