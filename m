From: Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Subject: evgpeblk.c fix for multiple gpe blocks
Date: Wed, 12 Mar 2003 02:39:06 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030312073906.GA29559@dao.cs.ohiou.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

the attached is a trial fix for machines with multiple gpe blocks.

--ltong

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="evgpeblk.c.diff"

--- a/drivers/acpi/events/evgpeblk.c	2003-03-04 22:29:19.000000000 -0500
+++ b/drivers/acpi/events/evgpeblk.c	2003-03-12 02:07:43.000000000 -0500
@@ -131,7 +131,8 @@
 	/* Ensure that we have a valid GPE number for this GPE block */
 
 	if ((gpe_number < gpe_block->block_base_number) ||
-		(gpe_number >= (gpe_block->register_count * 8))) {
+		(gpe_number >= (gpe_block->block_base_number +
+		gpe_block->register_count * 8))) {
 		/* Not valid, all we can do here is ignore it */
 
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,

--jI8keyz6grp/JLjh--


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
