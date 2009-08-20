From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 08:40:51 +0100
Message-ID: <20090820074050.GA30288@srcf.ucam.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com> <20090819115210.GC12216@srcf.ucam.org> <20090820032450.GD26357@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39617 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZHTHlC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 03:41:02 -0400
Content-Disposition: inline
In-Reply-To: <20090820032450.GD26357@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Thu, Aug 20, 2009 at 11:24:50AM +0800, Shaohua Li wrote:
> On Wed, Aug 19, 2009 at 07:52:10PM +0800, Matthew Garrett wrote:
> > I'm not averse to the general concept, but I'm not entirely sold on it 
> > being necessary. All the hardware I'm aware of will send non-PME events 
> > as a notification on a specific device. Under what circumstances will we 
> > get a wakeup GPE for a non-PME device without knowing which device 
> > should be woken?
> Below code is gotten from a laptop (samsung-x10), the PCIB is the PCI bridge.
> We can't guarantee the device which gets a wakeup event notification is really
> the device which invokes the wakeup event.

_L0B will only be triggered if a PME is generated, so we'll be able to 
determine which device generated the wakeup by looking at the PME 
registers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
