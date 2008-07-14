From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PCI PM: Fix pci_prepare_to_sleep
Date: Mon, 14 Jul 2008 23:40:04 +0200
Message-ID: <200807142340.05484.rjw@sisk.pl>
References: <200807012356.26669.rjw@sisk.pl> <200807132245.07414.rjw@sisk.pl> <200807141427.34022.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46382 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbYGNViZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 17:38:25 -0400
In-Reply-To: <200807141427.34022.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Pavel Machek <pavel@suse.cz>

On Monday, 14 of July 2008, Jesse Barnes wrote:
> On Sunday, July 13, 2008 1:45 pm Rafael J. Wysocki wrote:
> > Hi Jesse,
> >
> > The recently introduced pci_prepare_to_sleep() needs the following fix,
> > because there are systems which are not power manageable by ACPI (ie. ACPI
> > doesn't provide methods to put the device into low power states and back),
> > but require ACPI hooks to be executed for wake-up to work.
> >
> > Please apply.
> >
> > Thanks,
> > Rafael
> >
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Fix pci_prepare_to_sleep() to work on systems that are not power
> > manageable by ACPI (ie. ACPI doesn't provide methods to put the
> > device into low power states and back into the full power state), but
> > require ACPI hooks to be executed for wake-up to work.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Based on what you've told me so far about the number of ACPI vs. native wakeup 
> methods & problems, I'm starting to get a little worried that making this 
> stuff work right will require lots of platform specific quirks.

Yes, this is likely.

Also, having looked at several network adapters' suspend and resume routines,
I think we'll need to do some fine tuning here and there.

> I guess that's just par for the course though, and this patch looks fine, so
> I just applied it to my linux-next branch.

Thanks!

Rafael
