From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot
 with apic=debug and send a report.  Then try booting with the 'noapic'
 option.
Date: Mon, 3 Jun 2013 19:26:24 +0800
Message-ID: <20130603112624.GA7623@localhost>
References: <20130602042033.GB16050@localhost>
 <51AC7B2C.5000204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27136 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756963Ab3FCL02 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jun 2013 07:26:28 -0400
Content-Disposition: inline
In-Reply-To: <51AC7B2C.5000204@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Jun 03, 2013 at 01:17:00PM +0200, Rafael J. Wysocki wrote:
> On 6/2/2013 6:20 AM, Fengguang Wu wrote:
> >Greetings,
> >
> >FYI, I got this occasionally in some of my machines when testing the
> >pm/bleeding-edge branch:
> >
> >[    0.040000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> >[    0.044000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> >[    0.044000] ...trying to set up timer (IRQ0) through the 8259A ...
> >[    0.044000] ..... (found apic 0 pin 2) ...
> >[    0.048000] ....... failed.
> >[    0.048000] ...trying to set up timer as Virtual Wire IRQ...
> >[    0.048000] ..... failed.
> >[    0.048000] ...trying to set up timer as ExtINT IRQ...
> >[    0.052000] ..... failed :(.
> >[    0.052000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the
> >+'noapic' option.
> >
> >Bisect result is unfortunately not reliable..
> 
> Can you please check if this is reproducible with the acpi-hotplug
> branch alone?

Nope, it also shows up in upstream kernel. Sorry.. I'll try more bisect.

Thanks,
Fengguang
