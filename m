From: Rasmus Wiman <rasmus@wiman.org>
Subject: Re: Shuttle K48 and speedstep.
Date: Mon, 11 Jan 2010 03:51:57 +0100
Message-ID: <20100111035157.bbc6c768.rasmus@wiman.org>
References: <20100104223441.f72ee2fb.rasmus@wiman.org>
	<alpine.LFD.2.00.1001041728091.4012@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:60213 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702Ab0AKCwK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jan 2010 21:52:10 -0500
Received: from c83-250-247-209.bredband.comhem.se ([83.250.247.209]:58020 helo=verdandi.hemma.se.)
	by ch-smtp01.sth.basefarm.net with smtp (Exim 4.68)
	(envelope-from <rasmus@wiman.org>)
	id 1NUANr-0003KU-5S
	for linux-acpi@vger.kernel.org; Mon, 11 Jan 2010 03:52:01 +0100
In-Reply-To: <alpine.LFD.2.00.1001041728091.4012@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> wrote:

> > Since speedstep with 45ns processors apparently works in windows,
> > would it be wrong to assume that windows (or whatever drivers
> > Shuttle provide for windows) keeps a bunch of extra SSDT:s around
> > and kludges them in if a 45ns CPU is present?
> > 
> > Both acpidumps are attached and if someone creates some kind of
> > patch I'll of course try it.
> 
> Your observation is correct.
> When the e2140 is installed, the RSDT has an SSDT in it
> that is absent when the 5300 is present.  The tables
> are otherwise identical.  The SSDT contains the _OSC,
> _PDC; and based on what happens at run-time, they load
> a dynamic SSDT which presumably includes the cpufreq
> related methods.  You will likely find that table
> under /sys/firmware/acpi/tables/dynamic/
> 
> (we should update acpidump to look there too).
> 
> So it looks like the BIOS doesn't recognize one of the CPUs,
> so i recommend that you look for an update.
> 
> Yes, I'm sure that Windows can handle speedstep on
> 45nm processors, and I'm sure that Linux can to --
> but not using the BIOS on this box.  Did you run
> windows on this BIOS and speedstep worked?
> That would be puzzling.

I didn't run windows on the box, Robert Szalai, who created the
original thread, claimed to have done it. But I just located a spare
hard drive, connected it to the K48 and installed Windows 7 beta on it.
And yes, according to CPU-Z speedstep is actually working using this
bios, with the 5300, on this box.

What's the next step from here? Could CPU-Z be lying? If I would
extract the ACPI tables from within windows, would they look the same
as they do when I do an acpidump from Linux? Is there a good tool for
extracting ACPI tables from within windows?

thanks,
Rasmus W
