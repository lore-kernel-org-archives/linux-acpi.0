From: Felipe W Damasio <felipewd-y7mWNqJcIDpfJ/NunPodnw@public.gmane.org>
Subject: [PATCH] unneeded memory barrier
Date: Thu, 11 Sep 2003 17:31:41 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F60DBAD.3080502@terra.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080700000106000106080207"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mochel-3NddpPZAyC0@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700000106000106080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew/Patrick,

	Patch against 2.6-test5 to remove an, IMHO, unneeded memory barrier 
on acpi/bus.c. Feel free to tell me I'm totally wrong, though :)

	If it looks good, please consider applying.

	Cheers,

Felipe

--------------080700000106000106080207
Content-Type: text/plain;
 name="acpi-bus_state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-bus_state.patch"

--- linux-2.6.0-test5/drivers/acpi/bus.c.orig	2003-09-11 17:23:06.000000000 -0300
+++ linux-2.6.0-test5/drivers/acpi/bus.c	2003-09-11 17:23:14.000000000 -0300
@@ -333,7 +333,7 @@
 			schedule();
 
 		remove_wait_queue(&acpi_bus_event_queue, &wait);
-		set_current_state(TASK_RUNNING);
+		__set_current_state(TASK_RUNNING);
 
 		if (signal_pending(current))
 			return_VALUE(-ERESTARTSYS);

--------------080700000106000106080207--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
