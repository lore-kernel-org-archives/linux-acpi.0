From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: [PATCH] [1/2 DSDT via initrd or initramfs] move initramfs init before
 DSDT init
Date: Sun, 27 Feb 2005 20:45:35 +0100
Message-ID: <4222235F.3070105@renninger.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060208030605000905000502"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, eric-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060208030605000905000502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch from Hannes Reinecke (hare-l3A5Bk7waGM@public.gmane.org) moves initialisation of 
initramfs by some lines before the DSDT is parsed.

     Thomas

-> linux-2.6.11-rc5

--------------060208030605000905000502
Content-Type: text/x-patch;
 name="initramfs-before-acpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initramfs-before-acpi.patch"

Subject: Call populate_rootfs() prior to acpi_early_init()
From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

populate_rootfs should be called prior to acpi_early_init()
if we ever want to be able to use a custom DSDT from initramfs.
Having done this, rootfs is available during acpi_early_init()
and the ACPI code can just call sys_open() to load a custom
DSDT.

--- x/init/main.c.orig	2005-02-24 17:39:55.000000000 +0100
+++ y/init/main.c	2005-02-26 16:46:30.278718350 +0100
@@ -508,8 +508,6 @@
 #endif
 	check_bugs();
 
-	acpi_early_init(); /* before LAPIC and SMP init */
-
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
@@ -635,6 +633,14 @@
 	 */
 	child_reaper = current;
 
+	/*
+	 * Do this before initcalls, because some drivers want to access
+	 * firmware files.
+	 */
+	populate_rootfs();
+
+	acpi_early_init(); /* before LAPIC and SMP init */
+
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
 
@@ -644,12 +650,6 @@
 	smp_init();
 	sched_init_smp();
 
-	/*
-	 * Do this before initcalls, because some drivers want to access
-	 * firmware files.
-	 */
-	populate_rootfs();
-
 	do_basic_setup();
 
 	/*

--------------060208030605000905000502--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
