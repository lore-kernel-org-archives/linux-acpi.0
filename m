From: Len Brown <len.brown@intel.com>
Subject: Re: SMP C-states on x86_64 Status
Date: Tue, 14 Nov 2006 01:41:42 -0500
Message-ID: <200611140141.42657.len.brown@intel.com>
References: <1162903911.32119.275205906@webmail.messagingengine.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37577 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755441AbWKNGjG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Nov 2006 01:39:06 -0500
In-Reply-To: <1162903911.32119.275205906@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Tuesday 07 November 2006 07:51, Mathew Brown wrote:
> .... For my 16 core machine, cat
> /proc/acpi/processor/*/power gives the following:
> 
> active state:  C1
> default state: C1
> bus master activity:   00000000
> states:
>   *C1:      promotion[--] demotion[--] latency[000] usage[0000000000]
>     C2:      <not supported>
>     C3:      <not supported>
> 
> So I gather that this means that even with CPU frequency scaling, I'm
> really not doing anything since the voltage and power going to the CPU
> are going to be constant until I upgrade to 2.6.18.  Am I correct?

C-states and P-states are somewhat independent.
You are not going to grow new C-states with a software upgrade.
If the processor at hand supports "Enhanced" C-states, then
it is going to reduce voltage automatically when you enter C1.

If your processor supports P-states, but not enhanced C-states,
then how much power you save in C1 will depend on what
P-state you were in when you entered C1.  This is because
even though you're running at 0MHz in C1, the lower voltage
will result in less power lost to leakage.

Running Linux's "ondemand" governor is pretty good at
getting you into a power saving P-state promptly, so if
you run that, then you're doing about as good as you can.
(you can compare it to "powersave" governor if you want
 to see what the lower power possible is)

You can see if you have P-states by poking about in
/sys/devices/system/cpu/cpu*/cpufreq/

modprobe cpufreq_states
will create a stats directory under there that will tell you
what P-states you are using.

cheers,
-Len
