From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Date: Sun, 6 Feb 2005 19:44:47 +0100
Message-ID: <20050206184447.GW3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

acpi_save_state_disk does nothing and is completely unused.

This patch was already ACK'ed by Pavel Machek.

Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>

---

This patch was already sent on:
- 16 Jan 2005

 arch/i386/kernel/acpi/sleep.c   |    9 ---------
 arch/x86_64/kernel/acpi/sleep.c |    9 ---------
 include/asm-i386/acpi.h         |    1 -
 include/asm-i386/suspend.h      |    1 -
 include/asm-x86_64/acpi.h       |    1 -
 include/asm-x86_64/suspend.h    |    1 -
 6 files changed, 22 deletions(-)

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/acpi.h.old	2005-01-16 04:25:17.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/acpi.h	2005-01-16 04:25:23.000000000 +0100
@@ -174,7 +174,6 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
--- linux-2.6.11-rc1-mm1-full/include/asm-i386/suspend.h.old	2005-01-16 04:25:31.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/suspend.h	2005-01-16 04:25:35.000000000 +0100
@@ -61,5 +61,4 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 #endif
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/acpi.h.old	2005-01-16 04:25:44.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/acpi.h	2005-01-16 04:25:48.000000000 +0100
@@ -153,7 +153,6 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/suspend.h.old	2005-01-16 04:25:56.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/suspend.h	2005-01-16 04:26:00.000000000 +0100
@@ -55,5 +55,4 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 #endif
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/acpi/sleep.c.old	2005-01-16 04:26:23.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/acpi/sleep.c	2005-01-16 04:26:30.000000000 +0100
@@ -47,15 +47,6 @@
 	return 0;
 }
 
-/**
- * acpi_save_state_disk - save kernel state to disk
- *
- */
-int acpi_save_state_disk (void)
-{
-	return 1;
-}
-
 /*
  * acpi_restore_state - undo effects of acpi_save_state_mem
  */
--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/acpi/sleep.c.old	2005-01-16 04:26:43.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/acpi/sleep.c	2005-01-16 04:26:50.000000000 +0100
@@ -87,15 +87,6 @@
 	return 0;
 }
 
-/**
- * acpi_save_state_disk - save kernel state to disk
- *
- */
-int acpi_save_state_disk (void)
-{
-	return 1;
-}
-
 /*
  * acpi_restore_state
  */



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
