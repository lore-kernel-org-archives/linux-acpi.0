From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 17:33:36 +0100
Message-ID: <200812061733.37471.mheinz@cs.uni-frankfurt.de>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061426.08294.mheinz@cs.uni-frankfurt.de> <20081206162649.GA7623@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:52158 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301AbYLFQdr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 11:33:47 -0500
In-Reply-To: <20081206162649.GA7623@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Am Samstag, 6. Dezember 2008 schrieb Matthew Garrett:
> On Sat, Dec 06, 2008 at 02:26:07PM +0100, Matthias Heinz wrote:
> lspci -vxxx -s 00:02.0

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset 
Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])
        Subsystem: Samsung Electronics Co Ltd Device c03e
        Flags: bus master, fast devsel, latency 0, IRQ 316
        Memory at fc000000 (64-bit, non-prefetchable) [size=4M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 1800 [size=8]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
        Capabilities: [d0] Power Management version 3
00: 86 80 42 2a 07 04 90 00 07 00 00 03 00 00 80 00
10: 04 00 00 fc 00 00 00 00 0c 00 00 d0 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 14 3e c0
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 48 00 00 00 09 00 0a 11 88 70 00 1e
50: 01 80 50 03 19 00 00 00 00 00 00 00 00 00 00 be
60: 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 05 d0 01 00 0c 30 e0 fe 81 41 00 00 00 00 00 00
a0: 00 00 00 00 09 00 06 20 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 40 01 00 00
d0: 01 00 23 00 00 00 00 00 00 00 00 00 34 00 00 00
e0: 00 00 00 00 00 00 00 00 00 80 00 1a 41 20 00 00
f0: 09 08 34 07 ff 00 00 00 a0 0f 07 00 20 10 b6 bd


> and
>
> cat /proc/dri/0/i915_gem_interrupt

Interrupt enable:    00000053
Interrupt identity:  00000000
Interrupt mask:      fffedfae
Pipe A stat:         00040000
Pipe B stat:         00400206
Interrupts received: 41
Current sequence:    180
Waiter sequence:     0
IRQ sequence:        92



Regards,
Matthias
