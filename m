From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: save/restore sysdev - re:2.6.9 S4: clock not updated after resume
Date: Thu, 4 Nov 2004 15:08:04 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575796CEB@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>
>> The patch is useless. The sysdev suspend/resume isn't invoked by
swsusp,
>> as Bjorn has mentioned before.
>> =
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109753613422952&w=3D2
>
>This patch should add sysdev suspend/resume. Can you verify it helps
>for you?
Sorry for being so late to reply. Yes, the patch (after fix some
compiling error) works for me. But one comment is sysdev_resume/suspend
are designed to work with IRQ disabled.

Thanks,
Shaohua


>--- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
>+++ linux/kernel/power/disk.c	2004-10-29 11:57:26.000000000 +0200
>@@ -102,6 +116,7 @@
>
> static void finish(void)
> {
>+	sysdev_resume();
> 	device_resume();
> 	platform_finish();
> 	enable_nonboot_cpus();
>@@ -133,8 +148,12 @@
> 	free_some_memory();
>
> 	disable_nonboot_cpus();
>-	if ((error =3D device_suspend(PM_SUSPEND_DISK)))
>+	if ((error =3D device_suspend(PMSG_SUSPEND_DISK))) {
>+		printk("Some devices failed to suspend\n");
> 		goto Finish;
>+	}
>+
>+	sysdev_suspend(PMSG_SUSPEND_DISK);
>
> 	return 0;
>  Finish:
>--- clean/kernel/power/main.c	2004-10-01 00:30:32.000000000 +0200
>+++ linux/kernel/power/main.c	2004-10-29 11:56:59.000000000 +0200
>@@ -825,6 +812,7 @@
> int swsusp_write(void)
> {
> 	int error;
>+	sysdev_resume();
> 	device_resume();
> 	lock_swapdevices();
> 	error =3D write_suspend_image();
>
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
