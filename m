From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: SSDT on Sony VAIO
Date: Thu, 16 Jan 2003 08:46:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030116074624.GA1239@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A11E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A11E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Conrad <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2003 at 05:08:40PM -0800, Grover, Andrew wrote:
> > From: Nathan Conrad [mailto:conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org] 
> > I am using kernel 2.5.55 on a Sony Vaio PCG-FXA49. Right now,
> > /proc/acpi/processor/CPU0/info says that performance management is
> > not available. My CPU (1.2 GHz mobile Athlon4) supports PowerNow, and
> > I would expect this would qualify as performance management.
> > 
> > I have looked at my ACPI tables and there is a listing of 5 P-states
> > in my SSDT (1200 MHz,1000,800,600,500 MHz).
> > 
> > Why are these not listed in my /proc/acpi/processor/CPU0 directory?
> > 
> > Does the current Linux ACPI driver look at the SSDT tables, or does it
> > only look at the DSDT for AML?
> 
> It should consume both SSDT and DSDT tables.
> 
> You might try taking a look at the "performance management" section of
> drivers/acpi/processor.c. Stick some printk's in
> acpi_processor_get_performance_states and see where things are going
> awry.
> 
> Also, if _PCT isn't present in the namespace as well, then it flags perf
> support as not available.

Also, do you have CONFIG_CPU_FREQ and CONFIG_ACPI_PROCESSOR_PERF enabled? If
not, support for "performance management" will be disabled.

	Dominik


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
