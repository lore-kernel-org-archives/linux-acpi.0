From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Fri, 21 Aug 2009 14:33:50 +0800
Message-ID: <20090821063350.GA16694@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com> <20090819115210.GC12216@srcf.ucam.org> <20090820032450.GD26357@sli10-desk.sh.intel.com> <20090820074050.GA30288@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1144 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZHUGdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 02:33:49 -0400
Content-Disposition: inline
In-Reply-To: <20090820074050.GA30288@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Thu, Aug 20, 2009 at 03:40:51PM +0800, Matthew Garrett wrote:
> On Thu, Aug 20, 2009 at 11:24:50AM +0800, Shaohua Li wrote:
> > On Wed, Aug 19, 2009 at 07:52:10PM +0800, Matthew Garrett wrote:
> > > I'm not averse to the general concept, but I'm not entirely sold on it 
> > > being necessary. All the hardware I'm aware of will send non-PME events 
> > > as a notification on a specific device. Under what circumstances will we 
> > > get a wakeup GPE for a non-PME device without knowing which device 
> > > should be woken?
> > Below code is gotten from a laptop (samsung-x10), the PCIB is the PCI bridge.
> > We can't guarantee the device which gets a wakeup event notification is really
> > the device which invokes the wakeup event.
> 
> _L0B will only be triggered if a PME is generated, so we'll be able to 
> determine which device generated the wakeup by looking at the PME 
> registers.
Right, but the event is sent to a bridge. The devices under the bridge invoke
wakeup event, not the bridge itself. So you must scan all devices under the
bridge to check which device has its PME registers set.
So the bridge case isn't what you said (notification always sent to a specific
device which invokes the wakeup event)

Thanks,
Shaohua
