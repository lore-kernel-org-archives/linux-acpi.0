From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Re: IBM Thinkpad R32 and ACPI
Date: Sat, 12 Apr 2003 14:12:06 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304121812.h3CIC6g18608@throb.netspace.org>
References: <20030412173357.1e4ea127.linux.wali@gmx.de>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Sat, 12 Apr 2003 17:33:57 +0200."
             <20030412173357.1e4ea127.linux.wali-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This problem is supposed to be fixed in the next release(see the archives).

The problem was solved for me (on my R32) by going to 
drivers/acpi/events/evxfregn.c
and removing one of the 

acpi_ut_remove_reference (handler_obj);

lines (there are two). 
This might also help other Thinkpad users who have similar problems.


Let me know how it goes.  Sleep functionality seems pretty broken at
the moment.

 Here's a patch, if you prefer.

diff -u -r1.1.1.1 evxfregn.c
--- linux-2.5.66/drivers/acpi/events/evxfregn.c	2 Apr 2003 03:34:04 -0000	1.1.1.1
+++ linux-2.5.66/drivers/acpi/events/evxfregn.c	9 Apr 2003 16:18:25 -0000
@@ -391,7 +391,7 @@
 			/*
 			 * Now we can delete the handler object
 			 */
-			acpi_ut_remove_reference (handler_obj);
+
 			acpi_ut_remove_reference (handler_obj);
 
 			goto unlock_and_exit;




--
Brian Perkins                                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
