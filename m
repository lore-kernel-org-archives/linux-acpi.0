From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: controlling ACPI IRQ routing
Date: Fri, 28 Dec 2007 14:06:19 +0800
Message-ID: <1198821979.20548.9.camel@sli10-desk.sh.intel.com>
References: <47742083.5060903@howardsilvan.com>
	 <1198814721.20418.3.camel@sli10-desk.sh.intel.com>
	 <477489B8.20700@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38947 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbXL1GG7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Dec 2007 01:06:59 -0500
In-Reply-To: <477489B8.20700@howardsilvan.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: linux-acpi@vger.kernel.org


On Thu, 2007-12-27 at 21:29 -0800, Lee Howard wrote:
> Shaohua Li wrote:
> > In IOAPIC mode, interrupt priority isn't related with the pin (in your
> > case, irq 16 or 19), but the vector of the pin. How vector of a pin is
> > allocated is quite random. Usually driver who calls pci_enable_device
> > earier will get a lower priority vector.
> 
> You used the words "random" and "usually".  Could you elaborate on
> the 
> randomness and when usually doesn't apply?
> 
> So the means to prioritize a driver is to see that it gets installed 
> earlier?  There is no other mechanism to "reserve" pin vector 
> allocations for a specific device or driver?
Currently vector is allocated when pci_enable_device is called. So which
vector is allocated depends on how many drivers already called the
routine. The first vector is 0x31, later higher priority (higher) vector
will be allocated. In latest kernel, a vector of a irq could be variable
when irq affinity is set, so it's much complex. There is no existing
method to reserve a vector for a device.

Thanks,
Shaohua

