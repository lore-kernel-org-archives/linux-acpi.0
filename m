From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi proc: simplify error handling
Date: Fri, 10 Sep 2004 10:59:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040910085949.GA14198@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This simplifies error handling in acpi/sleep/proc.c. Please apply,

								Pavel

--- clean-mm/drivers/acpi/sleep/proc.c	2004-08-24 09:03:14.000000000 +0200
+++ linux-mm/drivers/acpi/sleep/proc.c	2004-09-07 21:15:19.000000000 +0200
@@ -57,7 +57,8 @@
 	int	error = 0;
 
 	if (count > sizeof(str) - 1)
-		goto Done;
+		return -EIO;
+
 	memset(str,0,sizeof(str));
 	if (copy_from_user(str, buffer, count))
 		return -EFAULT;
@@ -65,17 +66,16 @@
 	/* Check for S4 bios request */
 	if (!strcmp(str,"4b")) {
 		error = acpi_suspend(4);
-		goto Done;
+		return error ? error : count;
 	}
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		software_suspend();
-		goto Done;
+		error = software_suspend();
+		return error ? error : count;
 	}
 #endif
 	error = acpi_suspend(state);
- Done:
 	return error ? error : count;
 }
 


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
