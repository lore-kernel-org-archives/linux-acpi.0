From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Debugging spurious wakeup
Date: Wed, 13 May 2015 07:46:09 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301501164@SHSMSX101.ccr.corp.intel.com>
References: <20150513065825.GA10680@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47494 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbbEMHry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 03:47:54 -0400
In-Reply-To: <20150513065825.GA10680@sottospazio.it>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Please attach the output of "cat /proc/acpi/wakeup".

Thanks,
rui

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Gianluca Anzolin
> Sent: Wednesday, May 13, 2015 2:58 PM
> To: linux-acpi@vger.kernel.org
> Subject: Debugging spurious wakeup
> 
> Hello,
> 
> I have a curious problem with my system: whenever I wake up the PC with a
> WOL magic packet and then power it off the systems comes back to life after
> a couple of seconds, by itself.
> 
> I can reproduce the problem 100% of the times.
> 
> I've been having this problems for years. I remember this same issue
> occurred also with my previous computer, with a different mainboard. My
> current system has an ASUS P8B-WS mb with a Xeon 1275v2 CPU.
> 
> I've ruled out in the time many factors: traffic on the net (by disconnecting
> the cable), RTC alarms (by disabling them)... long story short: I'm stuck.
> 
> While I'm not the only one with this issue (see[1]), some people have
> reported mixed success by blacklisting some components (xhci-pci) or by
> setting unrelated BIOS options. Unfortunately these workarounds never
> worked for me.
> 
> So I'm here to ask if there is a way to get the source/cause of the last wakeup
> by setting some ACPI debug option. This way I could at least pinpoint the
> device/interface that caused the spontaneous wakeup and then debug
> further or at least disable it.
> 
> I've tried to enable the ACPI hardware-related messages with the kernel
> arguments: acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
> 
> Unfortunately I can't see the information I'm looking for in the resulting
> output. Should I enable some other debug_layer? Could anybody point me in
> the right direction?
> 
> Thank you and best regards,
> 
> Gianluca
> 
> [1] https://bbs.archlinux.org/viewtopic.php?id=173648
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
