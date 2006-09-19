From: Andrew Morton <akpm@osdl.org>
Subject: Fw: 2.6.18-rc7 boot only with acpi=off
Date: Tue, 19 Sep 2006 12:10:02 -0700
Message-ID: <20060919121002.9b73fcd8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751946AbWISTKK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Sep 2006 15:10:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kyle Wong <kylewong1974@hotmail.com>



Begin forwarded message:

Date: Tue, 19 Sep 2006 22:07:00 +0800
From: "Kyle Wong" <kylewong1974@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc7 boot only with acpi=off


Hi,

My new Intel E6300 with Intel DQ965GF motherboard does not boot 2.6.18-rc7, 
it just freeze at:
...........
...........
PCI: Using MMConfig at f0000000
ACPI: Interpeter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0[ (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0

then nothing more. It boots with "acpi=off" option, but it will lose one 
core and EIST! Fedora 5 stock kernel 2.6.15.x also have the same behavier.

The motherboard is already updated with latest BIOS.

Vanilla kernel 2.6.17.13 boot well without the "acpi=off" option.

Please cc me if possible. Thank you

Kyle

_________________________________________________________________
Get 10Mb extra storage for MSN Hotmail. Subscribe Now! 
http://join.msn.com/?pgmarket=en-hk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
