From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: S3-resume in FreeBSD
Date: Fri, 9 Apr 2004 15:58:23 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040409154821.R50561@root.org>
References: <37F890616C995246BE76B3E6B2DBE0554F1C5F@orsmsx403.amr.corp.intel.com>
 <20040408151829.L43644@root.org> <20040409061527.GA8572@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040409061527.GA8572-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 9 Apr 2004, Dominik Brodowski wrote:
> Do you know, by chance, if FreeBSD's resume process from S3 equals
> acpi_sleep=s3_mode, s3_bios or none of these special hacks?
>
> Many thanks,
> 	Dominik

I don't actually know what those flags do on Linux.  You can see the path
taken for suspend/resume by following these functions in the linked files:

http://www.freebsd.org/cgi/cvsweb.cgi/~checkout~/src/sys/dev/acpica/acpi.c?rev=1.136&content-type=text/plain
acpi_SetSleepState()

http://www.freebsd.org/cgi/cvsweb.cgi/~checkout~/src/sys/i386/acpica/acpi_wakeup.c?rev=1.31&content-type=text/plain
acpi_sleep_machdep()

[sleep S3, wakeup]

http://www.freebsd.org/cgi/cvsweb.cgi/~checkout~/src/sys/i386/acpica/acpi_wakecode.S?rev=1.9
acpi wakecode runs and returns to acpi_restorecpu() (in acpi_wakeup.c)

We just committed code to save/restore BARs for PCI devices.  That should
fix some problems.  We support _PRW/_PSW so lid switch wakes devices.
Things left to do include _SxD support and I think there are some problems
with the ACPI-CA path for suspend/resume (i.e. it doesn't always clear
wake status).

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
