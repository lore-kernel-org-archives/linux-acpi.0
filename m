From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: save/restore sysdev - re:2.6.9 S4: clock not updated after resume
Date: Fri, 29 Oct 2004 12:18:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041029101857.GA1007@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057563CCE1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057563CCE1-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> The patch is useless. The sysdev suspend/resume isn't invoked by swsusp,
> as Bjorn has mentioned before.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109753613422952&w=2

This patch should add sysdev suspend/resume. Can you verify it helps
for you?

								Pavel

--- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/disk.c	2004-10-29 11:57:26.000000000 +0200
@@ -102,6 +116,7 @@
 
 static void finish(void)
 {
+	sysdev_resume();
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
@@ -133,8 +148,12 @@
 	free_some_memory();
 
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PM_SUSPEND_DISK)))
+	if ((error = device_suspend(PMSG_SUSPEND_DISK))) {
+		printk("Some devices failed to suspend\n");
 		goto Finish;
+	}
+
+	sysdev_suspend(PMSG_SUSPEND_DISK);
 
 	return 0;
  Finish:
--- clean/kernel/power/main.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/main.c	2004-10-29 11:56:59.000000000 +0200
@@ -825,6 +812,7 @@
 int swsusp_write(void)
 {
 	int error;
+	sysdev_resume();
 	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
