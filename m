From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Wed, 19 Aug 2009 10:49:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191044060.3001-100000@iolanthe.rowland.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50872 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751952AbZHSOt3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 10:49:29 -0400
In-Reply-To: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, mjg59 <mjg59@srcf.ucam.org>

On Wed, 19 Aug 2009, Shaohua Li wrote:

> Introduce .wakeup_event(). When a device gets a wakeup event,
> the callback is called. The callback usually should check if the device
> really invokes wakeup event and disable wakeup event if yes.
> 
> Usually driver should does nothing in the op as bus can handle it. But in some
> cases, like pci bus, UHCI controller doesn't use standard PME registers for
> wakeup, instead of using special approach. In this case, UHCI controller driver
> should implement this op.

I don't understand the reason behind this.  Doesn't this sort of thing
belong in the bus and platform code, not in the PM core?  (In the case
of UHCI, it should be handled by the platform, in the same way as
remote wakeup gets enabled before the suspend.)

Drivers don't have to be involved at all.  When a wakeup signal is 
detected, the driver's runtime_resume method should get called -- 
nothing more is needed.

Alan Stern

