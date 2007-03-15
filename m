From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Gigabyte GA-M57SLI-S4 (the linuxbios compatible version)
 problems
Date: Thu, 15 Mar 2007 11:05:57 -0800
Message-ID: <20070315110557.ef1df0c8.akpm@linux-foundation.org>
References: <200703121210.15812.st@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:36592 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbXCOTGH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 15:06:07 -0400
In-Reply-To: <200703121210.15812.st@iss.tu-darmstadt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ST <st@iss.tu-darmstadt.de>
Cc: linux-acpi@vger.kernel.org

> On Mon, 12 Mar 2007 12:10:15 +0100 ST <st@iss.tu-darmstadt.de> wrote:
> Hi
> 
> I am trying to boot 2.6.20.2 on a Gigabyte GA-M57SLI-S4 with f7 stock bios.
> I get the message:
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ... failed.
> ...trying to set up timer as Virtual Wire IRQ... failed.
> ...trying to set up timer as ExtINT IRQ... failed :(.
> Kernel panic - not syncing: IO-APIC + timer doesn't work!
> 
> I can boot with noapic option but then i only have one processor (AMD X2 3800+ 
> stepping 02).
> 
> apic=debug doesn't give any more output than this. 
> 
> A bios update didn't help to the f7 version didn't help. This error is also 
> present with the debian stock kernel.
> 
> I thought that this MB should be pretty good supported, given the fact that 
> there is an linuxbios in the works for this MB or am i bitten by a HW 
> failure?
> 

Apparently pci=noacpi fixes this.

ST (what sort of a name is that?): please raise a report against ACPI
at bugzilla.kernel.org, thanks.
