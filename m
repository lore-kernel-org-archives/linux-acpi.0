From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re: [PATCH] Restore SYSENTER setup on swsusp resume.
Date: Fri, 14 Feb 2003 13:44:45 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302141343430.1067-100000@localhost.localdomain>
References: <1045250528.22719.173.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1045250528.22719.173.camel-U6vq7BvGKfF5pKCnmE3YQOkCa/Q774e0VpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 14 Feb 2003, David Woodhouse wrote:

> On Fri, 2003-02-14 at 18:36, Linus Torvalds wrote:
> > This should have _nothing_ to do with ACPI. Looks like it should be in 
> > arch/i386/kernel/suspend.c, restore_processor_state(), at which point it 
> > should be done correctly regardless of whether the sleep was ACPI-induced 
> > or done without any ACPI stuff at all.
> 
> Oops, sorry. Having complained so much about how ACPI code goes off and
> assumes all the world is ACPI, I hadn't noticed that the suspend code is
> actually much saner and acknowledges the possibility that we could shut
> the box down some other way. I was wondering where the rest of the setup
> was :)
> 
> Try this one instead. If I fix the UP build of
> arch/i386/kernel/acpi/boot.c and make drivers/acpi/sleep/proc.c actually
> get built, this works...

All my fault, I'm sorry. 

The following patches should fix those last two issues - compiling boot.c 
for UP and compiling proc.c by default.

	-pat

===== arch/i386/kernel/acpi/boot.c 1.21 vs edited =====
--- 1.21/arch/i386/kernel/acpi/boot.c	Thu Feb 13 11:51:14 2003
+++ edited/arch/i386/kernel/acpi/boot.c	Fri Feb 14 13:42:35 2003
@@ -26,9 +26,13 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <asm/pgalloc.h>
+#include <asm/apic.h>
+#include <asm/mpspec.h>
 
+#if defined (CONFIG_X86_LOCAL_APIC)
 #include <mach_apic.h>
 #include <mach_mpparse.h>
+#endif
 
 #define PREFIX			"ACPI: "
 
===== drivers/acpi/Kconfig 1.5 vs edited =====
--- 1.5/drivers/acpi/Kconfig	Thu Feb 13 21:18:32 2003
+++ edited/drivers/acpi/Kconfig	Fri Feb 14 13:30:05 2003
@@ -76,7 +76,9 @@
 	  power management development.
 
 config ACPI_SLEEP_PROC_FS
+	bool
 	depends on ACPI_SLEEP && PROC_FS
+	default y
 
 config ACPI_AC
 	tristate "AC Adapter"



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
