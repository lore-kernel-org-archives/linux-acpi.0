From: Art Haas <ahaas-baQpNawxmjLR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Re: Error building
	drivers/acpi/processor_idle.c in current BK
Date: Wed, 29 Dec 2004 10:17:52 -0600
Message-ID: <1104337071.6187.11.camel@localhost.localdomain>
References: <1104335566.6187.8.camel@localhost.localdomain>
	 <20041229160708.GA8982@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041229160708.GA8982-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-12-29 at 10:07, Dominik Brodowski wrote:
> On Wed, Dec 29, 2004 at 09:52:46AM -0600, Art Haas wrote:
> > Hi.
> > 
> > I tried building Linus's BK tree this morning using the development
> > version of GCC. Unfortunately there was a snag when building some of the
> > acpi files ...
> > 
> > drivers/acpi/processor_idle.c:57: error: static declaration of
> > ???pm_idle_save??? follows non-static declaration
> > include/acpi/processor.h:180: error: previous declaration of
> > ???pm_idle_save??? was here
> > 
> > The files compile without problem in GCC 3.3.
> 
> Thanks for reporting this issue. Could you test the attached patch, please?
> gcc-Version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)
> did and does not complain...
> 
> 
> As pm_idle_save is static to processor_idle by now, having it defined
> differently in processor.h breaks compilation with latest gcc, as noted
> by Art Haas.
> 
> Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
> ---
> 
>  include/acpi/processor.h |    1 -
>  1 files changed, 1 deletion(-)
> 
> Index: 2.6.10/include/acpi/processor.h
> ===================================================================
> --- 2.6.10.orig/include/acpi/processor.h	2004-12-29 17:03:30.742089456 +0100
> +++ 2.6.10/include/acpi/processor.h	2004-12-29 17:04:02.449441921 +0100
> @@ -177,7 +177,6 @@
>  /* for communication between multiple parts of the processor kernel module */
>  extern struct acpi_processor	*processors[NR_CPUS];
>  extern struct acpi_processor_errata errata;
> -extern void (*pm_idle_save)(void);
>  
>  /* in processor_perflib.c */
>  #ifdef CONFIG_CPU_FREQ

Removing this line allows processor_idle.c to compile without problems.

Art Haas



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
