From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Automatic S1 sleep
Date: Thu, 20 May 2010 09:51:23 -0400
Message-ID: <4BF53E5B.9080404@cfl.rr.com>
References: <4BE97FC9.4040302@cfl.rr.com> <alpine.LFD.2.00.1005120133190.5297@localhost.localdomain> <4BEAAF7C.6070004@cfl.rr.com> <alpine.LFD.2.00.1005200000430.2921@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-3.exch016.msoutlookonline.net ([207.5.72.226]:40493
	"EHLO EXHUB016-3.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571Ab0ETNv2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 May 2010 09:51:28 -0400
In-Reply-To: <alpine.LFD.2.00.1005200000430.2921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On 5/20/2010 12:07 AM, Len Brown wrote:
> PCI power states are a blunt instrument for comlicated graphics cards,
> which really should be power managed via the native hardware drivers,
> which know about all the internal hardware modes and sub-states.

Unfortunately I'm getting the feeling that the PCI power states are
really unimplemented, even when they claim to be, for this sort of
reason.  So far I have yet to find a device that uses any less power
when I place it in any D state other than D0.

The datasheet for this Intel e100 series NIC in one machine I have says
that D1 should save some power while remaining active, and D2 should
power down the PHY and loose link, but no matter which state I put it
in, even D3, it still continues to transmit and receive packets just fine.

My new Dell Vostro v13 laptop has a realtek gigabit ethernet and the
wifi adapter behave the same; no power saved even when put in D1-D3.

> I think you'll see quicker deep idle states -- but they'll be
> states folded into cpuidle rather than system-wide states like S1.

Yes, I've spent the last few days looking into making sure other devices
are in low power states and that the cpu is in its deepest sleep state
on my new laptop.  I've been pouring over the Intel datasheets to see if
the Celeron ULV 1.3 GHz cpu is capable of more than the C1 and C2 states
that the bios acpi tables export.  From what I can tell, the cpu
supports 3 C states and my bios simply skips C2 since it is essentially
the same as C1, and according to powertop, spends most of its time in
MWAIT(C3).  It appears that the chipset is capable of deeper sleep
states that also lower the voltage below what it normally can operate
at, even to the point that the L2 cache must be invalidated, but I think
that this requires support from the cpu, rather than something that the
chipset can do on its own.  Specifically I think that the cpu needs to
execute the proper MWAIT instruction to send a message on the MSI bus
telling the chipset it is going into the deeper state, and alter the
output on its vid pins to lower the core voltage, and it seems this
particular cpu does not support that.
