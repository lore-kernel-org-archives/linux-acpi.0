From: Philip Proudman <phil-5JapdU7xTchUkLafFIKz2byq0pUa53/3@public.gmane.org>
Subject: hp pavilion ze4355ea freezing fix
Date: 29 Aug 2003 22:35:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2he40cfk9.fsf@quicknet-software.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I found that my hp pavilion ze4355ea locked up the second that acpi is
used. After a day of searching, I found that the following bodge will
cure the problem (and acpi appears to work fine). Unfortunately I'm
not familiar with the ACPI code, so I'm unable provide you with a
"proper fix" - my solution feels like a major bodge

However, I'm sure someone can deduce a proper fix given the
following file change in the drivers/acpi/events directory, in
linux-2.4.22 ...

--- evregion.c.old	2003-08-25 12:44:41.000000000 +0100
+++ evregion.c	2003-08-29 21:59:36.000000000 +0100
@@ -317,20 +317,22 @@
 	/* We have everything we need, we can invoke the address space handler */
 
 	handler = handler_desc->address_space.handler;
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_OPREGION,
 		"Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
 		&region_obj->region.address_space->address_space, handler,
 		ACPI_HIDWORD (address), ACPI_LODWORD (address),
 		acpi_ut_get_region_name (region_obj->region.space_id)));
 
+        if (address==0x0fe00) 	return_ACPI_STATUS (status);      
+        
 	if (!(handler_desc->address_space.flags & ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
 		/*
 		 * For handlers other than the default (supplied) handlers, we must
 		 * exit the interpreter because the handler *might* block -- we don't
 		 * know what it will do, so we can't hold the lock on the intepreter.
 		 */
 		acpi_ex_exit_interpreter();
 	}
 
 	/* Call the handler */


A similar change also does the trick in a linux-2.6.0-test4 kernel

The handler call causes the lock-up in the stuation where
address==0x0fe00. I don't know what this number signifies.

Please contact me if you'd like me to try an alternative fix, or if I
can provide further diagnostic information.

Cheers


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
