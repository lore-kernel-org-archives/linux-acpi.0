From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: RE: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Wed, 19 Jan 2005 16:36:14 +0100
Message-ID: <200501191636.15174.stefandoesinger@gmx.at>
References: <16A54BF5D6E14E4D916CE26C9AD30575F054DA@pdsmsx402.ccr.corp.intel.com> <200501151053.24075.stefandoesinger@gmx.at> <20050116215308.GG2757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v5n7BFL8yfFxylT"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050116215308.GG2757-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_v5n7BFL8yfFxylT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

> > > ACPI spec also said _PTS (in 'acpi_enter_sleep_state_prep') should be
> > > called after all devices are suspend (ACPI sepc 3.0 P401), could you
> > > please also change the order of device suspend and
> > > 'acpi_enter_sleep_state_prep'?
> >
> > Sorry for the delay, but I was quite busy this week. Here is the updated
> > patch which also causes pm_ops->prepare to be called after device
> > suspend. Is this correct or should I create another new function? What
> > does the spec say?
>
> Creating another function seems right. Even if ACPI does not need it,
> some other suspend mechanism will need it.

Allright, here it is. This patch introduces two new suspend/resume function=
s,=20
pm_ops->setup and pm_ops->leave. There are now 5 functions:

prepare: It's called before devices are suspended
setup: Called after device suspend but before finally going to sleep
enter: Last suspend function
leave: Called before devices are beeing resumed
finish: Last function, called after device resume

The code fom acpi_pm_prepare is moved to acpi_pm_setup. acpi_pm_leave is us=
ed=20
to call acpi_leave_sleep_state and to disable the wakeup devices before=20
resuming the devices. This is needed on some Notebooks, for example my Acer=
=20
Travelmate 800 and Samsung P3.

Stefan D=F6singer

--Boundary-00=_v5n7BFL8yfFxylT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="suspend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.diff"

--- linux-2.6.9/include/linux/pm.h	2005-01-19 16:20:35.600504440 +0100
+++ include/linux/pm.h	2005-01-19 14:47:54.000000000 +0100
@@ -207,7 +207,9 @@
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
 	int (*prepare)(suspend_state_t state);
+	int (*setup)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	int (*leave)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 };
 
--- linux-2.6.9/kernel/power/main.c	2005-01-19 16:20:35.831469328 +0100
+++ kernel/power/main.c	2005-01-19 16:30:50.407039640 +0100
@@ -64,9 +64,16 @@
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
 	}
-
+	
 	if ((error = device_suspend(state)))
 		goto Finish;
+	
+	if (pm_ops->setup) {
+		if ((error = pm_ops->setup(state)))
+			goto Finish;
+	}
+	
+	
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -104,6 +111,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.9/drivers/acpi/sleep/main.c	2005-01-19 16:20:28.773542296 +0100
+++ drivers/acpi/sleep/main.c	2005-01-19 16:30:00.369646480 +0100
@@ -36,7 +36,7 @@
 static int init_8259A_after_S1;
 
 /**
- *	acpi_pm_prepare - Do preliminary suspend work.
+ *	acpi_pm_setup - Do preliminary suspend work.
  *	@pm_state:		suspend state we're entering.
  *
  *	Make sure we support the state. If we do, and we need it, set the
@@ -44,7 +44,7 @@
  *	wakeup code to the waking vector. 
  */
 
-static int acpi_pm_prepare(suspend_state_t pm_state)
+static int acpi_pm_setup(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
@@ -130,7 +130,23 @@
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+/**
+ *	acpi_pm_leave - Make system ready to resume devices.
+ *	@pm_state:		State we're coming out of.
+ *
+ *	This is called after we wake back up and before device
+ *	resume methods are called.
+ */
 
+static int acpi_pm_leave(suspend_state_t pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
+
+	acpi_leave_sleep_state(acpi_state);
+	acpi_disable_wakeup_device(acpi_state);
+	
+	return 0;
+}
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
  *	@pm_state:		State we're coming out of.
@@ -142,10 +158,7 @@
 static int acpi_pm_finish(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
-
-	acpi_leave_sleep_state(acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
-
+	
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
@@ -171,8 +184,10 @@
 }
 
 static struct pm_ops acpi_pm_ops = {
-	.prepare	= acpi_pm_prepare,
+	.prepare	= NULL,
+	.setup		= acpi_pm_setup,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 

--Boundary-00=_v5n7BFL8yfFxylT--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
