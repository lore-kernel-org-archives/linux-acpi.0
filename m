From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: 2.5.50: echo > /proc/acpi/sleep b0rken
Date: Sat, 30 Nov 2002 20:49:34 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021130194934.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I believe this is needed, otherwise echo > /proc/acpi/sleep does not
work. I'm not 200% sure this is correct fix, through, and it
definitely needs to be fixed at *way* more places.
								Pavel

--- clean/drivers/acpi/sleep.c	2002-11-29 21:16:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/sleep.c	2002-11-30 00:27:14.000000000 +0100
@@ -674,7 +675,7 @@
 			ACPI_SYSTEM_FILE_SLEEP));
 	else {
 		entry->proc_fops = &acpi_system_sleep_fops;
-		entry->write_proc = acpi_system_write_sleep;
+		entry->proc_fops->write = acpi_system_write_sleep;
 	}
 
 	/* 'alarm' [R/W] */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
