From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH]incorrectly open IRQ resuming time
Date: Wed, 22 Sep 2004 18:36:39 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095849399.11372.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zF+LrmOM4XcA4msuM/ol"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-zF+LrmOM4XcA4msuM/ol
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi
The resume code of time.c incorrectly open IRQ in resuming time. After
apply the patch, ACPI pci link resume code will report a call trace.
It's normal, since the link device resume is known broken, Please
temporarily revert it. 

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
===== arch/i386/kernel/time.c 1.50 vs edited =====
--- 1.50/arch/i386/kernel/time.c	2004-09-10 11:13:50 +08:00
+++ edited/arch/i386/kernel/time.c	2004-09-22 18:25:28 +08:00
@@ -333,11 +333,12 @@ static int time_suspend(struct sys_devic
 
 static int time_resume(struct sys_device *dev)
 {
+	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
 


--=-zF+LrmOM4XcA4msuM/ol
Content-Disposition: attachment; filename=time-irq.patch
Content-Type: text/x-patch; name=time-irq.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/time.c 1.50 vs edited =====
--- 1.50/arch/i386/kernel/time.c	2004-09-10 11:13:50 +08:00
+++ edited/arch/i386/kernel/time.c	2004-09-22 18:25:28 +08:00
@@ -333,11 +333,12 @@ static int time_suspend(struct sys_devic
 
 static int time_resume(struct sys_device *dev)
 {
+	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
 

--=-zF+LrmOM4XcA4msuM/ol--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
