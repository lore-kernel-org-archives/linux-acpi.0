From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 17:59:11 +0100
Message-ID: <1433753.0tcctuHSKe@vostro.rjw.lan>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <2457825.yjlrJCricN@vostro.rjw.lan> <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45709 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756535Ab3C1Qvn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Mar 2013 12:51:43 -0400
In-Reply-To: <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
> >> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > Hi Bjorn,
> >> >
> >> > I wonder what you think about the patch below?
> >>
> >> Seems fine to me (I'm trusting your and Matthew's judgment here since
> >> I don't know much about it).  Why don't you resend it with Matthew's
> >> ack and the appropriate stable tags, and I'll put it in.
> >
> > I will, thanks!
> >
> >> If you have
> >> a URL for a bugzilla or mailing list report of the original problem,
> >> that would be good, too.  It'd be nice if users and distros could
> >> match problem reports with this solution, but I can't tell what the
> >> user-visible issue was.  I assume that Sarah tested this (or somebody
> >> else reproduced the problem and tested the fix)?
> >
> > Sarah reported it to me privately and I'm afraid I don't have any pointers
> > to publicly available mailing list archives etc.
> 
> Do you at least have a description of how a user could determine
> whether he is seeing the problem fixed by this patch?

Yeah.  For example, when the problem is visible on a USB controller and that
controller is runtime-suspended, then plugging a new USB device into one
of the controller's ports won't wake the controller up without the patch.

I will put that information into the changelog.

Thanks,
Rafael


> >> > On Saturday, March 23, 2013 03:33:03 PM Rafael J. Wysocki wrote:
> >> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >>
> >> >> It turns out that _Lxx control methods provided by some BIOSes clear
> >> >> the PME Status bit of PCI devices they handle, which means that
> >> >> pci_acpi_wake_dev() cannot really use that bit to check whether or
> >> >> not the device has signalled wakeup.
> >> >>
> >> >> For this reason, make pci_acpi_wake_dev() always attempt to resume
> >> >> the device it is called for regardless of the device's PME Status bit
> >> >> value (that bit still has to be cleared if set at this point,
> >> >> though).
> >> >>
> >> >> Reported-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> >> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >> ---
> >> >>  drivers/pci/pci-acpi.c |   15 ++++++++-------
> >> >>  1 file changed, 8 insertions(+), 7 deletions(-)
> >> >>
> >> >> Index: linux-pm/drivers/pci/pci-acpi.c
> >> >> ===================================================================
> >> >> --- linux-pm.orig/drivers/pci/pci-acpi.c
> >> >> +++ linux-pm/drivers/pci/pci-acpi.c
> >> >> @@ -53,14 +53,15 @@ static void pci_acpi_wake_dev(acpi_handl
> >> >>               return;
> >> >>       }
> >> >>
> >> >> -     if (!pci_dev->pm_cap || !pci_dev->pme_support
> >> >> -          || pci_check_pme_status(pci_dev)) {
> >> >> -             if (pci_dev->pme_poll)
> >> >> -                     pci_dev->pme_poll = false;
> >> >> +     /* Clear PME Status if set. */
> >> >> +     if (pci_dev->pme_support)
> >> >> +             pci_check_pme_status(pci_dev);
> >> >>
> >> >> -             pci_wakeup_event(pci_dev);
> >> >> -             pm_runtime_resume(&pci_dev->dev);
> >> >> -     }
> >> >> +     if (pci_dev->pme_poll)
> >> >> +             pci_dev->pme_poll = false;
> >> >> +
> >> >> +     pci_wakeup_event(pci_dev);
> >> >> +     pm_runtime_resume(&pci_dev->dev);
> >> >>
> >> >>       if (pci_dev->subordinate)
> >> >>               pci_pme_wakeup_bus(pci_dev->subordinate);
> >> >>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> > --
> >> > I speak only for myself.
> >> > Rafael J. Wysocki, Intel Open Source Technology Center.
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
