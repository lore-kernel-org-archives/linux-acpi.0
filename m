From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [ACPI] acpi_bus_register_driver() returns -ENODEV after resume
Date: Tue, 2 Sep 2003 15:39:26 -0700 (PDT)
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0309021529410.1737-100000@localhost.localdomain>
References: <20030901222619.GC27945@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030901222619.GC27945-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> I've received some feedback about problems loading the asus_acpi driver
> back after swsusp resume. I managed to hit that problem on a 2.4.21 +
> 20030619 ACPI + swsusp1.1-rc2. I don't know yet if it is present in more
> recent versions, since this behaviour is not common (at least on my
> machine). Usually, the module can be loaded and unloaded without problems.
> 
> Anyway, judging on my quick glance at the code, it would seem that something
> disables acpi (i.e. sets acpi_disabled to a non-zero value) somewhere
> during the suspend / resume cycle, which in turn causes
> acpi_bus_register_driver to return -ENODEV. Is my reasoning correct, or am
> I missing some codepath? If not, it would signify a bug in ACPI / swsusp
> interaction. I'll try yet to hit this on a recent kernel.

It's obscure, but I think I know the answer. From arch/i386/kernel/setup.c: 

#ifdef  CONFIG_ACPI
        int acpi_disabled __initdata = 0;
#else
        int acpi_disabled __initdata = 1;
#endif
EXPORT_SYMBOL(acpi_disabled);


Since it's __initdata, the memory will be freed early in the init process 
(c.f. init/main.c::init() -> free_initmem()). Anything that uses it later 
is touching memory that is either unallocated, or allocated by something 
else. That's a bug. 

Also, it doesn't need to be EXPORTed. If it is left as initdata, that's
another bug, because the two are semantically disjoint. However, even with
the patch below, I'm not sure why you would want to expose the variable 
(and I've in fact removed that). 

Please give it a try and let me know if helps. 


Tangential question: Do preprocessor conditionals evaluate to a value? 
I.e. instead of doing: 

#ifdef	CONFIG_ACPI
	int acpi_disabled = 0;
#else
	int acpi_disabled = 1;
#endif

Could we do: 

int acpi_disabled = (CONFIG_ACPI == 'y'); 

..or something? 

Thanks,


	Pat

===== arch/i386/kernel/setup.c 1.95 vs edited =====
--- 1.95/arch/i386/kernel/setup.c	Sun Aug 31 16:14:11 2003
+++ edited/arch/i386/kernel/setup.c	Tue Sep  2 15:35:00 2003
@@ -64,11 +64,10 @@
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
 #ifdef	CONFIG_ACPI
-	int acpi_disabled __initdata = 0;
+	int acpi_disabled = 0;
 #else
-	int acpi_disabled __initdata = 1;
+	int acpi_disabled = 1;
 #endif
-EXPORT_SYMBOL(acpi_disabled);
 
 #ifdef	CONFIG_ACPI_BOOT
 	int acpi_irq __initdata = 1;	/* enable IRQ */



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
