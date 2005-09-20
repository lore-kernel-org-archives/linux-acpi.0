From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Tue, 20 Sep 2005 11:49:24 -0600
Message-ID: <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
	<m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m14q8fhc02.fsf_-_-T1Yj925okcoyDheHMi7gv2pdwda3JcWeAL8bYrjMMd8@public.gmane.org> (Eric W.
 Biederman's message of "Tue, 20 Sep 2005 11:42:21 -0600")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Masoud Sharbiani <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


In the lead up to 2.6.13 I fixed a large number of reboot
problems by making the calling conventions consistent.  Despite
checking and double checking my work it appears I missed an
obvious one.

The S4 suspend code for PM_DISK_PLATFORM was also calling
device_shutdown without setting system_state, and was
not calling the appropriate reboot_notifier.

This patch fixes the bug by replacing the call of device_suspend with
kernel_poweroff_prepare.  

Various forms of this failure have been fixed and tracked for a while.

Thanks for tracking this down go to: Alexey Starikovskiy,
Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>,
Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>

History of this bug is at:
http://bugme.osdl.org/show_bug.cgi?id=4320

Signed-off-by: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>


---

 kernel/power/disk.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

2c72ba7b1126a7ccf3e8fc032f041a223e39aa97
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -17,12 +17,12 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pm.h>
 
 #include "power.h"
 
 
 extern suspend_disk_method_t pm_disk_mode;
-extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
@@ -49,13 +49,11 @@ dev_t swsusp_resume_device;
 
 static void power_down(suspend_disk_method_t mode)
 {
-	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
+		kernel_power_off_prepare();
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
