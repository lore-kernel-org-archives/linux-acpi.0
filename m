From: "Eric Benton" <benton71@gmail.com>
Subject: How ACPI is actually implemented?
Date: Sun, 26 Nov 2006 19:35:33 +0200
Message-ID: <29545330611260935l507b7853g8ec3bb1597a3c884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:53476 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935467AbWKZRff (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Nov 2006 12:35:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so965685uga
        for <linux-acpi@vger.kernel.org>; Sun, 26 Nov 2006 09:35:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm trying to figure out how ACPI is implemented, I don't know if this
list is the right one to ask but I'm sure there are kind people in
this place that will help me in my quest :)
I tried to look for resources but I couldn't find too many. I'm
interested to know how ACPI works in the hardware level... so, after a
lot of reading I left with these questions, any knowledge provided is
greatly appreciated.

By looking at /proc/irq and /proc/ioports I can see that ACPI is
allocated with IRQ9 and I/O ports 0x400-0x42F.
1. How does exactly a hardware device generates an event?
2. How does the OS asks a device to change it's state? what *exactly* happens?

I read that the BIOS supplies all the ACPI tables.
3. Are they are being built in compile time (this is what I understand
from the FAQ at Intel's website)?
4. What happens If a new PCI device is being added to the system, how
the DSDT is being updated? (If at all...)

I saw a note about an ACPI Controller.
5. What exactly is the role of this controller? How it operates? And who
6. In general, I'm looking to find out what is the role (in respect to
"talking with the hardware") of these entities: the driver, the
device, the OS (including the CA)? Who reads/writes to the I/O ports.
Who sets the IRQ? the controller? or is it the device itself? What
happens exactly?

I tried reading the ACPI spec, but it's 600+ pages that doesn't answer
these questions...

Thanks in advance,
Eric.
