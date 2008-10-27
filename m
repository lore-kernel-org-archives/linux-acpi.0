From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: Doing _OSC right
Date: Mon, 27 Oct 2008 16:31:08 +0000
Message-ID: <1225125069.6725.86.camel@grinch>
References: <20081025053029.GT26094@parisc-linux.org>
	 <1225123939.6725.83.camel@grinch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1225123939.6725.83.camel@grinch>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2008-10-27 at 16:12 +0000, Andrew Patterson wrote:
> On Fri, 2008-10-24 at 23:30 -0600, Matthew Wilcox wrote:
> > Andrew Patterson recently reported a problem where a machine with dozens
> > of PCIe root bridges would take half an hour just calling _OSC.  The
> > root cause is the AER code calling:
> > 
> > 	pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
> > 
> > for each bridge.  pcie_osc_support_set() also iterates over each bridge,
> > so _OSC is called a quadratic number of times.  Obviously, this isn't
> > hard to fix -- just moving the call to pcie_osc_support_set() to
> > aer_service_init() would do.
> > 
> > But why should a driver be calling pcie_osc_support_set() anyway?  This
> > is something the PCI core should be taking care of for it.
> > 
> > The patch below illustrates one possible solution.  I create a new
> > function (pci_acpi_osc_support()) which is called from pci_root.c before
> > we call any other methods on the device (as recommended by the ACPI spec).
> > Since we know what capabilities the system supports, individual modules
> > do not now need to inform the core of their support for various
> > capabilities.
> > 
> > I do not think this patch is perfect.  One defect is that there are
> > now no callers of pci_osc_support_set nor pcie_osc_support_set, so they
> > could be deleted.
> > 
> > Another problem is that if, for example, MSI is disabled at boot time,
> > we will incorrectly inform ACPI that we support MSI.  So something more
> > flexible is needed.
> 
> Check pci_msi_enable? After exposing it.
> 
> > 
> > I think all the existing _OSC code should be moved from pci-acpi.c to
> > pci_root.c.  I also think the acpi_osc_data should be made part of the
> > acpi_pci_root struct, eliminating a separate allocation.
> > 
> > We could also use an interface that iterates over all existing busses
> > calling _OSC with new flags.  Shouldn't be hard, once it's integrated
> > into pci_root.c.
> > 
> 
> Need to think about root hotplug at some point.
> 
> > Further ahead, we don't actually check that the bits we asked for (in
> > 'control') were actually granted to us.  The PCI firmware spec is quite
> > explicit about interdependencies amongst the bits.
> 
> Do we need to do this in addition to the typical
> pci_find_capability(dev, PCI_CAP_ID_MSIX) check? Perhaps we can write a
> function that does both?
> 
> > 
> > We also need to re-evaluate _OSC when coming out of S4.  I'm not much of
> > a power-management maven so I don't know where to put this call.
> > 
> > Thoughts on the road ahead?
> > 
> 
> This patch does not compile on pci-2.6/linux-next with ia-64.

My bad.  Chopped off the last diff when removing the sym2 patches.

Andrew
