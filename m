From: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Subject: Re: ACPI patches updated (20030228)
Date: Wed, 05 Mar 2003 17:35:36 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030305.173536.74749671.kochi@hpc.bs1.fc.nec.co.jp>
References: <F760B14C9561B941B89469F59BA3A84725A1BB@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Mar__5_17:35:36_2003_697)--"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1BB-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
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

----Next_Part(Wed_Mar__5_17:35:36_2003_697)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Andy,

> 2) ACPI CA Core Subsystem:
> 
> The GPE handling and dispatch code has been completely overhauled
> in preparation for support of GPE Block Devices (ID ACPI0006).
> This affects internal data structures and code only; there should
> be no differences visible externally.  One new file has been
> added, evgpeblk.c

I found a bug in evgpeblk.c.  If an ACPI hardware has non-zero
based GPE block, sometimes it's ignored.  This patch fixes the
problem.

Also, ACPI_MODULE_NAME should be evgpeblk, not evgpe :)

Thanks,
---
Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>

----Next_Part(Wed_Mar__5_17:35:36_2003_697)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="evgpeblk.diff"

--- 2421-pre4-acpi/drivers/acpi/events/evgpeblk.c.orig	Wed Mar  5 17:00:15 2003
+++ 2421-pre4-acpi/drivers/acpi/events/evgpeblk.c	Wed Mar  5 17:01:30 2003
@@ -46,7 +46,7 @@
 #include <acpi/acnamesp.h>
 
 #define _COMPONENT          ACPI_EVENTS
-	 ACPI_MODULE_NAME    ("evgpe")
+	 ACPI_MODULE_NAME    ("evgpeblk")
 
 
 /*******************************************************************************
@@ -131,7 +131,7 @@
 	/* Ensure that we have a valid GPE number for this GPE block */
 
 	if ((gpe_number < gpe_block->block_base_number) ||
-		(gpe_number >= (gpe_block->register_count * 8))) {
+		(gpe_number - gpe_block->block_base_number >= (gpe_block->register_count * 8))) {
 		/* Not valid, all we can do here is ignore it */
 
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,

----Next_Part(Wed_Mar__5_17:35:36_2003_697)----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
