From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: acpi_battery_read_info kernel Oops
Date: Sat, 22 Feb 2003 01:31:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302220131.57228.earny@net4u.de>
References: <200302110423.35001.earny@net4u.de>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9TsV+bZ6uOJeFx2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200302110423.35001.earny-euM3SP4ZHrg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_9TsV+bZ6uOJeFx2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Freitag, 21. Februar 2003 02:48, Grover, Andrew wrote:
> Hi Ernst,
>
> Could you see if this patch fixes the issue?

Yupp. Look like the 'serial number' was the problem.

lidl ~ # cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         54720 mWh
last full capacity:      47600 mWh
battery technology:      rechargeable
design voltage:          14400 mV
design capacity warning: 3808 mWh
design capacity low:     1428 mWh
capacity granularity 1:  238 mWh
capacity granularity 2:  238 mWh
model number:            PC-VP-WP22/OP-570-74001
serial number:
battery type:            Lion
OEM info:                NEC

<Earny>
--Boundary-00=_9TsV+bZ6uOJeFx2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="utcopy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="utcopy.diff"

===== drivers/acpi/utilities/utcopy.c 1.22 vs edited =====
--- 1.22/drivers/acpi/utilities/utcopy.c	Tue Feb 18 15:32:34 2003
+++ edited/drivers/acpi/utilities/utcopy.c	Thu Feb 20 17:44:54 2003
@@ -645,11 +645,11 @@
 
 		/*
 		 * Allocate and copy the actual buffer if and only if:
-		 * 1) There is a valid buffer (length > 0)
+		 * 1) There is a valid buffer pointer
 		 * 2) The buffer is not static (not in an ACPI table) (in this case,
 		 *    the actual pointer was already copied above)
 		 */
-		if ((source_desc->buffer.length) &&
+		if ((source_desc->buffer.pointer) &&
 			(!(source_desc->common.flags & AOPOBJ_STATIC_POINTER))) {
 			dest_desc->buffer.pointer = ACPI_MEM_ALLOCATE (source_desc->buffer.length);
 			if (!dest_desc->buffer.pointer) {
@@ -665,11 +665,11 @@
 
 		/*
 		 * Allocate and copy the actual string if and only if:
-		 * 1) There is a valid string (length > 0)
+		 * 1) There is a valid string pointer
 		 * 2) The string is not static (not in an ACPI table) (in this case,
 		 *    the actual pointer was already copied above)
 		 */
-		if ((source_desc->string.length) &&
+		if ((source_desc->string.pointer) &&
 			(!(source_desc->common.flags & AOPOBJ_STATIC_POINTER))) {
 			dest_desc->string.pointer = ACPI_MEM_ALLOCATE ((acpi_size) source_desc->string.length + 1);
 			if (!dest_desc->string.pointer) {

--Boundary-00=_9TsV+bZ6uOJeFx2--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
