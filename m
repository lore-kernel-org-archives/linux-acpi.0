From: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Subject: Re: [BK PATCH] ACPI update
Date: Thu, 24 Apr 2003 10:59:56 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030424.105956.26284967.kochi@hpc.bs1.fc.nec.co.jp>
References: <F760B14C9561B941B89469F59BA3A847E96E0A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96E0A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Though I already reported to Bob, it seems that the latest
update doesn't contain the changes below.
It fixes a problem on power down/entering sleep states
for some platforms.
The problem was caused by writing to wrong I/O ports.

This patch is generated from 2.4.21pre6 + 030328, but should
apply to both 2.4 & 2.5.

--- linux-2.4.20/drivers/acpi/hardware/hwgpe.c.orig	Thu Apr 24 09:40:57 2003
+++ linux-2.4.20/drivers/acpi/hardware/hwgpe.c	Thu Apr 24 09:42:22 2003
@@ -360,7 +360,7 @@
 
 	for (i = 0; i < gpe_block->register_count; i++) {
 		status = acpi_hw_low_level_write (8, 0x00,
-				 &gpe_block->register_info[i].enable_address, (u32) i);
+				 &gpe_block->register_info[i].enable_address, (u32) 0);
 		if (ACPI_FAILURE (status)) {
 			return (status);
 		}
@@ -401,7 +401,7 @@
 
 	for (i = 0; i < gpe_block->register_count; i++) {
 		status = acpi_hw_low_level_write (8, 0xFF,
-				 &gpe_block->register_info[i].status_address, (u32) i);
+				 &gpe_block->register_info[i].status_address, (u32) 0);
 		if (ACPI_FAILURE (status)) {
 			return (status);
 		}


Thanks,
---
Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
