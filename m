From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/37] Hibernation: New testing facility (rev. 2)
Date: Thu, 31 Jan 2008 23:36:42 -0500
Message-ID: <460db5c6402b5a4e362b564bdfa436dfa4e3b661.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:64964 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754158AbYBAElx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:41:53 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to test the hibernation core code with the help of the
/sys/power/pm_test attribute introduced for suspend testing in the prev=
ious
patch.

Writing an appropriate string to this file causes the hibernation code =
to work
in one of the test modes defined as follows:

freezer
- test the freezing of processes

devices
- test the freezing of processes and suspending of devices

platform
- test the freezing of processes, suspending of devices and platform gl=
obal
=C2=A0 control methods(*)

processors
- test the freezing of processes, suspending of devices, platform globa=
l
=C2=A0 control methods(*) and the disabling of nonboot CPUs

core
- test the freezing of processes, suspending of devices, platform globa=
l
=C2=A0 control methods(*), the disabling of nonboot CPUs and suspending=
 of
=C2=A0 platform/system devices

(*) - the platform global control methods are only available on ACPI sy=
stems
=C2=A0 =C2=A0 =C2=A0 and are only tested if the hibernation mode is set=
 to "platform"

Then, if a hibernation is started by normal means, the hibernation core=
 will
perform its normal operations up to the point indicated by given test l=
evel.
Next, it will wait for 5 seconds and carry out the resume operations ne=
eded to
transition the system back to the fully functional state.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/disk.c  |   70 +++++++++++++++++++++++++++++++++++++++---=
-------
 kernel/power/power.h |    2 +
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 6597365..0866b16 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -70,6 +70,35 @@ void hibernation_set_ops(struct platform_hibernation=
_ops *ops)
 	mutex_unlock(&pm_mutex);
 }
=20
+#ifdef CONFIG_PM_DEBUG
+static void hibernation_debug_sleep(void)
+{
+	printk(KERN_INFO "hibernation debug: Waiting for 5 seconds.\n");
+	mdelay(5000);
+}
+
+static int hibernation_testmode(int mode)
+{
+	if (hibernation_mode =3D=3D mode) {
+		hibernation_debug_sleep();
+		return 1;
+	}
+	return 0;
+}
+
+static int hibernation_test(int level)
+{
+	if (pm_test_level =3D=3D level) {
+		hibernation_debug_sleep();
+		return 1;
+	}
+	return 0;
+}
+#else /* !CONFIG_PM_DEBUG */
+static int hibernation_testmode(int mode) { return 0; }
+static int hibernation_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
 /**
  *	platform_start - tell the platform driver that we're starting
  *	hibernation
@@ -167,6 +196,10 @@ int create_image(int platform_mode)
 		goto Enable_irqs;
 	}
=20
+	if (hibernation_test(TEST_CORE))
+		goto Power_up;
+
+	in_suspend =3D 1;
 	save_processor_state();
 	error =3D swsusp_arch_suspend();
 	if (error)
@@ -175,6 +208,7 @@ int create_image(int platform_mode)
 	restore_processor_state();
 	if (!in_suspend)
 		platform_leave(platform_mode);
+ Power_up:
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
@@ -211,24 +245,29 @@ int hibernation_snapshot(int platform_mode)
 	if (error)
 		goto Resume_console;
=20
-	error =3D platform_pre_snapshot(platform_mode);
-	if (error)
+	if (hibernation_test(TEST_DEVICES))
 		goto Resume_devices;
=20
+	error =3D platform_pre_snapshot(platform_mode);
+	if (error || hibernation_test(TEST_PLATFORM))
+		goto Finish;
+
 	error =3D disable_nonboot_cpus();
 	if (!error) {
-		if (hibernation_mode !=3D HIBERNATION_TEST) {
-			in_suspend =3D 1;
-			error =3D create_image(platform_mode);
-			/* Control returns here after successful restore */
-		} else {
-			printk("swsusp debug: Waiting for 5 seconds.\n");
-			mdelay(5000);
-		}
+		if (hibernation_test(TEST_CPUS))
+			goto Enable_cpus;
+
+		if (hibernation_testmode(HIBERNATION_TEST))
+			goto Enable_cpus;
+
+		error =3D create_image(platform_mode);
+		/* Control returns here after successful restore */
 	}
+ Enable_cpus:
 	enable_nonboot_cpus();
- Resume_devices:
+ Finish:
 	platform_finish(platform_mode);
+ Resume_devices:
 	device_resume();
  Resume_console:
 	resume_console();
@@ -406,11 +445,12 @@ int hibernate(void)
 	if (error)
 		goto Finish;
=20
-	if (hibernation_mode =3D=3D HIBERNATION_TESTPROC) {
-		printk("swsusp debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
+	if (hibernation_test(TEST_FREEZER))
 		goto Thaw;
-	}
+
+	if (hibernation_testmode(HIBERNATION_TESTPROC))
+		goto Thaw;
+
 	error =3D hibernation_snapshot(hibernation_mode =3D=3D HIBERNATION_PL=
ATFORM);
 	if (in_suspend && !error) {
 		unsigned int flags =3D 0;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 9f9e16e..f9f0d4d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -206,3 +206,5 @@ enum {
=20
 #define TEST_FIRST	TEST_NONE
 #define TEST_MAX	(__TEST_AFTER_LAST - 1)
+
+extern int pm_test_level;
--=20
1.5.4.rc5.16.gc0279

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
