From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: /proc/acpi/ removal plan
Date: Fri, 19 Sep 2008 10:12:25 +0800
Message-ID: <7C8E86B73C916D47820B1A143DB97BC00887719AEE@pdsmsx502.ccr.corp.intel.com>
References: <200809181633.m8IGX1s7019188@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40054 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720AbYISCM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Sep 2008 22:12:58 -0400
In-Reply-To: <200809181633.m8IGX1s7019188@hera.kernel.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@hera.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>

>From: Len Brown [mailto:lenb@hera.kernel.org]
>Sent: Friday, September 19, 2008 12:33 AM
>To: dmitry.torokhov@gmail.com; linux-acpi@vger.kernel.org; rjw@sisk.pl; Zhang,
>Rui
>Subject: Re: /proc/acpi/ removal plan
>
>> processor throttling state I/F
>> As processor T-state is used for thermal control only,
>> processor t-state is mapped to a cooling_device's cooling_state
>> in the generic thermal driver, combined with the processor's p-state.
>
>> # ls -l /sys/class/thermal/cooling_device0/
>
>When I scribble into cur_state
>I do not see anything reflected in
>/proc/acpi/processor/*/throttling
>
>Also, max_state is 10, when surely my processor
>has only 8 T-states.
>
the cooling state of processor is a combination of p-state and t-state.
because reducing the frequency is preferred when system is overheat.
e.g cooling state 0 mean processor can be run in the maximum frequency, and it's in the T0 state. And cooling state 9 means processor is in the minimum frequency, T7 state.

>If user-space can not provoke processor T-states via this I/F,
>then those using the old /proc I/F will flag it as a regression
>when it goes away.  (even if few should ever need it)
>
>> wakeup control,
>> /sys/devices/.../wakeup should be in the todo list. :)
>
>I thought that Rafael said the wakeup file
>in the device tree was working now -- at least
>for PCI devices, no?
>
Rafael's patch did bind the "wakeup" file together with the ACPI device.
It calls the acpi_enable_wakeup_device_power of the ACPI device, but it doesn't touch the wakeup GPE at all. So, I don't think it actually works...

>I think the biggest problem with sysfs wakeup is that every
>device in the tree gets a wakeup file, even if it
>has no wakeup capability...
>
that's okay.
The wakeup file return null string if it doesn't have the wakeup ability.
To be honest, there is one thing that I'm still concerned about.
The wakeup file is a runtime device wakeup flag rather than a system wakeup flag.
i.e. "enabled" means that the device can be suspend/resumed at runtime.
It doesn't ensure that it can wakeup the system from a sleep state.
If /proc/acpi/wakeup is replaced by the /sys/devices/.../wakeup, users may be confused because the device can not wakeup the system even if the wakeup file is set to "enabled".

>
>>  button sys I/F can be found at /sys/class/input/.
>> e.g.
>> # cat /sys/class/input/input*/device/hid
>> LNXPWRBN
>> PNP0C0C
>
>The /proc files for power and sleep buttons simply
>told us what kind of button they were, just info, not API.
>
>The functional one is PNP0C0D, the lid switch.
>It is also reflected in /sys/class/input, but I don't
>see a way to find from /sys the open/closed state
>like we have in /proc.  (I ran into this when I tried
>to delete the button /proc I/F some time ago).
>
You're right. Lid device still needs such an I/F.

Thanks,
Rui



