From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: v2.6.26-rc9: ACPI PCI irq routing on NUMA? + early_ioremap
 trouble
Date: Fri, 18 Jul 2008 13:59:12 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807181302020.12125@cliff.in.clinika.pl>
References: <19f34abd0807060647k54490088uf8859d8a1646fd41@mail.gmail.com>
 <200807171245.31641.bjorn.helgaas@hp.com>  <19f34abd0807171358p3c5a44f9i91ab23d3f5e9671f@mail.gmail.com>
  <Pine.LNX.4.55.0807180117320.6536@cliff.in.clinika.pl>
 <19f34abd0807180051i544367b7s64f32d601af31296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kirk.serum.com.pl ([213.77.9.205]:61333 "EHLO serum.com.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752948AbYGRNAN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 09:00:13 -0400
In-Reply-To: <19f34abd0807180051i544367b7s64f32d601af31296@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>, Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Gleixner <tglx@linutronix.de>, venkatesh.pallipadi@intel.com, Huang Ying <ying.huang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 18 Jul 2008, Vegard Nossum wrote:

> I have done this for the bad case:
> http://folk.uio.no/vegardno/linux/netconsole2.txt

 Thanks.  The MP table looks broken:

Bus #4 is ISA
I/O APIC #32 Version 32 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 4, IRQ 00, APIC ID 2, APIC INT 00

etc. (notice the different I/O APIC IDs reported), so any changes to our
code are not at fault.  I suggest you ask your vendor to fix it up (did
they test it at all? -- it has no chance to work) or stick to ACPI (I can
see it has been automatically disabled for some reason).

 Anyway, the piece of I/O APIC code in question should not poke at the
local APIC, so I'll prepare a fix to make it check for the APIC ID being
-1.

> (I added a warning for certain APIC errors as well. Not that it adds
> much in this particular case, but I think it would be good to have in
> mainline anyway, to highlight these error cases in the future...)

 It might be useful indeed.

  Maciej
