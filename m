From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24 Temperature/speed _not_ normal - no thermal throttling?
Date: Wed, 20 Feb 2008 12:27:25 +0300
Message-ID: <47BBF27D.7040701@gmail.com>
References: <47BBC627.8020907@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:1679 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbYBTJ1b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 04:27:31 -0500
Received: by an-out-0708.google.com with SMTP id d31so605785and.103
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 01:27:30 -0800 (PST)
In-Reply-To: <47BBC627.8020907@fnal.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ron Rechenmacher <ron@fnal.gov>
Cc: linux-acpi@vger.kernel.org

Hi Ron,

Throttling is meant as a last line of defense before powering-off 
machine, and not a thermal regulation feature.
Please check if you have cpufreq compiled in and able to change frequency.
Please open a bug report at bugzilla.kernel.org against ACPI/Thermal.
Please attach dmesg output and 'grep . /proc/acpi/thermal/*/*'

Thanks,
Alex.

Ron Rechenmacher wrote:
> Hi,
> I believe I am having a critical thermal problem. I do not know if it
> is limited to the 2.6.24.2 kernel which I am running. I do see there 
> has been some discussion  about thermal zones and throttling on the 
> list, but I can not tell if it means that thermal throttling is not 
> working in 2.6.24.2
>
> When I try to build several kernel source rpms, my dell d830 laptop 
> seems to over heat and hang. It's happened 3 times now and I would 
> like to learn what's going on and not let it happen again.
>
> I'm a newbie (and have had problems trying to post :), so I do 
> apologize if I've missing something relatively simple or if this is 
> post is not appropriate in any way.
>
> I'm running a Scientific Linux 5 (based on RHEL5) distribution and am 
> just running a cpuspeed user space utility --- and therefor do not 
> believe I have any user space process watching temperature. However, 
> in the earlier kernels, I use to be able to (manually) write to 
> /proc/acpi/processor/CPU0/throttling and see a change when read back, 
> but now the write does not seem to do anything. This might be OK as I 
> 'm thinking the kernel and/or the hardware itself might now suppose to 
> be doing the throttling?
>
> Anyway, in 3 windows, I run:
>  win1: stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 180s
>  win2: while sleep 1;do cat /proc/acpi/thermal_zone/THM/temperature;done
>  win3: tail -f /var/log/messages
>  win4; while sleep 1;do cat /proc/acpi/processor/CPU0/throttling;done
>
> In win2, I see the temperature go from 50 C  to over 86 C.
> In win3, before, the temp in win2 reaches 70 C, I see "kernel: CPU0: 
> Temperature/speed normal" (and also CPU1) and "kernel: Machine check 
> events logged"
> The temperature would probably just continue to climb if I ran the 
> test for longer that 180 seconds (the kernel rpms take much longer and 
> do not complete before the system hangs :(
>
> In /var/log/mcelog, (running mcelog-0.8pre), I only see "Processor 
> core below trip temperature. Throttling disabled" messages. This is 
> strange because it seems to be being disabling after never being 
> enabled.  (Is there a newer mcelog I should be running?)
>
> The fan speed does increase, but the throttling state indication never 
> changes (it's always "T0: 100%"). It seems that when I build the 
> kernel rpms, the increased fan speed is not enough to keep the 
> temperature form running away. It seems that thermal throttling would 
> be required and is not happening.
> Should I be doing something from user space? Can I do something from 
> user space?
>
> Thanks,
> Ron
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

