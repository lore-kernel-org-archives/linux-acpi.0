From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [ACPI] acpi_bus_register_driver() returns -ENODEV after resume
Date: Wed, 3 Sep 2003 01:22:08 +0200
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030902232208.GA17674@hell.org.pl>
References: <20030901222619.GC27945@hell.org.pl> <Pine.LNX.4.33.0309021529410.1737-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309021529410.1737-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
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

Sounds reasonable, but... what about modular ACPI? At least 
acpi_bus_register_driver() uses acpi_disabled, so it would seem to me that
every time we're loading an ACPI driver module, acpi_disabled evaluates to 
something random, as in the aforementioned case?

Additionally, if acpi_disabled is to be available for modules (i.e. modular
ACPI), it should rather be exported, shouldn't it?

> Tangential question: Do preprocessor conditionals evaluate to a value? 
> I.e. instead of doing: 
> 
> #ifdef	CONFIG_ACPI
> 	int acpi_disabled = 0;
> #else
> 	int acpi_disabled = 1;
> #endif
> 
> Could we do: 
> 
> int acpi_disabled = (CONFIG_ACPI == 'y'); 

AFAIK acpi_disabled is independent on CONFIG_ACPI, i.e. CONFIG_ACPI may be
defined, but if acpi=off is passed to the kernel command line,
acpi_disabled evaluates to 1?
Best regards and a 1:20 am CEST disclaimer: I might be talking nonsenses.

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
