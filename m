From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 22:27:08 +0100
Message-ID: <2990024.LMTIBUbM3d@vostro.rjw.lan>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45950 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab3C1VTk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Mar 2013 17:19:40 -0400
In-Reply-To: <51548C9E.9090703@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Thursday, March 28, 2013 07:31:58 PM Martin Mokrejs wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas wrote:
> > On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
> > <mmokrejs@fold.natur.cuni.cz> wrote:
> >>
> >>
> >> Rafael J. Wysocki wrote:
> >>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
> >>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
> >>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>>>> Hi Bjorn,
> >>>>>>>
> >>>>>>> I wonder what you think about the patch below?
> >>>>>>
> >>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
> >>>>>> I don't know much about it).  Why don't you resend it with Matthew's
> >>>>>> ack and the appropriate stable tags, and I'll put it in.
> >>>>>
> >>>>> I will, thanks!
> >>>>>
> >>>>>> If you have
> >>>>>> a URL for a bugzilla or mailing list report of the original problem,
> >>>>>> that would be good, too.  It'd be nice if users and distros could
> >>>>>> match problem reports with this solution, but I can't tell what the
> >>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
> >>>>>> else reproduced the problem and tested the fix)?
> >>>>>
> >>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
> >>>>> to publicly available mailing list archives etc.
> >>>>
> >>>> Do you at least have a description of how a user could determine
> >>>> whether he is seeing the problem fixed by this patch?
> >>>
> >>> Yeah.  For example, when the problem is visible on a USB controller and that
> >>> controller is runtime-suspended, then plugging a new USB device into one
> >>> of the controller's ports won't wake the controller up without the patch.
> >>
> >> Hi,
> >>  I am wondering for a week or two why nobody answered any of my bug reports,
> >> not even Sarah who asked for more details. I am think the fix is about my report
> >> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
> >> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
> >> about my report. But I should better wait what Sarah says. ;-)
> > 
> > I haven't forgotten about your hotplug issues, but I've been on
> > vacation for a week and have been working on the similar issue
> > reported by Chris Clayton
> > (https://bugzilla.kernel.org/show_bug.cgi?id=54981) because it seemed
> > a bit more tractable.  But I'll get back to yours eventually :)
> > Unfortunately nobody else seems to be jumping in to help, and I can
> > only do so much by myself.
> > 
> > I haven't been following your XHCI issue at all, but one thing you
> 
> But please do so now. If we are talking about an existing patch it should be
> possible to say whether what I observed is likely to be fixed by the patch.
> I will happily discuss then why I loose interrupts in a same way for my
> rtl8169 network card and why this PME# stuff happens for me only with 3.8
> and not 3.7 (unlike what Sarah claims). I am not arguing that something 
> else makes 3.7 be able to wakeup the device and overcome the same bug
> while "it" is gone from 3.8. I think this should be an easy task for you,
> pci devs. ;-)

OK, let's try to establish facts.

Does the patch below causes the PCI PM issues you're seeing to go away?

If it doesn't make all of them go away, does it make *some* of them go away?

If that is the case, which of the problems remain after applying it (on top
of the Linus' current tree)?

Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: PCI / PM: Disable runtime PM of PCIe ports

The runtime PM of PCIe ports turns out to be quite fragile, as in
some cases things work while in some other cases they don't and we
don't seem to have a good way to determine whether or not they are
going to work in advance.

For this reason, avoid enabling runtime PM for PCIe ports by
keeping their runtime PM reference counters always above 0 for the
time being.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-pm/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-pm/drivers/pci/pcie/portdrv_pci.c
@@ -225,16 +225,11 @@ static int pcie_portdrv_probe(struct pci
 	 * it by default.
 	 */
 	dev->d3cold_allowed = false;
-	if (!pci_match_id(port_runtime_pm_black_list, dev))
-		pm_runtime_put_noidle(&dev->dev);
-
 	return 0;
 }
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (!pci_match_id(port_runtime_pm_black_list, dev))
-		pm_runtime_get_noresume(&dev->dev);
 	pcie_port_device_remove(dev);
 	pci_disable_device(dev);
 }

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
