From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot
 with apic=debug and send a report.  Then try booting with the 'noapic' option.
Date: Mon, 03 Jun 2013 13:17:00 +0200
Message-ID: <51AC7B2C.5000204@intel.com>
References: <20130602042033.GB16050@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10269 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3FCLRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2013 07:17:30 -0400
In-Reply-To: <20130602042033.GB16050@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-acpi@vger.kernel.org

On 6/2/2013 6:20 AM, Fengguang Wu wrote:
> Greetings,
>
> FYI, I got this occasionally in some of my machines when testing the
> pm/bleeding-edge branch:
>
> [    0.040000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.044000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> [    0.044000] ...trying to set up timer (IRQ0) through the 8259A ...
> [    0.044000] ..... (found apic 0 pin 2) ...
> [    0.048000] ....... failed.
> [    0.048000] ...trying to set up timer as Virtual Wire IRQ...
> [    0.048000] ..... failed.
> [    0.048000] ...trying to set up timer as ExtINT IRQ...
> [    0.052000] ..... failed :(.
> [    0.052000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the
> +'noapic' option.
>
> Bisect result is unfortunately not reliable..

Can you please check if this is reproducible with the acpi-hotplug 
branch alone?

Rafael

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

