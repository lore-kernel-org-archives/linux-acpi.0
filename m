From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Latest ACPI patch location, contents
Date: Sat, 03 Sep 2005 12:55:12 -0400
Message-ID: <1125766512.11903.58.camel@toshiba>
References: <1125009963.16880.29.camel@toshiba>
	 <1125732876.11903.40.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1125732876.11903.40.camel@toshiba>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-09-03 at 03:34 -0400, Len Brown wrote:
> Folks,
> 
> For the latest test code, pull the test branch here:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> 
> Everything in this batch is intended for 2.6.14,
> so please let me know if you see any regressions vs 2.6.13.
> 
> A pull from there now will update every ACPI file in the kernel
> as it includes a Lindent flag-day.  Change log below.
> 
> thanks,
> -Len
> 
> ps.
> Plain patch available here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050902-2.6.13.diff.gz
> 
> Individual patches available here:
> http://kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=summary
> 

if you pulled the patch in the last 8 hours, please re-pull
to get the update below.

thanks,
-Len
-------------
commit 4a35a46bf1cda4737c428380d1db5d15e2590d18
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Sep 3 12:40:06 2005 -0400

    [ACPI] revert bad processor_core.c patch for bug 5128

    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--------------
available as a plain patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/broken-out/5128-revert.patch




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
