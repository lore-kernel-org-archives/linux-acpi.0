From: Thomas Renninger <trenn@suse.de>
Subject: Re: Core i7 & C-States
Date: Fri, 19 Nov 2010 01:59:31 +0100
Message-ID: <201011190159.32152.trenn@suse.de>
References: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38590 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760062Ab0KSA7e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Nov 2010 19:59:34 -0500
In-Reply-To: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Oliver <oliver.greg2@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 17 November 2010 09:34:43 pm Greg Oliver wrote:
> Hi,
> 
> This is my first motherboard with ACPI issues, so I am in uncharted
> water. It is an intel board, so no overclocking, etc.  Reading through
> as much as I can this morning, I have hit the wall.  I have
> disassembled all of my [DS]SDTs, and will attach them with a dmesg as
> this seems to be the normal request from the archives.
> 
> About the issue though -
> 
> If I enable either/or C-STATES/C2-STATES,
How do you enable them? I expect you disable them (disabling these
does vary depending whether intel_idle or acpi_idle is used, see below)?
> the system will freeze on 
> boot.  Disabling them both the system runs fine, but I would obviously
> like the power savings if possible.  Now I know this BIOS has some
> issues as some PCI devices (when disabled in the BIOS) still get
> partially enumerated and assigned IRQs on the bus as well, but that
> does not concern me as much as the power.  The latest update to the
> BIOS from intel is installed.
Interesting.
Which kernel are you running?
With latest kernel intel_idle should be used for C-states on such
a new CPU and it will totally
ignore ACPI C-state information. If it works, it's due to ACPI tables.
You can check here:
cat /sys/devices/system/cpu/cpuidle/current_driver
That should show acpi_idle if processor.ko driver is used and ACPI
tables are used or intel_idle.

> This is the only ACPI error I get from dmesg currently though:
> 
> ACPI Warning: Incorrect checksum in table [SSDT] - 3F, should be 91
> (20090903/tbutils-314)
Probably irrelvant to C-states.
> 
> I have also booted with "acpi.debug_layer=0xFFFFFFFF
> acpi.debug_level=0x80000000" appended to my kernel cmdline and I am
> unsure why, but even though the system showed all debugs enabled in
> /sys, I did not receive any extra debug messages in dmesg!?!?
For C-states this debug facility does not help much.

If intel_idle also freezes the machine, you should open a bug on
bugzilla.kernel.org, please add me and Len Brown to CC then.

     Thomas
