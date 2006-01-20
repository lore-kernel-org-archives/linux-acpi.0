From: Thomas Renninger <acpi@renninger.de>
Subject: Re: acpi on the sony tx1xp vaio laptop
Date: Fri, 20 Jan 2006 09:12:51 +0100
Message-ID: <43D09B83.1030905@renninger.de>
References: <e1868cfe0601181717m47dbb220l92d2b70033ca4655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:48533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750714AbWATIMq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 03:12:46 -0500
In-Reply-To: <e1868cfe0601181717m47dbb220l92d2b70033ca4655@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Minty <mintywalker@gmail.com>
Cc: linux-acpi@vger.kernel.org

Minty wrote:
> hello,
> 
> I've got a Sony TX1XP laptop running Kubuntu [1].
> 
> There are a couple of acpi things that I'd love to be improved on this
> machine, so I'm offering to help out if I can - but I could use some
> direction from someone who has a clue about acpi and it's workings. 
> I'm happy enough (although not that great at) kernel compiling if need
> be.  Fwiw, I know of two others running some linux variant on this
> machine/hardware.
> 
> Main issue:
> /proc/acpi/fan exists, but is empty.
> Fan comes on for about 20 sec, off for 5 secs, repeat.
> Regardless of cpu temp.
> 
> cpu temp is accurately reported, normally sitting at 61C, but I've
> seen it go higher when the machine is under load.  thermal_zone
> reports passive cooling, but aside from reporting the temp, anything
> that might be set is reported as "<setting not supported>".  It
Passive/active cooling resets new trip point values exported by BIOS.
If this is not supported(nearly none machine does) override them
manually(see below).
> appears that cpu throttling works via
> /proc/acpi/processor/CPU0/throttling but this doesn't appear to alter
> the behaviour of the fan.
Lower the passive trip point(s). You need to play arround a bit to
find your preferred performance/accoustic balance.
The kernel will lower cpufreq as soon as you reach passive temp.
As fans are mostly controlled by BIOS, this is a good and mostly only
solution to get your machine quiet.
Not sure whether kubuntu already includes powersave/kpowersave packages,
AFAIK they exist.
There you can define schemes and it will override the trip points
as defined (you still need to define them manually as a perfect value 
needs a bit of watching the temps and listening to the fan activity 
of a machine). You can switch the schemes as you wish then...
This makes only sense if your machine supports cpufreq! Throttling is bad
and makes your machine unusable slow.
(test -d /sys/devices/system/cpu/cpu0/cpufreq && echo "cpufreq supported").
You also can simply override the values by:
echo "CRITICAL:HOT:PASSIVE:ACTIVE[0]:ACTIVE[1]" >/proc/acpi/thermal_zone/X/trip_points
You need to pass all five values, not defined values (do a cat before) will be
ignored. Be careful with the critical trip point value, you shouldn't use 
another value than the one defined by BIOS!

    Thomas
