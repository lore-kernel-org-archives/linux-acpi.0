From: Gunnar Ritter <Gunnar.Ritter-UTEXKpdpFrK0ugseAHOM+TeJuz7u0hKX@public.gmane.org>
Subject: patch: Asus CUSL2-C/processor/2.4.22
Date: Mon, 25 Aug 2003 23:57:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F4A8662.nail8S178UX7@pluto.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="M8R231V76T-=-3KNH93JC2K-CUT-HERE-1WALL1RTL9-=-K42SGQ64KB"
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

--M8R231V76T-=-3KNH93JC2K-CUT-HERE-1WALL1RTL9-=-K42SGQ64KB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

when I installed 2.4.22 this day on my Asus CUSL2-C mainboard
(ASUS CUSL2-C ACPI BIOS Revision 1009, 08/03/2001-I815EP-CUSL2-C),
processor management did not work and produced the message

acpi_processor-2116 [26] acpi_processor_get_inf: Invalid PBLK length [5]

Since there were no problems with 2.4.21 and before, I made a small
change to the code (see the attachment). Processor power management
and throttling seem to work perfectly with this patch.

While looking around, I noticed the string '"COMAPQ", "EAGLES"' in
line 74 of blacklist.c, looks like a typo.

	Gunnar

--M8R231V76T-=-3KNH93JC2K-CUT-HERE-1WALL1RTL9-=-K42SGQ64KB
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="processor.c.diff"

--- processor.c.orig	Mon Aug 25 23:36:01 2003
+++ processor.c	Mon Aug 25 23:36:59 2003
@@ -2112,7 +2112,7 @@
 
 	if (!object.processor.pblk_address)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
-	else if (object.processor.pblk_length != 6)
+	else if (object.processor.pblk_length < 5)
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
 			object.processor.pblk_length));
 	else {
@@ -2121,8 +2121,9 @@
 		pr->throttling.duty_width = acpi_fadt.duty_width;
 		pr->power.states[ACPI_STATE_C2].address =
 			object.processor.pblk_address + 4;
-		pr->power.states[ACPI_STATE_C3].address =
-			object.processor.pblk_address + 5;
+		if (object.processor.pblk_length >= 6)
+			pr->power.states[ACPI_STATE_C3].address =
+				object.processor.pblk_address + 5;
 	}
 
 	acpi_processor_get_power_info(pr);

--M8R231V76T-=-3KNH93JC2K-CUT-HERE-1WALL1RTL9-=-K42SGQ64KB--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
