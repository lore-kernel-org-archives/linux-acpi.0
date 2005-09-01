From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Latest ACPI patch location, contents
Date: Thu, 01 Sep 2005 14:00:45 +0200
Message-ID: <4316ED6D.2010807@suse.de>
References: <1125009963.16880.29.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1125009963.16880.29.camel@toshiba>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> Folks,
> 
> I've consolidated the "to-linus" and "to-akpm" git trees into
> a single "linux-acpi-2.6" git tree with "release" and "test"
> branches.  Thanks to Tony Luck for the example.
> 
> So for the latest test code, go here:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> 
> Everything in this batch is intended for 2.6.14 "opening day",
> please let me know if you see any regressions.
> 
> A pull from there now will update the files shown below.
> 
> thanks,
> -Len
> 
> ps.
> Plain patch available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050729-2.6.13-rc7.diff.gz
...
> commit 0c9938cc75057c0fca1af55a55dcfc2842436695
> Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date:   Fri Jul 29 15:15:00 2005 -0700
> 
>     [ACPI] ACPICA 20050729 from Bob Moore
>     
>     Implemented support to ignore an attempt to install/load
>     a particular ACPI table more than once. Apparently there
>     exists BIOS code that repeatedly attempts to load the same
>     SSDT upon certain events. Thanks to Venkatesh Pallipadi.
>     
>     Restructured the main interface to the AML parser in
>     order to correctly handle all exceptional conditions. This
>     will prevent leakage of the OwnerId resource and should
>     eliminate the AE_OWNER_ID_LIMIT exceptions seen on some
>     machines. Thanks to Alexey Starikovskiy.
>     
>     Support for "module level code" has been disabled in this
>     version due to a number of issues that have appeared
>     on various machines. The support can be enabled by
>     defining ACPI_ENABLE_MODULE_LEVEL_CODE during subsystem
>     compilation. When the issues are fully resolved, the code
>     will be enabled by default again.
>     
>     Modified the internal functions for debug print support
>     to define the FunctionName parameter as a (const char *)
>     for compatibility with compiler built-in macros such as
>     __FUNCTION__, etc.
>     
>     Linted the entire ACPICA source tree for both 32-bit
>     and 64-bit.
>     
>     Signed-off-by: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>     Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
...

Could this be splitted in functional and formatting patches, please.
Or at least could someone post the "AE_OWNER_ID_LIMIT exceptions" and
"avoid ACPI tables double loading" patches separately.
Or tell me how to extract them, so that older kernels can be backported with the bug fixing
patches cleanly.

Thanks,

        Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
