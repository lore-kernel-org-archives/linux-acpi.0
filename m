From: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Patch - bug in adding/removing modules
Date: Sun, 15 Dec 2002 14:23:30 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFCD6B2.2050201@sympatico.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020401040002020908050108"
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
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020401040002020908050108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Although I was only looking at the battery module, I believe I have 
fixed a potential oops regarding inserting and removing modules.

The attached patch fixes a problem that I have seen, a quick look at 
other modules seems to have the same problem.

The description of the problem is ...

There is a macro called acpi_device_dir which returns a pointer to the a 
battery instance directory in /proc/acpi/battery.  When removing a 
module, the device is removed from the proc heirachy, but the entry in 
the device table is never set to null.  So consequently when the device 
is reinserted the add_fs call already sees the proc directory entry and 
consequently uses the /proc/acpi/battery and along the way corrupts some 
memory.

So the patch NULLs out the proc dir entry in the device structure in a 
manner symmetric with the creation and deletion of the proc directory.

Regards,

Matthew

-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
Technology Forum - http://www.technology-forum.org/
Commercial Open Source - http://www.commercialos.org/

--------------020401040002020908050108
Content-Type: text/plain;
 name="battery.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="battery.diff"

--- battery.c.orig	2002-12-15 14:14:51.000000000 -0500
+++ battery.c	2002-12-15 14:11:29.000000000 -0500
@@ -658,8 +658,10 @@
 {
 	ACPI_FUNCTION_TRACE("acpi_battery_remove_fs");
 
-	if (acpi_device_dir(device)) 
+	if (acpi_device_dir(device)) {
 		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
+		acpi_device_dir(device) = NULL;
+	}
 
 	return_VALUE(0);
 }

--------------020401040002020908050108--



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
