From: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [2.5.50, ACPI] link error
Date: Wed, 4 Dec 2002 14:50:24 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021204135024.GA2544@fs.tum.de>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <20021204114114.GD309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021204114114.GD309-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Jochen Hein <jochen-9GTqNSKHDthGYNTIZbNFlg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Zippel <zippel-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 04, 2002 at 12:41:19PM +0100, Pavel Machek wrote:

> Hi!

Hi Pavel!

> > When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
> 
> Enable SWSUSP... Then investigate why it is possible to select
> ACPI_SLEEP but not SWSUSP...

In drivers/acpi/Config.in in 2.5.44:

<--   snip  -->

...
if [ "$CONFIG_ACPI_HT_ONLY" != "y" ]; then
   bool     '  Sleep States' CONFIG_ACPI_SLEEP
...
   define_bool CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
...
fi
...

<--  snip  -->


This double definition was at least confusing, a simple

  dep_bool '  Sleep States' CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND

would have expressed it better.


The transition to the new kconfig converted this confusing Config.in 
snipped to the following code in drivers/acpi/Kconfig:

<--  snip  -->

...
config ACPI_SLEEP
        bool "Sleep States"
        depends on X86 && ACPI && !ACPI_HT_ONLY
        default SOFTWARE_SUSPEND
...

<--  snip  -->


The following patch makes it work the way it was intended:

--- linux-2.5.50/drivers/acpi/Kconfig.old	2002-12-04 14:24:14.000000000 +0100
+++ linux-2.5.50/drivers/acpi/Kconfig	2002-12-04 14:27:17.000000000 +0100
@@ -58,7 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	default SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 


Another thing that seems to be suboptimal is that the question for 
SOFTWARE_SUSPEND comes _after_ the question for ACPI_SLEEP, IOW someone 
doing a "make config" to configure his kernel doesn't have a chance to 
select ACPI_SLEEP. To fix this (and it seems to be logical) the 
SOFTWARE_SUSPEND question should be moved to the "Power management 
options" menu. The patch below tries to solve this and it makes ACPI 
dependant on PM as the comments in PM indicate:
- move "Software Suspend" to the "Power management options" menu above
  the ACPI entry
- let ACPI depend on PM

Any comments on this patch?

> 							Pavel

cu
Adrian


--- linux-2.5.50/arch/i386/Kconfig.old	2002-12-04 14:47:03.000000000 +0100
+++ linux-2.5.50/arch/i386/Kconfig	2002-12-04 14:43:48.000000000 +0100
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
+        bool "Software Suspend (EXPERIMENTAL)"
+        depends on EXPERIMENTAL && PM
+        ---help---
+          Enable the possibilty of suspendig machine. It doesn't need APM.
+          You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
+          (patch for sysvinit needed).
+
+          It creates an image which is saved in your active swaps. By the next
+          booting the, pass 'resume=/path/to/your/swap/file' and kernel will
+          detect the saved image, restore the memory from
+          it and then it continues to run as before you've suspended.
+          If you don't want the previous state to continue use the 'noresume'
+          kernel option. However note that your partitions will be fsck'd and
+          you must re-mkswap your swap partitions/files.
+
+          Right now you may boot without resuming and then later resume but
+          in meantime you cannot use those swap partitions/files which were
+          involved in suspending. Also in this case there is a risk that buffers
+          on disk won't match with saved ones.
+
+          SMP is supported ``as-is''. There's a code for it but doesn't work.
+          There have been problems reported relating SCSI.
+
+          This option is about getting stable. However there is still some
+          absence of features.
+
+          For more information take a look at Documentation/swsusp.txt.
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
--- linux-2.5.50/drivers/acpi/Kconfig.old	2002-12-04 14:39:24.000000000 +0100
+++ linux-2.5.50/drivers/acpi/Kconfig	2002-12-04 14:42:57.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 menu "ACPI Support"
+	depends on PM
 
 config ACPI
 	bool "ACPI Support" if X86
