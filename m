From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RFC 1/4: introduce new system state
Date: Wed, 19 Jan 2005 11:17:07 +0800
Message-ID: <1106104623.12957.272.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
Introduce a new system state to shadow 'might_sleep' complain, just like
the boot time.
Pavel & Nigel, is this ok for S4?

Thanks,
Shaohua 

---

 2.5-root/include/linux/kernel.h |    1 +
 2.5-root/kernel/power/main.c    |    8 ++++++++
 2 files changed, 9 insertions(+)

diff -puN include/linux/kernel.h~introduce_suspend_system_state include/linux/kernel.h
--- 2.5/include/linux/kernel.h~introduce_suspend_system_state	2005-01-10 16:54:51.000000000 +0800
+++ 2.5-root/include/linux/kernel.h	2005-01-10 16:55:22.000000000 +0800
@@ -146,6 +146,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_SUSPEND,
 } system_state;
 
 #define TAINT_PROPRIETARY_MODULE	(1<<0)
diff -puN kernel/power/main.c~introduce_suspend_system_state kernel/power/main.c
--- 2.5/kernel/power/main.c~introduce_suspend_system_state	2005-01-10 16:56:23.000000000 +0800
+++ 2.5-root/kernel/power/main.c	2005-01-18 11:02:15.983730440 +0800
@@ -60,6 +60,10 @@ static int suspend_prepare(suspend_state
 		goto Thaw;
 	}
 
+	/* This should be done after processes frozen and other CPUs are died */
+	system_state = SYSTEM_SUSPEND;
+	smp_wmb();
+
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
@@ -72,6 +76,8 @@ static int suspend_prepare(suspend_state
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
+	system_state = SYSTEM_RUNNING;
+	smp_wmb();
 	thaw_processes();
 	pm_restore_console();
 	return error;
@@ -107,6 +113,8 @@ static void suspend_finish(suspend_state
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
+	system_state = SYSTEM_RUNNING;
+	smp_wmb();
 	thaw_processes();
 	pm_restore_console();
 }
_




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
