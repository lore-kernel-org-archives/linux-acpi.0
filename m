From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: acpi_os_read_pci_configuration
Date: Wed, 11 Jun 2003 22:40:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030611214017.GR28581@parcelfarce.linux.theplanet.co.uk>
References: <F760B14C9561B941B89469F59BA3A847E96F52@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F52-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 11, 2003 at 10:28:23AM -0700, Grover, Andrew wrote:
> > From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org] 
> > Another piece of the PCI domain puzzle is 
> > acpi_os_read_pci_configuration
> > (and _write_ obviously).  These functions are passed a struct 
> > acpi_pci_id
> > and attempt to translate this into a struct pci_bus to pass to the
> > pci_root_ops functions.
> > 
> > Is there guaranteed to already be a pci_bus that these functions could
> > go and find, or are they sometimes called before any pci_bus exists?
> 
> The latter.

Thanks.  Argh ;-)

So, to enable PCI domain support for these functions, we need to have some
way of setting up the segment/domain number.  The trouble is that this is
all architecture-dependent (I wanted to make it part of pci_bus ... that got
vetoed).  So we'll need some way of allocating a PCI bus within the appropriate
domain.

This isn't a problem for the hotplug code because it has a parent and
inherits sysdata from that.  It's not a problem for the main PCI buswalk
code because it's going aroud creating the canonical busses to use,
but ACPI just wants to create a temporary one so it can read or write
one byte/short/int.

One solution is (per architecture):

void pci_assign_domain(struct pci_bus *bus, int domain)

I don't like this very much.

Possibly a better solution is 

struct pci_bus * pci_alloc_bus_domain(int domain)

which will return a sufficiently initialised pci_bus.  The trouble
with this method is that it doesn't quite fit into the current PCI
implementation where we call pcibios_scan_root() which allocates
the sysdata then calls pci_scan_bus_parented() which calls
pci_alloc_primary_bus_parented() to allocate the bus, then fills in
the sysdata.

I can't see a nice way to restructure this.  Anyone got any better ideas?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
