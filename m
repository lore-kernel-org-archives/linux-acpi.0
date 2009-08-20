From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 10:11:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201004100.3048-100000@iolanthe.rowland.org>
References: <20090820030423.GA26357@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42478 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754356AbZHTOLU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 10:11:20 -0400
In-Reply-To: <20090820030423.GA26357@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, mjg59 <mjg59@srcf.ucam.org>

On Thu, 20 Aug 2009, Shaohua Li wrote:

> > I don't understand the reason behind this.  Doesn't this sort of thing
> > belong in the bus and platform code, not in the PM core?  (In the case
> > of UHCI, it should be handled by the platform, in the same way as
> > remote wakeup gets enabled before the suspend.)
> > 
> > Drivers don't have to be involved at all.  When a wakeup signal is 
> > detected, the driver's runtime_resume method should get called -- 
> > nothing more is needed.
> The only case is UHCI in my mind. Because UHCI has non-standard wakeup event
> register.

That's an oversimplification.  _Some_ (I think) of _Intel's_ UHCI
implementations have a non-standard wakeup event register.

> If BIOS doesn't handle it correctly (for example, not clear the wakeup
> event after a GPE), we will keep see the wakeup event. And the bus/platform
> level has no knowledge to handle such event.

How is the wakeup event received?  Maybe for this one type of device a 
PCI quirk will solve the problem.

Or if that doesn't work, code can be added to uhci-hcd to turn off the
non-standard wakeup register as part of the resume routine.  (The
problem here is that the resume routine runs in process context so it
has to be called after the wakeup event handler has returned.)

Alan Stern

