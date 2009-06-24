From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: why do drivers evaluate _INI?
Date: Wed, 24 Jun 2009 09:45:05 +0930 (CST)
Message-ID: <200906240015.n5O0F5bO024937@turbo.physics.adelaide.edu.au>
References: <1245770262.16646.16.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:35054 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830AbZFXAQm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2009 20:16:42 -0400
In-Reply-To: <1245770262.16646.16.camel@earth.gruber.myown> from "nokos@gmx.net" at Jun 23, 2009 05:17:42 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

Hi Peter

> > > Why do we have ACPI device drivers evaluating _INI?  That seems
> > > like something that should be done by Linux/ACPI, not by the driver.
> > > 
> > > I see the following drivers using _INI:
> > >   drivers/hwmon/hp_accel.c
> > >   drivers/platform/x86/fujitsu-laptop.c
> > >   drivers/platform/x86/sony-laptop.c
> > > 
> > > I looked at the git logs where the _INI usage was introduced in
> > > these drivers, but none gives enough information for me to understand
> > > why.
> > 
> > I can't shed a lot of light on this from the point of view of
> > fujitsu-laptop.
> > 
> > It appears that the evaluation of _INI was added to fujitsu-laptop as part
> > of the patch which added support for hotkeys present on some Fujitsu
> > laptops.  This patch was contributed by Peter Gruber - I've added him to the
> > CC.  Perhaps he might explain why he added _INI evaluation as part of this
> > patch (that is, what problem was encountered which required evaluation of
> > _INI).
> 
> The hotkey communication between hardware and the drivers is done using
> acpi notifies and a (small) ringbuffer in the acpi dsdt code. The
> easiest way to assure a consistent. The _INI method simply resets the
> internal state of the ringbuffer which seems to be unavailable for
> direct manipulation.

Thanks for this info Peter.  So evaluating _INI is required to ensure we
start with an empty ringbuffer and don't end up with partial sequences
and/or old keypresses being processed when the module is loaded - right?

> Another possible path would be to read and discard the ringbuffer on
> module load to ensure a consistent state.

True - but is this really any neater than calling _INI in this context?  In
addition, is there a definitive way to know that we have a consistant
ringbuffer state?  If not we won't know when to stop reading.

Having said that, the _INI method is called by acpi_ns_initialize_devices()
which I assume forms part of the APCI core initialisation.  Presumedly there
won't be a great deal of time elapsed between this and the initialisation of
fujitsu-laptop in most cases.  If fujitsu-laptop didn't call _INI (as per
the quick and dirty patch yesterday) there seems little scope for a real
problem.  The only time when it *could* be an issue is when considerable
time elapsed between ACPI initialisation and the loading of fujitsu-laptop -
something which in practice is only going to apply to the machines of
developers.

So, given this background, is there likely to be any real-world effect
caused by the removal of the _INI call in fujitsu-laptop?

Regards
  jonathan
