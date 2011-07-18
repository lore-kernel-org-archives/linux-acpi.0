From: Ghislain Landry Tsafack Chetsa
	<ghislain.landry.tsafack.chetsa@ens-lyon.fr>
Subject: Re: Information request about acpi
Date: Mon, 18 Jul 2011 12:45:43 +0200
Message-ID: <20110718124543.17722x88gstou4lz@webmail.ens-lyon.fr>
References: <20110716235937.56583bwlckigm4sp@webmail.ens-lyon.fr>
 <alpine.LFD.2.02.1107161818110.4339@x980>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jabiru.ens-lyon.fr ([140.77.51.2]:46472 "EHLO
	jabiru.ens-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1GRKpr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2011 06:45:47 -0400
In-Reply-To: <alpine.LFD.2.02.1107161818110.4339@x980>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Quoting Len Brown <lenb@kernel.org>:

>
>> Sorry for disturbing, I am Tsafack Ghislain Landry, Ph.D. student at Ecole
>> Normale Superieure of Lyon, France. I have been trying to scale the  
>> frequency
>> on my Intel E5506 Xeon processor via the cpufreq_acpi driver  
>> unfortunately (I
>> have tested that feature using the following linux kernel versions : 2.6.32,
>> 2.6.38, 2.6.39, 2.6.39.3, and 3.0.rc7).  This a sample output
>>
>> # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>> 2128000
>> #echo 1862000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
>> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
>> 1862000
>> # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>> 2128000
>>
>> I have tried using the cpufreq-set util as well, but the result is the same.
>>
>> bellow is the content of the /proc/acpi/processor/CPU0/info file. I was
>> wandering whether the "no" value of the parameters  throttling  
>> control, limit
>> interface can fully explain that behavior.
>
> they are unrelated to this issue.
>
>> cat /proc/acpi/processor/CPU0/info
>> processor id:            0
>> acpi id:                 1
>> bus mastering control:   no
>> power management:        yes
>> throttling control:      no
>> limit interface:         no
>
>
> It is likely that you are obsering the effects of "hardware coordination."
> Although Linux treats all the cores as independent, and even treats
> HT threads as independent, they actually have dependencies.
>
> In particular, all threads inside a package share the same voltage
> regulator.
>
> So in a package if one core asks to go fast and another asks to go slow,
> the voltage will coordinated by hardware to support the most demanding
> request.  Since it is always a good idea to go at he maximum speed
> suported by the available voltage, the cpu that requests slow will
> also go fast, the same speed as his peer.
>
> boot with "maxcpus=1" and try again -- or control the speeds
> of the other threads on the system accordingly.
>
> cheers,
> -Len Brown, Intel Open Source Technology Center
>
>
>

Hi Brown,

Many thanks for your answer, you are right I got the problem fixed  
booting with "maxcpus=1"


Regards,

Tsafack Landry
