From: Len Brown <lenb@kernel.org>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Fri, 14 Jun 2013 15:32:20 -0400
Message-ID: <CAJvTdKkAy3P=vL=Z5yy31FTvrPNx=Bv11zq-XPi+HeexL=90dg@mail.gmail.com>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
	<20130612134002.GA15317@srcf.ucam.org>
	<1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov>
	<20130612183249.GA20957@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:60248 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3FNTcV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2013 15:32:21 -0400
Received: by mail-wg0-f52.google.com with SMTP id b12so831482wgh.31
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2013 12:32:20 -0700 (PDT)
In-Reply-To: <20130612183249.GA20957@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Larry Baker <baker@usgs.gov>, linux acpi <linux-acpi@vger.kernel.org>, Rob E Russell <robr@us.ibm.com>

Hi Larry,

Thanks for the note.

I use two Westmere systems:
An Extreme Edition X980 on an Intel DX58SO motherboard,
and a pair of Xeon X5680's on a Intel S5520SC motherboard.

Both processors model 0x2c, and thus subject to this errata.

Both system are running the latest BIOS and firmware from Intel.
Both systems enable and use CC6 and PC6, by default.
This is true whether they are running ACPI idle
(such as Windows would do, or acpi_idle in Linux)
or Linux's intel_idle driver.

This suggests that the fix is not to disable PC6 on model 0x2c.
I would expect, as Matthew does, that the "BIOS workaround"
is likely something to do with how the BIOS initialization code sets
up the memory controller...  But in the event that the real fix
is to disable PC6 and Intel itself has not updated its own BIOS
to comply with its own errata, I'll contact the hardware designers
to see if I can get a more fact-based response.

So I concur with Matthew.
If you are concerned about configuration of your chip-set,
then you want to run the latest BIOS from the the vendor.
A Linux workaround doesn't currently look warranted.

thanks,
-Len Brown, Intel Open Source Technology Center

ps.

Yes, we have an issue that intel_idle doesn't respect when
the BIOS "disables" C-states via ACPI tables.  Indeed,
part of the value proposition of intel_idle is that it is immune
to ACPI table bugs that crop up from system to system.
Also, intel_idle is not subject to some of the limitations of ACPI.
We believe this is one of the reasons that Linux on Intel
is better than some other operating systems on Intel.

The OEMs such as Dell, HP and IBM are accustomed to having
control in the BIOS and so they are unhappy about losing
that capability.  We do hear them, but unfortunately it will
likely be the Haswell Server generation before we can give their
BIOS programmers that absolute control back by
empowering them to modify CPUID.MWAIT.EDX --
which is how the HW enumerates C-states.

This issue comes up mostly when latency sensitive
customers want to disable the high latency C-states.
In the past, the OEM could configure their BIOS to
handle that situation.  But with modern Linux,
a cmdline param such as intel_idle.max_cstate=N
is necessary.  OEM's don't like Linux cmdline params,
they prefer BIOS control.

As Matthew pointed out, the Linux community believes
that the answer for latency-sensitive customers is
to use Linux PM-QOS to tell the machine how
the customer wants it to run.  From a Linux point
of view, this is a universal solution, it requires
no BIOS SETUP tweaks and no kernel cmdline parms.

BTW. If the workaround for the errata were actually
to disable C6, it would be (Package) PC6, not (Core) CC6.
The BIOS already has control over Package C-states,
and if the BIOS doesn't lock the MSR, Linux also
has that capability.

Get the latest turbostat from the kernel tree
and run turbostat -v
and look for a line like this:

cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06008403 (demote-C3, demote-C1,
locked: pkg-cstate-limit=3: pc6)

cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06000403 (demote-C3, demote-C1,
UNlocked: pkg-cstate-limit=3: pc6)

As described in the Intel Software Developer's Manual,
this MSR, MSR_PKG_CST_CONFIG_CONTROL has a package C-state limit field.
Above it limits the hardware to PC6, but could easily be set to PC3.

In one of the examples above, the register was locked by the BIOS,
preventing Linux from modifying it, in the 2nd example, it is unlocked.

if we limited the package to PC3 here, then Linux would still choose CC6,
but when all the cores entered CC6, the deepest the package would
go would be PC3.
