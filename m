From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest ACPI patch location, contents
Date: 02 Sep 2005 17:42:54 -0400
Message-ID: <1125697374.11258.45.camel@d845pe.worldpath.net>
References: <1125009963.16880.29.camel@toshiba>  <4316ED6D.2010807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4316ED6D.2010807-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-09-01 at 08:00, Thomas Renninger wrote:
> Len Brown wrote:

> ...
> > commit 0c9938cc75057c0fca1af55a55dcfc2842436695
> > Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Date:   Fri Jul 29 15:15:00 2005 -0700
> >
> >     [ACPI] ACPICA 20050729 from Bob Moore
> >    
> >     Implemented support to ignore an attempt to install/load
> >     a particular ACPI table more than once. Apparently there
> >     exists BIOS code that repeatedly attempts to load the same
> >     SSDT upon certain events. Thanks to Venkatesh Pallipadi.
> >    
> >     Restructured the main interface to the AML parser in
> >     order to correctly handle all exceptional conditions. This
> >     will prevent leakage of the OwnerId resource and should
> >     eliminate the AE_OWNER_ID_LIMIT exceptions seen on some
> >     machines. Thanks to Alexey Starikovskiy.
> >    
> >     Support for "module level code" has been disabled in this
> >     version due to a number of issues that have appeared
> >     on various machines. The support can be enabled by
> >     defining ACPI_ENABLE_MODULE_LEVEL_CODE during subsystem
> >     compilation. When the issues are fully resolved, the code
> >     will be enabled by default again.
> >    
> >     Modified the internal functions for debug print support
> >     to define the FunctionName parameter as a (const char *)
> >     for compatibility with compiler built-in macros such as
> >     __FUNCTION__, etc.
> >    
> >     Linted the entire ACPICA source tree for both 32-bit
> >     and 64-bit.
> >    
> >     Signed-off-by: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >     Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> ...
> 
> Could this be splitted in functional and formatting patches, please.
> Or at least could someone post the "AE_OWNER_ID_LIMIT exceptions" and
> "avoid ACPI tables double loading" patches separately.
> Or tell me how to extract them, so that older kernels can be
> backported with the bug fixing
> patches cleanly.

Thomas,

There are a couple of hurdles here.

20050729 Lint -- sorry, I'm afraid the Lint changes
are bundled into that patch and it is too late to
un-bundle them.  Ideally every patch should be Linted
before applied so that the changes will go in
Lint-clean, but we sometimes diverge from
the Lint clean and unfortunately that patch
included some unrelated catch up.

duplicate tables.
The fix in 20050729 was proven to be insufficient,
and has been augmented in 20050815. (do a byte
compare of the actual table contents).  20050815
went into git post Lindent flag-day, but is available
pre-lindent in the quilt series below.

AE_OWNER_ID_LIMIT exception.
20050729 is a partial fix.  You'll also need
Alexey's owner-id-3.patch, which went into
the latest ACPI patch post Lindent flag-day, but is
available in bugzilla as well as the quilt
series below.

I've created a quilt patches series that can
upgrade 2.6.13 to the latest ACPICA here:
kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpica-upgrade-series
It excludes the Lindent flag-day that happened
between 20050729 and 20050815 -- so you have
a better chance to apply it, or cherry-pick it.

Bob plans to release 20050902 tonight and I'll
be adding that there too.  It fixes the un-do
of our aborted attempt to enable module level
code -- ie we'll behave like stock 2.6.13 again.
My intent is to ship this version to 2.6.14.

If your release is based on 2.6.13, ideally
you'll apply the entire series ala treating
the ACPICA core as a driver and doing a wholesale
update.  That would reduce the risk of cherry-picking
because ACPICA release are tested as a unit.

cheers,
-Len




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
