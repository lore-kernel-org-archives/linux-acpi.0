From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Wed, 21 Nov 2007 20:48:42 +0100
Message-ID: <64bb37e0711211148x5383e1d3n3bd7fd86bb68d7d@mail.gmail.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
	 <4743CC0B.9000508@linux.vnet.ibm.com>
	 <20071120221839.faab108e.akpm@linux-foundation.org>
	 <200711211422.32908.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:54346 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbXKUTsn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Nov 2007 14:48:43 -0500
Received: by py-out-1112.google.com with SMTP id u77so7436509pyb
        for <linux-acpi@vger.kernel.org>; Wed, 21 Nov 2007 11:48:42 -0800 (PST)
In-Reply-To: <200711211422.32908.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

On Nov 21, 2007 8:22 PM, Len Brown <lenb@kernel.org> wrote:
> On Wednesday 21 November 2007 01:18, Andrew Morton wrote:
> > On Wed, 21 Nov 2007 11:41:23 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
>
> > > SMP alternatives: switching to UP code
> > > ACPI: Core revision 20070126
> > > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
>
> did previous kernels print this too?

Not since my last BIOS upgrade.

This is from what dmesg's I still had laying around:
2.6.22-rc6-mm1: No
2.6.23-rc1-mm1, 2.6.23-rc2-mm1, 2.6.23-rc3-mm1: Yes
2.6.23-rc3-mm1 after BIOS upgrade: No
2.6.23-rc4-mm1...2.6.24-rc2-mm1: No

> > > Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
> >
> > ACPI or x86 breakage, I guess.
>
> If you suspect ACPI breakage, then try "acpi=off" or "acpi=noirq".

ACPI doesn't look guilty.
acpi=noirq:
[   39.905884] Freeing SMP alternatives: 28k freed
[   39.910674] ACPI: Core revision 20070126
[   39.916542] ACPI: setting ELCR to 0e20 (from 0c20)
[   39.921855] ExtINT not setup in hardware but reported by MP table
[   39.928244] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   39.934586] Kernel panic - not syncing: IO-APIC + timer doesn't
work! Try using the 'noapic' kernel parameter
[   39.934587]

acpi=off:
[    0.000000] Freeing SMP alternatives: 28k freed
[    0.000000] ExtINT not setup in hardware but reported by MP table
[    0.000000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.000000] Kernel panic - not syncing: IO-APIC + timer doesn't
work! Try using the 'noapic' kernel parameter
[    0.000000]

Torsten
