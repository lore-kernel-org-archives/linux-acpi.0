From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/7] Suspend: Introduce begin() and end() callbacks
Date: Tue, 8 Jan 2008 00:04:17 +0100
Message-ID: <200801080004.19170.rjw@sisk.pl>
References: <200801080002.25044.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38871 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbYAGXKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 18:10:25 -0500
In-Reply-To: <200801080002.25044.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

On ACPI systems the target state set by acpi_pm_set_target() is
reset by acpi_pm_finish(), but that need not be called if the
suspend fails. =A0All platforms that use the .set_target() global
suspend callback are affected by analogous issues.

=46or this reason, we need an additional global suspend callback that
will reset the target state regardless of whether or not the suspend
is successful. =A0Also, it is reasonable to rename the .set_target()
callback, since it will be used for a different purpose on ACPI
systems (due to ACPI 1.0x code ordering requirements).

Introduce the global suspend callback .end() to be executed at the
end of the suspend sequence and rename the .set_target() global
suspend callback to .begin().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-at91/pm.c                   |   17 +++++++++++++----
 arch/powerpc/platforms/52xx/lite5200_pm.c |   10 ++++++++--
 drivers/acpi/sleep/main.c                 |   22 ++++++++++++++++++---=
-
 include/linux/suspend.h                   |   29 ++++++++++++++++++---=
--------
 kernel/power/main.c                       |    9 ++++++---
 5 files changed, 63 insertions(+), 24 deletions(-)

Index: linux-2.6/include/linux/suspend.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -38,18 +38,16 @@ typedef int __bitwise suspend_state_t;
  *	There is the %suspend_valid_only_mem function available that can be
  *	assigned to this if the platform only supports mem sleep.
  *
- * @set_target: Tell the platform which system sleep state is going to=
 be
- *	entered.
- *	@set_target() is executed right prior to suspending devices.  The
- *	information conveyed to the platform code by @set_target() should b=
e
- *	disregarded by the platform as soon as @finish() is executed and if
- *	@prepare() fails.  If @set_target() fails (ie. returns nonzero),
+ * @begin: Initialise a transition to given system sleep state.
+ *	@begin() is executed right prior to suspending devices.  The inform=
ation
+ *	conveyed to the platform code by @begin() should be disregarded by =
it as
+ *	soon as @end() is executed.  If @begin() fails (ie. returns nonzero=
),
  *	@prepare(), @enter() and @finish() will not be called by the PM cor=
e.
  *	This callback is optional.  However, if it is implemented, the argu=
ment
- *	passed to @enter() is meaningless and should be ignored.
+ *	passed to @enter() is redundant and should be ignored.
  *
  * @prepare: Prepare the platform for entering the system sleep state =
indicated
- *	by @set_target().
+ *	by @begin().
  *	@prepare() is called right after devices have been suspended (ie. t=
he
  *	appropriate .suspend() method has been executed for each device) an=
d
  *	before the nonboot CPUs are disabled (it is executed with IRQs enab=
led).
@@ -57,8 +55,8 @@ typedef int __bitwise suspend_state_t;
  *	error code otherwise, in which case the system cannot enter the des=
ired
  *	sleep state (@enter() and @finish() will not be called in that case=
).
  *
- * @enter: Enter the system sleep state indicated by @set_target() or
- *	represented by the argument if @set_target() is not implemented.
+ * @enter: Enter the system sleep state indicated by @begin() or repre=
sented by
+ *	the argument if @begin() is not implemented.
  *	This callback is mandatory.  It returns 0 on success or a negative
  *	error code otherwise, in which case the system cannot enter the des=
ired
  *	sleep state.
@@ -69,13 +67,22 @@ typedef int __bitwise suspend_state_t;
  *	This callback is optional, but should be implemented by the platfor=
ms
  *	that implement @prepare().  If implemented, it is always called aft=
er
  *	@enter() (even if @enter() fails).
+ *
+ * @end: Called by the PM core right after resuming devices, to indica=
te to
+ *	the platform that the system has returned to the working state or
+ *	the transition to the sleep state has been aborted.
+ *	This callback is optional, but should be implemented by the platfor=
ms
+ *	that implement @begin(), but platforms implementing @begin() should
+ *	also provide a @end() which cleans up transitions aborted before
+ *	@enter().
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
-	int (*set_target)(suspend_state_t state);
+	int (*begin)(suspend_state_t state);
 	int (*prepare)(void);
 	int (*enter)(suspend_state_t state);
 	void (*finish)(void);
+	void (*end)(void);
 };
=20
 #ifdef CONFIG_SUSPEND
Index: linux-2.6/drivers/acpi/sleep/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -63,11 +63,11 @@ static u32 acpi_suspend_states[] =3D {
 static int init_8259A_after_S1;
=20
 /**
- *	acpi_pm_set_target - Set the target system sleep state to the state
+ *	acpi_pm_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
  */
=20
-static int acpi_pm_set_target(suspend_state_t pm_state)
+static int acpi_pm_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state =3D acpi_suspend_states[pm_state];
 	int error =3D 0;
@@ -164,7 +164,7 @@ static int acpi_pm_enter(suspend_state_t
 }
=20
 /**
- *	acpi_pm_finish - Finish up suspend sequence.
+ *	acpi_pm_finish - Instruct the platform to leave a sleep state.
  *
  *	This is called after we wake back up (or if entering the sleep stat=
e
  *	failed).=20
@@ -190,6 +190,19 @@ static void acpi_pm_finish(void)
 #endif
 }
=20
+/**
+ *	acpi_pm_end - Finish up suspend sequence.
+ */
+
+static void acpi_pm_end(void)
+{
+	/*
+	 * This is necessary in case acpi_pm_finish() is not called during a
+	 * failing transition to a sleep state.
+	 */
+	acpi_target_sleep_state =3D ACPI_STATE_S0;
+}
+
 static int acpi_pm_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -208,10 +221,11 @@ static int acpi_pm_state_valid(suspend_s
=20
 static struct platform_suspend_ops acpi_pm_ops =3D {
 	.valid =3D acpi_pm_state_valid,
-	.set_target =3D acpi_pm_set_target,
+	.begin =3D acpi_pm_begin,
 	.prepare =3D acpi_pm_prepare,
 	.enter =3D acpi_pm_enter,
 	.finish =3D acpi_pm_finish,
+	.end =3D acpi_pm_end,
 };
=20
 /*
Index: linux-2.6/arch/arm/mach-at91/pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/arm/mach-at91/pm.c
+++ linux-2.6/arch/arm/mach-at91/pm.c
@@ -52,7 +52,7 @@ static suspend_state_t target_state;
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
-static int at91_pm_set_target(suspend_state_t state)
+static int at91_pm_begin(suspend_state_t state)
 {
 	target_state =3D state;
 	return 0;
@@ -197,11 +197,20 @@ error:
 	return 0;
 }
=20
+/*
+ * Called right prior to thawing processes.
+ */
+static void at91_pm_end(void)
+{
+	target_state =3D PM_SUSPEND_ON;
+}
+
=20
 static struct platform_suspend_ops at91_pm_ops =3D{
-	.valid		=3D at91_pm_valid_state,
-	.set_target	=3D at91_pm_set_target,
-	.enter		=3D at91_pm_enter,
+	.valid	=3D at91_pm_valid_state,
+	.begin	=3D at91_pm_begin,
+	.enter	=3D at91_pm_enter,
+	.end	=3D at91_pm_end,
 };
=20
 static int __init at91_pm_init(void)
Index: linux-2.6/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -253,10 +253,10 @@ int suspend_devices_and_enter(suspend_st
 	if (!suspend_ops)
 		return -ENOSYS;
=20
-	if (suspend_ops->set_target) {
-		error =3D suspend_ops->set_target(state);
+	if (suspend_ops->begin) {
+		error =3D suspend_ops->begin(state);
 		if (error)
-			return error;
+			goto Close;
 	}
 	suspend_console();
 	error =3D device_suspend(PMSG_SUSPEND);
@@ -289,6 +289,9 @@ int suspend_devices_and_enter(suspend_st
 	device_resume();
  Resume_console:
 	resume_console();
+ Close:
+	if (suspend_ops->end)
+		suspend_ops->end();
 	return error;
 }
=20
Index: linux-2.6/arch/powerpc/platforms/52xx/lite5200_pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ linux-2.6/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -31,7 +31,7 @@ static int lite5200_pm_valid(suspend_sta
 	}
 }
=20
-static int lite5200_pm_set_target(suspend_state_t state)
+static int lite5200_pm_begin(suspend_state_t state)
 {
 	if (lite5200_pm_valid(state)) {
 		lite5200_pm_target_state =3D state;
@@ -208,12 +208,18 @@ static void lite5200_pm_finish(void)
 		mpc52xx_pm_finish();
 }
=20
+static void lite5200_pm_end(void)
+{
+	lite5200_pm_target_state =3D PM_SUSPEND_ON;
+}
+
 static struct platform_suspend_ops lite5200_pm_ops =3D {
 	.valid		=3D lite5200_pm_valid,
-	.set_target	=3D lite5200_pm_set_target,
+	.begin		=3D lite5200_pm_begin,
 	.prepare	=3D lite5200_pm_prepare,
 	.enter		=3D lite5200_pm_enter,
 	.finish		=3D lite5200_pm_finish,
+	.end		=3D lite5200_pm_end,
 };
=20
 int __init lite5200_pm_init(void)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
