From: Len Brown <lenb@kernel.org>
Subject: Re: No c2-c7 states on core i7
Date: Mon, 23 Nov 2009 11:11:54 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231101150.858@localhost.localdomain>
References: <4B06A7A8.109@slagter.name>
 <1258945512.3773.33.camel@localhost.localdomain>
 <4B0A4D62.2040001@slagter.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:64595 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZKWQML (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2009 11:12:11 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTK00HSBKZV960D@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Nov 2009 10:12:08 -0600 (CST)
In-reply-to: <4B0A4D62.2040001@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: ykzhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

> > Will you please attach the output of acpidump on the machine with the
> > core i7 cpu?
> > Please attach the output of every file
> > under /sys/firmware/acpi/tables/dynamic/SSDT*?
> >     cat /sys/firmware/acpi/tables/dynamic/SSDT1>  ssdt1
> >
> > Please also attach the output of /proc/cpuinfo.

> Thank you for your attention. This specific issue has already been solved for
> me, it turns out be yet another bios issue (as I have experienced before).
> Enable base clock setting and all C states are gone!
> 
> But now I have a few other issues that maybe you can help me with:
> 
> - How are intel core i7 C states mapped to linux C states? Both my laptop
> (core2duo T9300) and desktop (core i7 920) should have c1-c3-c6-c7, but on
> both machines linux only sees c1-c2-c3.

It is up to the BIOS to map hardware C-states to software visible 
C-states.  How the BIOS does that would be answered by the information
that Yakui requested above.

In particular, most BIOS today use the _CST object in the DSDT
or in an SSDT.

> - On said desktop, I see no difference in power consumption with c states
> enabled or disabled; if they're enabled (and base clock control is off...)
> linux is using c3 almost all of the time, but power consumption remains the
> same (about 110 watts for the complete motherboard, is that normal?).

No, that isn't normal. C-states on modern processors generally
save a lot of energy.

If you run powertop and you find that you are over 99% idle
and you save no energy compared to when you are 0% idle
(say a copy of "cat /dev/zero > /dev/null" for each core)
then something is wrong with your system.

> - From a quick inspection of the acpi tables (I am not quite an expert on
> this...) it looks like a number of _CST objects are exported with default bios
> settings, while with base clock control enabled, these are gone. I would to
> try (yes I know, not recommended, etc.) to copy the _CST objects from the one
> boot instance's tables to the other. Now I think of it, it would probably even
> suffice to boot one time with baseclock control disabled, record the acpi
> tables (SSDT?) and then make the kernel use that in subsequent boots with the
> base clock control enabled (with all other bios settings the same, off
> course). Is that difficult to achieve? I seem to remember that's possible one
> way or another.

It is possible, but as soon as you reverse engineer and over-ride
something in the BIOS, you are on very thin ice.  Presumably
the BIOS engineer made a concious decision to disable C-states 
when you over-clock your board and had a reason to do so.

Maybe the more important question is what measurable benefit
you get when you over-clock your board, and if you really need that...

-Len Brown
Intel Open Source Technology Center

