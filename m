From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: save/restore sysdev - re:2.6.9 S4: clock not updated after resume
Date: Tue, 16 Nov 2004 13:26:48 +0100
Message-ID: <20041116122648.GB1013@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575796CEB@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575796CEB-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

> >> The patch is useless. The sysdev suspend/resume isn't invoked by
> swsusp,
> >> as Bjorn has mentioned before.
> >> http://marc.theaimsgroup.com/?l=linux-kernel&m=109753613422952&w=2
> >
> >This patch should add sysdev suspend/resume. Can you verify it helps
> >for you?
> Sorry for being so late to reply. Yes, the patch (after fix some
> compiling error) works for me. But one comment is sysdev_resume/suspend
> are designed to work with IRQ disabled.

Hmm, yes, you are right. Can you test this replacement? [And possibly
forward it to andrew, it is hard for me to maintain it since my tree
diverged a lot].
								Pavel

--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-11-16 13:14:49.000000000 +0100
@@ -854,11 +840,13 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	sysdev_suspend(PMSG_FREEZE);
 	save_processor_state();
 	error = swsusp_arch_suspend();
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	restore_highmem();
+	sysdev_resume();
 	local_irq_enable();
 	return error;
 }
@@ -878,6 +866,7 @@
 {
 	int error;
 	local_irq_disable();
+	sysdev_suspend(PMSG_FREEZE);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -887,6 +876,7 @@
 	BUG_ON(!error);
 	restore_processor_state();
 	restore_highmem();
+	sysdev_resume();
 	local_irq_enable();
 	return error;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
