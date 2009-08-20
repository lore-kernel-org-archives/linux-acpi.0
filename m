From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 11:04:23 +0800
Message-ID: <20090820030423.GA26357@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com> <Pine.LNX.4.44L0.0908191044060.3001-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9940 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbZHTDEX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Aug 2009 23:04:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908191044060.3001-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, mjg59 <mjg59@srcf.ucam.org>

On Wed, Aug 19, 2009 at 10:49:30PM +0800, Alan Stern wrote:
> On Wed, 19 Aug 2009, Shaohua Li wrote:
> 
> > Introduce .wakeup_event(). When a device gets a wakeup event,
> > the callback is called. The callback usually should check if the device
> > really invokes wakeup event and disable wakeup event if yes.
> > 
> > Usually driver should does nothing in the op as bus can handle it. But in some
> > cases, like pci bus, UHCI controller doesn't use standard PME registers for
> > wakeup, instead of using special approach. In this case, UHCI controller driver
> > should implement this op.
> 
> I don't understand the reason behind this.  Doesn't this sort of thing
> belong in the bus and platform code, not in the PM core?  (In the case
> of UHCI, it should be handled by the platform, in the same way as
> remote wakeup gets enabled before the suspend.)
> 
> Drivers don't have to be involved at all.  When a wakeup signal is 
> detected, the driver's runtime_resume method should get called -- 
> nothing more is needed.
The only case is UHCI in my mind. Because UHCI has non-standard wakeup event
register. If BIOS doesn't handle it correctly (for example, not clear the wakeup
event after a GPE), we will keep see the wakeup event. And the bus/platform
level has no knowledge to handle such event.

Thanks,
Shaohua
