From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] ACPI Update (resend 1)
Date: Wed, 5 Feb 2003 18:42:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A162@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dominik, I can come up with a quick fix (put a CONFIG_CPU_FREQ around
the code block at line 1044 in processor.c) but is there a better way?

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org] 
> Sent: Wednesday, February 05, 2003 5:45 PM
> To: Grover, Andrew
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [BK PATCH] ACPI Update (resend 1)
> 
> 
> 
> On Wed, 5 Feb 2003, Grover, Andrew wrote:
> > 
> > 	bk pull http://linux-acpi.bkbits.net/linux-acpi
> 
> Hmm..
> 
>   drivers/built-in.o(.text+0x32f93): In function 
> `acpi_processor_apply_limit':
>   : undefined reference to `cpufreq_get_policy'
> 
> This seems to happen if ACPI is on, but CPUFREQ isn't.. Which 
> is my normal 
> dual P4-HT desktop requirement.
> 
> 		Linus
> 


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
