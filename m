From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: AE_AML_BUFFER_LIMIT problem in 20030619 ...
Date: Fri, 27 Jun 2003 11:06:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306271106.01487.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi!

20030522 as working ok (excepto oops-es entering S5) ;-) ....

But in 20030619 i get this:

ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
dsopcode-0515 [20] ds_init_buffer_field  : Field size 1184 exceeds Buffer size 1088 (bits)
 psparse-1121: *** Error: Method execution failed [\_SB_.C005.C00B] (Node c12d3f88), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C005.C00F] (Node c12d2148), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C005._CRS] (Node c12d2248), AE_AML_BUFFER_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.C005._CRS] (Node c12d2248), AE_AML_BUFFER_LIMIT
ACPI: PCI Root Bridge [C005] (00:00)


What changed related to buffer lenght i don't know ... I tried to compare 20030522 & 20030619, but nothing
obvious (related to this) has changed.

I can get rid of this messages with attached patch, but i'm shure that, eventualy, someone else will hit same problem/bug.
In this patch, i'm simply adding extra 50 bytes to EVERY BUFFER ALLOCATED ... obviously, this isn't wery good as permanent
solution ...

Can this have something to do with "nibble" bytes definitions?

Any ideas?

Hrvoje


p.s. http://free-zg.htnet.hr/HrvojeHabjanic/acpi/Compaq_Armada_M700 for more info

--- linux-2.4.21-habi/drivers/acpi/dispatcher/dsobject.c	2003-06-24 15:21:04.000000000 +0200
+++ linux-2.4.21.20030619/drivers/acpi/dispatcher/dsobject.c	2003-06-25 20:18:58.000000000 +0200
@@ -208,6 +208,7 @@
 			"Buffer defined with zero length in AML, creating\n"));
 	}
 	else {
+		obj_desc->buffer.length += 50;
 		obj_desc->buffer.pointer = ACPI_MEM_CALLOCATE (
 				   obj_desc->buffer.length);
 		if (!obj_desc->buffer.pointer) {



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
