From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: acpi_bus_register_driver() returns -ENODEV after resume
Date: Tue, 9 Sep 2003 00:07:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030908220722.GA24304@hell.org.pl>
References: <20030901222619.GC27945@hell.org.pl> <Pine.LNX.4.33.0309021529410.1737-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309021529410.1737-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Patrick Mochel:
> Since it's __initdata, the memory will be freed early in the init process 
> (c.f. init/main.c::init() -> free_initmem()). Anything that uses it later 
> is touching memory that is either unallocated, or allocated by something 
> else. That's a bug. 
> 
> Also, it doesn't need to be EXPORTed. If it is left as initdata, that's
> another bug, because the two are semantically disjoint. However, even with
> the patch below, I'm not sure why you would want to expose the variable 
> (and I've in fact removed that). 
> 
> Please give it a try and let me know if helps. 

In short: 2.4.23-pre3 vanilla: problem present
	  2.4.23-pre3 with __initdata and EXPRT_SYMBOL removed: compiles
	  fine, the problem seems to have disappeared.

The patch you made is OK for 2.6, I inline one for 2.4 (the same except for
the top line)

--- linux-2.4.23-pre3/arch/i386/kernel/setup.c~ 2003-09-04 15:21:03.000000000 +0200
+++ linux-2.4.23-pre3/arch/i386/kernel/setup.c  2003-09-08 23:56:00.000000000 +0200
@@ -176,11 +176,10 @@
 static u32 disabled_x86_caps[NCAPINTS] __initdata = { 0 };

 #ifdef CONFIG_ACPI_INTERPRETER
-       int acpi_disabled __initdata = 0;
+       int acpi_disabled = 0;
 #else
-       int acpi_disabled __initdata = 1;
+       int acpi_disabled = 1;
 #endif
-EXPORT_SYMBOL(acpi_disabled);

 #ifdef CONFIG_ACPI_BOOT
        int acpi_ht __initdata = 1;     /* enable HT */


Thanks for help, best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
