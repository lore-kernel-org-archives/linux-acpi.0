From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re: 2.6.13-rc3-mm3
Date: Thu, 4 Aug 2005 15:55:13 -0700
Message-ID: <20050804155513.727a3894.akpm@osdl.org>
References: <971FCB6690CD0E4898387DBF7552B90E023F8527@orsmsx403.amr.corp.intel.com>
	<42EAC9DB.9010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42EAC9DB.9010702-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tk-shockwave-S0/GAf8tV78@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Moore, Robert schrieb:
> 
> >+    ACPI-0287: *** Error: Region SystemMemory(0) has no handler
> >+    ACPI-0127: *** Error: acpi_load_tables: Could not load namespace:
> >AE_NOT_EXIST
> >+    ACPI-0136: *** Error: acpi_load_tables: Could not load tables:
> >
> >This looks like a nasty case where some executable code in the table is
> >attempting to access a SystemMemory operation region before any OpRegion
> >handlers are initialized.
> >
> >We certainly want to see the output of acpidump to attempt to diagnose
> >and/or reproduce the problem.
> >
> >Bob
> >
> >
> >  
> >
> Sorry for double post.
> 
> With this mail I hand over the acpidump output with the pmtools
> Andrew pointed me to.
> 
> And a dmesg output with CONFIG_KALLSYMS=y.
> 
> 
> I attached them in bz2 format, because of the length.
> 
> I hope we find the problem.
> 

Michael, I'm assuming that a) this problem remains in those -mm kernels
which include git-acpi.patch and that b) the problems are not present in
2.6.13-rc5 or 2.6.13-rc6, yes?

So I think we have a bug in git-acpi.patch?

If that's all correct then can you please test the next -mm (which will
include git-acpi.patch - the most recent -mm did not) and if the bug's
still there can you raise a bugzilla.kernel.org entry for it?

We seem to have a handful of bug reports against the -mm acpi patch.

Thanks.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
