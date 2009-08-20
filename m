From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 11:24:50 +0800
Message-ID: <20090820032450.GD26357@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com> <20090819115210.GC12216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28264 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbZHTDYu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Aug 2009 23:24:50 -0400
Content-Disposition: inline
In-Reply-To: <20090819115210.GC12216@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Wed, Aug 19, 2009 at 07:52:10PM +0800, Matthew Garrett wrote:
> On Wed, Aug 19, 2009 at 03:24:11PM +0800, Shaohua Li wrote:
> 
> > Usually driver should does nothing in the op as bus can handle it. But in some
> > cases, like pci bus, UHCI controller doesn't use standard PME registers for
> > wakeup, instead of using special approach. In this case, UHCI controller driver
> > should implement this op.
> 
> I'm not averse to the general concept, but I'm not entirely sold on it 
> being necessary. All the hardware I'm aware of will send non-PME events 
> as a notification on a specific device. Under what circumstances will we 
> get a wakeup GPE for a non-PME device without knowing which device 
> should be woken?
Below code is gotten from a laptop (samsung-x10), the PCIB is the PCI bridge.
We can't guarantee the device which gets a wakeup event notification is really
the device which invokes the wakeup event.

	Device (PCIB)
        {
                Name (_ADR, 0x001E0000)
                Device (CDB0)
		{
		    Name (_ADR, 0x00030000)
		}
		 Device (CDB1)
                {
                    Name (_ADR, 0x00030001)

		}
	}


        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x01, \_SB.PCI0.PCIB.CDB0.PMES)
            Store (0x01, \_SB.PCI0.PCIB.CDB1.PMES)
        }

Thanks,
Shaohua
