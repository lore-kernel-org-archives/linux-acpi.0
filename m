From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: ACPI_SLEEP without swsusp: fix compile failure
Date: Sat, 23 Nov 2002 21:35:16 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021123203515.GA8261@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Disallow combination that does not work... Please apply, 
								Pavel
PS: As a side note, it seems ACPI options are not indented in make
oldconfig...

--- clean/arch/i386/Kconfig	2002-11-23 19:55:14.000000000 +0100
+++ linux-swsusp/arch/i386/Kconfig	2002-11-23 21:18:22.000000000 +0100
@@ -789,8 +789,6 @@
 
 menu "Power management options (ACPI, APM)"
 
-source "drivers/acpi/Kconfig"
-
 config PM
 	bool "Power Management support"
 	---help---
@@ -811,6 +809,37 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM
+	---help---
+	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit needed). 
+
+	  It creates an image which is saved in your active swaps. By the next
+	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  detect the saved image, restore the memory from
+	  it and then it continues to run as before you've suspended.
+	  If you don't want the previous state to continue use the 'noresume'
+	  kernel option. However note that your partitions will be fsck'd and
+	  you must re-mkswap your swap partitions/files.
+
+	  Right now you may boot without resuming and then later resume but
+	  in meantime you cannot use those swap partitions/files which were
+	  involved in suspending. Also in this case there is a risk that buffers
+	  on disk won't match with saved ones.
+
+	  SMP is supported ``as-is''. There's a code for it but doesn't work.
+	  There have been problems reported relating SCSI.
+
+	  This option is about getting stable. However there is still some
+	  absence of features.
+
+	  For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -1516,35 +1545,6 @@
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
--- clean/drivers/acpi/Kconfig	2002-11-01 00:37:09.000000000 +0100
+++ linux-swsusp/drivers/acpi/Kconfig	2002-11-23 21:16:32.000000000 +0100
@@ -58,8 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
-	default SOFTWARE_SUSPEND
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
