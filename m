From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: controlling ACPI IRQ routing
Date: Thu, 27 Dec 2007 21:29:28 -0800
Message-ID: <477489B8.20700@howardsilvan.com>
References: <47742083.5060903@howardsilvan.com> <1198814721.20418.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:42236 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbXL1F3a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Dec 2007 00:29:30 -0500
In-Reply-To: <1198814721.20418.3.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

Shaohua Li wrote:
> In IOAPIC mode, interrupt priority isn't related with the pin (in your
> case, irq 16 or 19), but the vector of the pin. How vector of a pin is
> allocated is quite random. Usually driver who calls pci_enable_device
> earier will get a lower priority vector.

You used the words "random" and "usually".  Could you elaborate on the 
randomness and when usually doesn't apply?

So the means to prioritize a driver is to see that it gets installed 
earlier?  There is no other mechanism to "reserve" pin vector 
allocations for a specific device or driver?

Thanks,

Lee.
