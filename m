From: ST <st@iss.tu-darmstadt.de>
Subject: Re: Gigabyte GA-M57SLI-S4 (the linuxbios compatible version) problems
Date: Fri, 16 Mar 2007 22:54:29 +0100
Message-ID: <200703162254.29451.st@iss.tu-darmstadt.de>
References: <200703121210.15812.st@iss.tu-darmstadt.de> <20070315110557.ef1df0c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lnx130.hrz.tu-darmstadt.de ([130.83.174.24]:34882 "EHLO
	lnx130.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965983AbXCPWCZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Mar 2007 18:02:25 -0400
In-Reply-To: <20070315110557.ef1df0c8.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

Hi

> > I am trying to boot 2.6.20.2 on a Gigabyte GA-M57SLI-S4 with f7 stock
> > bios. I get the message:
> > ENABLING IO-APIC IRQs
> > ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > ...trying to set up timer (IRQ0) through the 8259A ... failed.
> > ...trying to set up timer as Virtual Wire IRQ... failed.
> > ...trying to set up timer as ExtINT IRQ... failed :(.
> > Kernel panic - not syncing: IO-APIC + timer doesn't work!
> >
> > I can boot with noapic option but then i only have one processor (AMD X2
> > 3800+ stepping 02).
> >
> > apic=debug doesn't give any more output than this.
> >
> > A bios update didn't help to the f7 version didn't help. This error is
> > also present with the debian stock kernel.
> >
> > I thought that this MB should be pretty good supported, given the fact
> > that there is an linuxbios in the works for this MB or am i bitten by a
> > HW failure?
>
> Apparently pci=noacpi fixes this.
Affirmative, aparentlly it doesn't work without this parameter.

> ST (what sort of a name is that?): please raise a report against ACPI
It's an short pseudonym to keep an low search engine profile.
> at bugzilla.kernel.org, thanks.
It's reported as bug 8219. I can't debug with serial console (since i have 
only one machine at this place) but i'm happy to test patches and stuff. Just 
tell me :-).

Regards
ST
