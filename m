From: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Date: Fri, 18 Jun 2004 09:09:49 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040618120949.GA1956@logos.cnet>
References: <1087540935.4488.214.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1087540935.4488.214.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 18, 2004 at 03:32:49AM -0400, Len Brown wrote:
> Hi Marcelo, please do a 
> 
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.27

Applied Len, thanks a lot.

> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.27/acpi-20040326-2.4.27.diff.gz
> 
> This will update the following files:
> 
>  arch/i386/kernel/acpi.c      |    5 +++
>  arch/i386/kernel/mpparse.c   |   18 ++++++++++-
>  arch/x86_64/kernel/mpparse.c |    1 
>  drivers/acpi/asus_acpi.c     |    4 +-
>  drivers/acpi/pci_link.c      |   22 +------------
>  drivers/acpi/pci_root.c      |   49 ++++++++++++++++++++++++++++++-
>  drivers/acpi/thermal.c       |    7 ++++
>  7 files changed, 82 insertions(+), 24 deletions(-)
> 
> through these ChangeSets:
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/18 1.1359.6.28)
>    [ACPI] handle SCI override to nth IOAPIC
>    http://bugzilla.kernel.org/show_bug.cgi?id=2835
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/18 1.1359.6.27)
>    [ACPI] fix 2.4.27-pre3 IRQ override regression
>    due to dynamically allocated mp_irqs[].
>    http://bugzilla.kernel.org/show_bug.cgi?id=2834
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/18 1.1359.6.26)
>    [ACPI] avoid spurious interrupts on VIA
>    http://bugzilla.kernel.org/show_bug.cgi?id=2243
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/18 1.1359.6.25)
>    [ACPI] fix passive cooling mode indicator (Luming Yu)
>    http://bugzilla.kernel.org/show_bug.cgi?id=1770
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/17 1.1359.6.24)
>    [ACPI] PCI bus numbering workaround for ServerWorks
>    from David Shaohua Li
>    http://bugzilla.kernel.org/show_bug.cgi?id=1662
> 
> <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> (04/06/03 1.1359.6.23)
>    [PATCH] acpi4asus trivial sync with 2.6 (Karol 'sziwan' Kozimor)
> 
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
