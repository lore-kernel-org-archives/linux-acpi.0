From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 on Asus M6R
Date: Mon, 21 Mar 2005 22:56:52 +0100
Message-ID: <200503212256.52798.stefandoesinger@gmx.at>
References: <20050321135401.GC30293@fi.muni.cz> <200503212056.20589.stefandoesinger@gmx.at> <20050321210217.GF14356@fi.muni.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kM0PCKXF7DD5mmY"
In-Reply-To: <20050321210217.GF14356-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
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
Cc: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_kM0PCKXF7DD5mmY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 21. M=E4rz 2005 22:02 schrieb Jan Kasprzak:
> Stefan D=F6singer wrote:
> : You can try to place a few markers in the wakeup code. The first one
> : would be to insert "lcall $0xffff, $0" (without the quote, hope the code
> : is correct) in arch/i386/kernel/wakeup.S right at the beginning after
> : ".code16" (Line number 22 in 2.6.11.3.
>
> 	It is arch/i386/kernel/acpi/wakeup.S. Yes, adding "lcall $0xffff, $0"
> to the line #22 causes the machine reboot when I hit the power button aft=
er
> the suspend.
>
> 	OK, I will try to move this instruction down in wakeup.S now.
> Any other hints? Thanks!
1)Try  the attached patch

2)Yes, try to take down the line. The next function is, I think, in=20
drivers/acpi/sleep/main.c. Search for the "Back to C" string to find it.

Watch out: that call is an old real mode BIOS call which simply causes a sy=
sem=20
reset. It won't work as soon as the system is in protected mode again(the=20
switch is somewhere in wakeup.S I think.

3)As soon as the machine reaches the protected mode, you can try to make be=
eps=20
from the system speaker, if you have one. I don't know how to do this anywa=
y.

4)Did you build a minimal kernel with as few drivers as possible?

Stefan

--Boundary-00=_kM0PCKXF7DD5mmY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="suspend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.diff"

--- linux-2.6.9/include/linux/pm.h	2005-01-20 14:04:54.248337144 +0100
+++ include/linux/pm.h	2005-01-20 14:03:12.000000000 +0100
@@ -206,9 +206,11 @@
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
-	int (*prepare)(suspend_state_t state);
-	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
+	int (*prepare)(suspend_state_t state);		/*Called before suspending devices*/
+	int (*setup)(suspend_state_t state);		/*Called after device suspend*/
+	int (*enter)(suspend_state_t state);		/*To Finally enter the sleep state*/
+	int (*leave)(suspend_state_t state);		/*Before device wakeup*/
+	int (*finish)(suspend_state_t state);		/*After device wakeup*/
 };
 
 extern void pm_set_ops(struct pm_ops *);
--- linux-2.6.9/kernel/power/main.c	2005-01-20 14:04:54.463304464 +0100
+++ kernel/power/main.c	2005-01-20 14:10:36.499307088 +0100
@@ -67,6 +67,12 @@
 
 	if ((error = device_suspend(state)))
 		goto Finish;
+
+	if (pm_ops->setup) {
+		if ((error = pm_ops->setup(state)))
+			goto Finish;
+	}
+
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -104,6 +110,8 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.9/drivers/acpi/sleep/main.c	2005-01-20 14:04:47.382380928 +0100
+++ drivers/acpi/sleep/main.c	2005-01-20 14:12:29.234168784 +0100
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
@@ -143,9 +159,6 @@
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
-	acpi_leave_sleep_state(acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
-
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
 

--Boundary-00=_kM0PCKXF7DD5mmY--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
