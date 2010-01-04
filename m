From: Len Brown <lenb@kernel.org>
Subject: Re: Shuttle K48 and speedstep.
Date: Mon, 04 Jan 2010 17:37:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001041728091.4012@localhost.localdomain>
References: <20100104223441.f72ee2fb.rasmus@wiman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:57186 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab0ADWhX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 17:37:23 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVQ00B8UUTUKVH5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 04 Jan 2010 16:37:12 -0600 (CST)
In-reply-to: <20100104223441.f72ee2fb.rasmus@wiman.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rasmus Wiman <rasmus@wiman.org>
Cc: linux-acpi@vger.kernel.org



thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 4 Jan 2010, Rasmus Wiman wrote:

> Hi everybody,
> 
> a few months ago I bought myself a Shuttle K48 to use with Vortexbox as
> a media PC. I put in an old Intel Pentium dual-core E2140 that I had
> lying around. However, even after getting a better fan I still found it
> a bit on the noisy side, so I decided to try a 45ns cpu and got a dual
> core E5300. Better, but now speedstep stopped working.
> 
> modprobe -v acpi_cpufreq
> 
> gives me:
> 
> FATAL: Error inserting acpi_cpufreq
> (/lib/modules/2.6.30.10-105.fc11.i686.PAE/kernel/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.ko):
> No such device
> 
> By googling a bit I found the thread "[Help] I can't get Intel
> Speedstep working" on this list, started in march by Robert Szalai, who
> uses a Core 2 duo E7200, which seems to be essentially the same cpu as
> the 5300 but with faster bus speed etc.
> 
> Since I still had the E2140 (Speedstep actually works with that CPU), I
> put it back in so I could do an acpidump with that cpu and compare the
> outputs. It seems to me that an SSDT is there when the E2140 is
> installed, and when I substitute the 5300 it goes away. Also, a few
> bytes in the RSDT differ. The SSDT definitely looks like it contains
> speedstep related stuff even though I know nothing about iasl.
> 
> Since speedstep with 45ns processors apparently works in windows, would
> it be wrong to assume that windows (or whatever drivers Shuttle provide
> for windows) keeps a bunch of extra SSDT:s around and kludges them in
> if a 45ns CPU is present?
> 
> Both acpidumps are attached and if someone creates some kind of patch
> I'll of course try it.

Your observation is correct.
When the e2140 is installed, the RSDT has an SSDT in it
that is absent when the 5300 is present.  The tables
are otherwise identical.  The SSDT contains the _OSC,
_PDC; and based on what happens at run-time, they load
a dynamic SSDT which presumably includes the cpufreq
related methods.  You will likely find that table
under /sys/firmware/acpi/tables/dynamic/

(we should update acpidump to look there too).

So it looks like the BIOS doesn't recognize one of the CPUs,
so i recommend that you look for an update.

Yes, I'm sure that Windows can handle speedstep on
45nm processors, and I'm sure that Linux can to --
but not using the BIOS on this box.  Did you run
windows on this BIOS and speedstep worked?
That would be puzzling.

thanks,
Len Brown, Intel Open Source Technology Center



