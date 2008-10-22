From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Wed, 22 Oct 2008 13:34:44 +0800
Message-ID: <20081022053444.GC15271@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <20080911063823.196887408@sli10-desk.sh.intel.com> <200810192150.41305.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50718 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbYJVFer (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 01:34:47 -0400
Content-Disposition: inline
In-Reply-To: <200810192150.41305.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "david-b@pacbell.net" <david-b@pacbell.net>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>

On Mon, Oct 20, 2008 at 03:50:40AM +0800, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > pci subsystem wakeup handler.
> 
> Perhaps add a bit more explanation here - what is introduced, why and why this
> particular way.
I'll add a kernel doc in later post.

> > +static bool pci_handle_one_wakeup_event(struct pci_dev *pdev)
> > +{
> 
> I don't really like that being a boolean function.  I'd make it return 0 on
> success and error code on failure.
Oh, in my previous post, somebody like a boolean and then you like an int
in the mail list. Either is ok to me, but I'd like to have a reason
instead of a 'like' or 'unlike'.

> > +     /* clear PME status and disable PME to avoid interrupt flood */
> > +     pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
> > +     if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> > +             return false;
> > +     /* I see spurious PME here, just ignore it for now */
> > +     if (!(pmcsr & PCI_PM_CTRL_PME_ENABLE))
> > +             spurious = true;
> > +     else
> > +             pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> 
> If you do this unconditionally, you'll be able to use pci_pme_active() for it.
> Actually, you can use pci_pme_enabled() for checking if PME is enabled
> and pci_pme_status() for checking if the PME status is set.  Then,
> you can remove the reference to the config space from here and use
> those low-level callbacks instead of them.
ok.
> > +     pmcsr |= PCI_PM_CTRL_PME_STATUS;
> > +     pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
> > +
> > +     if (spurious)
> > +             return false;
> > +     return true;
> > +out:
> > +     if (drv && drv->pm && drv->pm->base.wakeup_event)
> > +             return drv->pm->base.wakeup_event(&pdev->dev);
> 
> I'd move this into the 'if (!pme_pos)' block.  And is this what we want really?
> In this case the driver's wakeup_event() will be responsible for checking
> if the wake-up event is valid etc.
Yes, device driver should check if a wake-up event is valid.

> > +             device_receive_wakeup_event(&target->dev);
> 
> Why do we use device_receive_wakeup_event() here?
the device receives wakeup event, so it should do something.

> 
> > +             return ret;
> > +     }
> > +
> > +     if (ret)
> > +             device_receive_wakeup_event(&target->dev);
> 
> And here?  What's the idea?
ditto
 
> > +                             device_receive_wakeup_event(&tmp->dev);
> 
> What exactly is the role of device_receive_wakeup_event() here?
ditto

> > +                     }
> > +             }
> > +     }
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(pci_handle_wakeup_event);
> > +
> > +static bool pci_pm_wakeup_event(struct device *dev)
> > +{
> > +     return pci_handle_wakeup_event(to_pci_dev(dev));
> > +}
> 
> What exactly is the point of introducing this function?
David said other archs (embedded system) might require it.

Thanks,
Shaohua
