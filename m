From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: ACPI source release updated (20020829)
Date: Sat, 31 Aug 2002 15:05:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020831130531.GB1020@schiggy.intern.quelltext.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDF9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDF9-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy!

On Fri, Aug 30, 2002 at 01:29:46PM -0700, Grover, Andrew wrote:
> Kacpid is a workaround, it's not the solution.
> 
> If we are not receiving SCIs, that is a problem that should be solved.
> Polling is...not preferable.
> 
> The 0829 patch includes a fix to ensure the SCI is properly configured. Does
> that help these systems?

Unfortunately, the code you mention does not seem to have made it into
acpi-20020829-2.4.20-pre5.diff.gz.

Patch acpi-20020829-2.5.32.diff.gz contains the following change for
drivers/acpi/bus.c:

+       /* Ensure the SCI is set to level-triggered, active-low */
+       if (acpi_ioapic)
+               mp_override_legacy_irq(acpi_fadt.sci_int, 3, 3, acpi_fadt.sci_int);
+       else
+               eisa_set_level_irq(acpi_fadt.sci_int);

However, this change is missing in acpi-20020829-2.4.20-pre5.diff.gz,
and in fact ACPI events do not get activated for my machine (Gericom
1st Supersonic M6-T) when running 2.4.20-pre5 with acpi-20020829.

(They get enabled when I manually include "eisa_set_level_irq(9);" in
acpi_pci_irq_init() in drivers/acpi/pci_irq.c.)

Otherwise, 2.4.20-pre5 with acpi-20020829 works just fine for me, i.e.
there are no regressions. I haven't tried 2.5.32 yet, though.

Best regards,
Arndt


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
