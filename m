From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 5/5] ACPI GPE based wakeup event detection
Date: Wed, 22 Oct 2008 14:12:18 +0200
Message-ID: <200810221412.19156.rjw@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <200810192239.47710.rjw@sisk.pl> <20081022065101.GE15271@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59272 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbYJVMHg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 08:07:36 -0400
In-Reply-To: <20081022065101.GE15271@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "david-b@pacbell.net" <david-b@pacbell.net>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>

On Wednesday, 22 of October 2008, Shaohua Li wrote:
> On Mon, Oct 20, 2008 at 04:39:47AM +0800, Rafael J. Wysocki wrote:
> > On Thursday, 11 of September 2008, Shaohua Li wrote:
> > > In ACPI platform, if native PME isn't enabled, GPE is used to report wakeup event.
> > 
> > Add more details here, please.
> > 
> > > ---
> > >  drivers/acpi/Kconfig        |    9 ++++++
> > >  drivers/acpi/bus.c          |   15 +++++++++++
> > >  drivers/acpi/sleep/wakeup.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/acpi/acpi_bus.h     |    4 ++
> > >  4 files changed, 88 insertions(+)
> > >
> > > Index: linux/drivers/acpi/Kconfig
> > > ===================================================================
> > > --- linux.orig/drivers/acpi/Kconfig   2008-09-11 10:56:25.000000000 +0800
> > > +++ linux/drivers/acpi/Kconfig        2008-09-11 10:56:47.000000000 +0800
> > > @@ -45,6 +45,15 @@ config ACPI_SLEEP
> > >       depends on PM_SLEEP
> > >       default y
> > >
> > > +config ACPI_GPE_WAKEUP
> > 
> > I'd call it ACPI_RUNTIME_WAKEUP
> ok
> 
> > > +void unregister_acpi_bus_notifier(struct notifier_block *nb)
> > > +{
> > > +     blocking_notifier_chain_unregister(&acpi_bus_notify_list, nb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
> > > +
> > 
> > We were talking about removing the notifier last time.  Please do that.
> Did you see my comments on the issue last time? ACPI test tree already introduces
> the mechanism for other purpose, and we can just use it.
> 
> > > --- linux.orig/include/acpi/acpi_bus.h        2008-09-11 10:56:25.000000000 +0800
> > > +++ linux/include/acpi/acpi_bus.h     2008-09-11 10:56:47.000000000 +0800
> > > @@ -327,6 +327,10 @@ int acpi_bus_get_private_data(acpi_handl
> > >  extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
> > >  extern int register_acpi_notifier(struct notifier_block *);
> > >  extern int unregister_acpi_notifier(struct notifier_block *);
> > > +
> > > +extern int register_acpi_bus_notifier(struct notifier_block *nb);
> > > +extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
> > > +
> > >  /*
> > >   * External Functions
> > >   */
> > >
> > 
> > I understand from the above that devices having their own wake-up GPEs will be
> > handled.  However, it still is completely unclear to me what happens with
> > devices that can generate PME# and for which there are no specific GPEs, like
> > any devices on add-in cards.
> As we discussed last time, pci bus for add-in cards will invoke a gpe, and
> this new implementation will check all pci devices under a bridge to try to find
> a device generating PME. This should work for add-in cards.

Well, can you please describe this mechanism to me or point me to
documents/code where I can read about it?

The question is how we can learn which GPE will be used for signalling the PME#
events.

Thanks,
Rafael
