From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: acpi_pci_irq_enable called for all PCI devices
Date: Wed, 4 Aug 2004 08:21:59 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408040821.59780.bjorn.helgaas@hp.com>
References: <F760B14C9561B941B89469F59BA3A847070ED5D8@orsmsx401.amr.corp.intel.com> <1091590975.2297.67.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091590975.2297.67.camel@dhcppc4>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 03 August 2004 9:42 pm, Len Brown wrote:
> On Tue, 2004-08-03 at 20:39, Grover, Andrew wrote:
> > I'm looking at the code in pci_acpi_init that unconditionally calls
> > acpi_pci_irq_enable for all PCI devices. The comment says this is to
> > work around drivers that do not call pci_enable_device.
> > 
> > Do we know if there are any drivers broken in this manner? I think it
> > would be good to take advantage of the work done here and not do all IRQ
> > allocation at init.
> 
> I think this was just to be conservative (retain old behaviour) during
> 2.6.8.  Perhaps we should delete that upon the start of 2.6.9...

Yes, this was just to be conservative.  In fact, I'm in the middle of a
little audit for this problem, and have found a few drivers that are
clearly broken.  The following drivers use pci_dev->irq without calling
pci_enable_device():

	drivers/atm/idt77252.c
	drivers/char/ip2main.c
	drivers/char/ipmi/ipmi_si_intf.c
	drivers/isdn/tpam/tpam_main.c
	drivers/misc/ibmasm/module.c
	drivers/net/hp100.c
	drivers/net/ioc3-eth.c
	drivers/net/tulip/de4x5.c
	drivers/net/wan/sdladrv.c
	drivers/scsi/cpqfcTSinit.c

I have patches for the above that I started posting yesterday.  But
somebody pointed out that I really should add pci_disable_device()
calls at the same time, so I'm going back to do that.  After posting
these driver patches, I'll post a patch to remove the unconditional
acpi_pci_irq_enable() calls in pci_acpi_init().  I'll probably add
a temporary "pci=routeirq" flag to retain the old behavior in case
I missed any drivers.

There are many others that don't call pci_enable_device() but don't
use pci_dev->irq.  Those shouldn't be affected, so I haven't worried
too much about them.

Bjorn


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
