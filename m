From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: [BK PATCH] ACPI Update (resend 1)
Date: Thu, 6 Feb 2003 10:27:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206092718.GA14190@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A162@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A162-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry ...

On Wed, Feb 05, 2003 at 06:42:20PM -0800, Grover, Andrew wrote:
> Dominik, I can come up with a quick fix (put a CONFIG_CPU_FREQ around
> the code block at line 1044 in processor.c) but is there a better way?
No, there's no better way ... even though this code block can only be called
when CONFIG_CPU_FREQ is enabled -- pr->flags.performance is zero otherwise.

> > -----Original Message-----
> > From: Linus Torvalds [mailto:torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org] 
> > 
> > On Wed, 5 Feb 2003, Grover, Andrew wrote:
> > > 
> > > 	bk pull http://linux-acpi.bkbits.net/linux-acpi
> > 
> > Hmm..
> > 
> >   drivers/built-in.o(.text+0x32f93): In function 
> > `acpi_processor_apply_limit':
> >   : undefined reference to `cpufreq_get_policy'
> > 
> > This seems to happen if ACPI is on, but CPUFREQ isn't.. Which 
> > is my normal 
> > dual P4-HT desktop requirement.
> > 
> > 		Linus
> > 

--- linux/drivers/acpi/processor.c.original	2003-02-06 10:13:50.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-02-06 10:16:55.000000000 +0100
@@ -1041,6 +1041,7 @@
 		return_VALUE(-ENODEV);
 
 	if (pr->flags.performance) {
+#ifdef CONFIG_CPU_FREQ
 		px = pr->performance_platform_limit;
 		if (pr->limit.user.px > px)
 			px = pr->limit.user.px;
@@ -1055,6 +1056,7 @@
 		}
 		if (result)
 			goto end;
+#endif
 	} else if (pr->performance_platform_limit) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Platform limit event detected. Consider using ACPI P-States CPUfreq driver\n"));
 	}


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
