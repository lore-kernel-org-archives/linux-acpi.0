From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: Re: Re: system freezes for 0.2 to 0.5 seconds when reading /proc/acpi/thermal_zone/THRM/temperature
Date: Thu, 28 Jul 2005 16:45:08 +0100
Message-ID: <E1DyAZI-0006Mh-00@skye.ra.phy.cam.ac.uk>
References: <20050727235625.028b7728.akpm@osdl.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 27 Jul 2005 23:56:25 PDT."
             <20050727235625.028b7728.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I get the same short freezes with

  cat /proc/acpi/battery/*/{state,info}

and also with the 'acpi' command-line tool.  I'm about to try the the
suggested kernel profiling with -mm3 and will report the results.

Meanwhile:

>>> readprofile -r
>> do i have to activate something special during kernel configuration?
>Set CONFIG_PROFILING=y

That confuses me.  For readprofile support,
Documentation/basic_profiling.txt says

  Add "profile=2" to the kernel command line.

For Oprofile support it says:

  Configure with CONFIG_PROFILING=y and CONFIG_OPROFILE=y

The two together suggest that CONFIG_PROFILING shouldn't be needed for
readprofile.

-Sanjoy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
