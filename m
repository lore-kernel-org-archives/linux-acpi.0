From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Possible problem in acpi_remove_address_space_handler
Date: Wed, 09 Apr 2003 12:35:48 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304091635.h39GZmp06599@throb.netspace.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is there any reason why 	

acpi_ut_remove_reference (handler_obj); 

is called twice in a row in acpi_remove_address_space_handler
events/evxfregn.c line 400 or so?


If it's a typo, then I think I found the thing causing the
AC_BAD_PARAMETER problem on my Thinkpad R32.  Maybe someone already
found this.


Here's my patch:


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
"Operation Shoot First" is a complete success!!!
Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org 


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
