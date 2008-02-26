From: Thomas Renninger <trenn@suse.de>
Subject: Re: 2.6.24 Temperature/speed _not_ normal - no thermal throttling?
Date: Tue, 26 Feb 2008 13:31:37 +0100
Message-ID: <1204029097.4995.154.camel@queen.suse.de>
References: <47BBC627.8020907@fnal.gov>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:32902 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbYBZMbk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 07:31:40 -0500
In-Reply-To: <47BBC627.8020907@fnal.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ron Rechenmacher <ron@fnal.gov>
Cc: linux-acpi@vger.kernel.org

On Wed, 2008-02-20 at 00:18 -0600, Ron Rechenmacher wrote:
> Hi,
> I believe I am having a critical thermal problem. I do not know if it
> is limited to the 2.6.24.2 kernel which I am running. I do see there has 
> been some discussion  about thermal zones and throttling on the list, 
> but I can not tell if it means that thermal throttling is not working in 
> 2.6.24.2
> 
> When I try to build several kernel source rpms, my dell d830 laptop 
> seems to over heat and hang. It's happened 3 times now and I would like 
> to learn what's going on and not let it happen again.
> 
> I'm a newbie (and have had problems trying to post :), so I do apologize 
> if I've missing something relatively simple or if this is post is not 
> appropriate in any way.
> 
> I'm running a Scientific Linux 5 (based on RHEL5) distribution and am 
> just running a cpuspeed user space utility --- and therefor do not 
> believe I have any user space process watching temperature. However, in 
> the earlier kernels, I use to be able to (manually) write to 
> /proc/acpi/processor/CPU0/throttling and see a change when read back, 
> but now the write does not seem to do anything. This might be OK as I 'm 
> thinking the kernel and/or the hardware itself might now suppose to be 
> doing the throttling?
> 
> Anyway, in 3 windows, I run:
>   win1: stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 180s
>   win2: while sleep 1;do cat /proc/acpi/thermal_zone/THM/temperature;done
>   win3: tail -f /var/log/messages
>   win4; while sleep 1;do cat /proc/acpi/processor/CPU0/throttling;done
> 
> In win2, I see the temperature go from 50 C  to over 86 C.
> In win3, before, the temp in win2 reaches 70 C, I see "kernel: CPU0: 
> Temperature/speed normal" (and also CPU1) and "kernel: Machine check 
> events logged"
> The temperature would probably just continue to climb if I ran the test 
> for longer that 180 seconds (the kernel rpms take much longer and do not 
> complete before the system hangs :(
> 
> In /var/log/mcelog, (running mcelog-0.8pre), I only see "Processor core 
> below trip temperature. Throttling disabled" messages. This is strange 
> because it seems to be being disabling after never being enabled.  (Is 
> there a newer mcelog I should be running?)
> 
> The fan speed does increase, but the throttling state indication never 
> changes (it's always "T0: 100%"). It seems that when I build the kernel 
> rpms, the increased fan speed is not enough to keep the temperature form 
> running away. It seems that thermal throttling would be required and is 
> not happening.
> Should I be doing something from user space? Can I do something from 
> user space?

Does cleaning the fan slots help?

If not it might be related to this one:
https://bugzilla.novell.com/show_bug.cgi?id=333043
Even these are ThinkPads (and the temperature for some reason seem to be
20 C higher than on others - same model, very weird...), those are
running at the very edge of passive and critical thermal trip points.
It seems a kernel change came in some time ago which makes them shutdown
because the thermal notification for the passive trip point is not
executed and passed fast enough to the cpufreq layer.
On the ThinkPads it is easily reproducable by starting several CPU
intensive tasks (e.g. a one thread kernel compile works, CPU is lowered,
make -j5 will hang).

This could only be the case if your machine defines a passive trip point
and supports cpufreq:
/proc/acpi/thermal_zone/*/trip_points

   Thomas

