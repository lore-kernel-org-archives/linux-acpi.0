From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Subject: [Patch] keep ide disk sleeping when resuming
Date: Wed, 2 Feb 2005 20:47:31 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502022006030.4130@gaston.free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, axboe-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, B.Zolnierkiewicz-ZGDBLhmm9VR4rM3dGMyr8Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I need this patch (against linux-2.6.11-rc2), to keep ide disk sleeping,
when resuming from ACPI S1.

In fact, it's just removing a patch from 22 Jun 2004 by Jens Axboe. He has
told me, that "We can probably kill the patch completely".
So, this is what I'm doing now.

Kind regards, Peter

--- drivers/ide/ide-disk.c.orig	2005-02-02 20:30:12.000000000 +0100
+++ drivers/ide/ide-disk.c	2005-02-02 20:32:21.000000000 +0100
@@ -864,9 +864,7 @@
 enum {
 	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
 	idedisk_pm_standby,
-
-	idedisk_pm_idle		= ide_pm_state_start_resume,
-	idedisk_pm_restore_dma,
+	idedisk_pm_restore_dma	= ide_pm_state_start_resume
 };
 
 static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
@@ -881,9 +879,6 @@
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
 		rq->pm->pm_step = ide_pm_state_completed;
 		break;
-	case idedisk_pm_idle:		/* Resume step 1 (idle) complete */
-		rq->pm->pm_step = idedisk_pm_restore_dma;
-		break;
 	}
 }
 
@@ -914,12 +909,6 @@
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
-	case idedisk_pm_idle:		/* Resume step 1 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
-		return do_rw_taskfile(drive, args);
-
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
 		/*
 		 * Right now, all we do is call hwif->ide_dma_check(drive),

-- 
http://pmrb.free.fr/contact/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
