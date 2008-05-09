From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Sat, 10 May 2008 00:57:01 +0200
Message-ID: <200805100057.01656.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org> <200805092344.53713.rjw@sisk.pl> <200805091513.04194.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52717 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015AbYEIW44 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 May 2008 18:56:56 -0400
In-Reply-To: <200805091513.04194.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Saturday, 10 of May 2008, Jesse Barnes wrote:
> On Friday, May 09, 2008 2:44 pm Rafael J. Wysocki wrote:
> > Okay, what about this:
> >
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > The new suspend and hibernation callbacks introduced with
> > 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> > pm_message_t argument, so the drivers using them will not be able
> > to use pci_choose_state() in its present form.  For this reason,
> > introduce a new function, pci_choose_and_set_state(), playing the
> > role of pci_choose_state() combined with pci_set_power_state() and
> > allowing the driver to put the device into a power state chosen by
> > the platform.
> 
> Yeah, that looks pretty good.  The name is long but I can't think of a better 
> one offhand.  Can you also update Documentation/power/pci.txt with the latest 
> best practices?

I'm going to do that, eventually, but rather in a separate patch, when
everything is ready for the new framework, while at the moment we still have
some design work to do.

For example, some drivers may want to call pci_enable_wake() for the
target state and that must be done before pci_set_power_state() in case the
target state is D3cold.  To allow them to do that, we'll need a variant of
pci_choose_and_set_state() with a 'wake_enabled' argument.

> I wonder if we should do a pass through the drivers converting them to this
> interface as well... 

Well, that would be lots of work and since we'd like the drivers to switch to
the new framework entirely, we'll need to pass through them anyway for this
purpose.  I'd prefer that to be one pass. ;-)

Thanks,
Rafael
