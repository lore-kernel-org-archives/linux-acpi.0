From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Snore: BUG in ide-disk on suspend
Date: Wed, 15 Jan 2003 22:34:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301152234.26117.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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
Cc: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I don't feel I am the one that should mess with the ide part (I could break a 
lot of important things). However, sleeping has failed many times because of 
ide. 

drivers/ide/ide-disk.c: (around 1557)
        printk(KERN_INFO "suspending: %s ", drive->name);
        do_idedisk_standby(drive);
        drive->blocked = 1;

	BUG_ON (HWGROUP(drive)->handler);

AFAIK handler is set whenever an irq is being handled (correct me if I'm 
wrong). ide irqs are very often on the system and may happen between the 
actual call to 'ide_do_cmd' (called by do_idedisk_standby) and the 
"blocked=1" line. 
Setting a strict lock may deadlock the system pretty hard! Would the 
"blocked=1" line break the do_idedisk_standby? Does "blocked" really stop 
subsequent disk activity?
Or, alternatively should we setup a mechanism (spinlock?) to cause the 
do_ide_standby to wait until pending requests-data finishes?

Kernels: 2.5.55-58
ACPI: the one in those. Currently: 20030109
System: HP Omnibook Xe3 GC, Disk: IBM DeskStar in 32bit mode.

Thanks.




-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
