From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Tue, 19 Nov 2013 14:10:39 +0100
Message-ID: <2999447.AHfmGpVCOl@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1431790.mopcNu4HUR@vostro.rjw.lan> <528B1429.6050403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63217 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751464Ab3KSM6C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2013 07:58:02 -0500
In-Reply-To: <528B1429.6050403@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Al Stone <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>, Robert Moore <robert.moore@intel.com>

On Tuesday, November 19, 2013 03:32:57 PM Hanjun Guo wrote:
> +CC Robert Moore
> 
> On 2013-11-18 21:37, Rafael J. Wysocki wrote:
> > On Monday, November 18, 2013 09:21:30 PM Hanjun Guo wrote:
> [...]
> >>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>>>>> Signed-off-by: Al Stone <al.stone@linaro.org>
> >>>>>> ---
> >>>>>>  drivers/acpi/Kconfig            | 8 ++++++++
> >>>>>>  include/acpi/platform/aclinux.h | 4 ++++
> >>>>>>  2 files changed, 12 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >>>>>> index 589da05..7bbd3b0 100644
> >>>>>> --- a/drivers/acpi/Kconfig
> >>>>>> +++ b/drivers/acpi/Kconfig
> >>>>>> @@ -354,6 +354,14 @@ config ACPI_BGRT
> >>>>>>         data from the firmware boot splash. It will appear under
> >>>>>>         /sys/firmware/acpi/bgrt/ .
> >>>>>>
> >>>>>> +config ACPI_REDUCED_HARDWARE
> >>>>>> +     bool "Hardware-reduced ACPI support"
> >>>>>> +     depends on !(IA64 || X86)
> >>>>>
> >>>>> Why don't you use
> >>>>>
> >>>>>         depends on (ARM || ARM64)
> >>>>>
> >>>>> here instead?
> >>>>>
> >>>>
> >>>> hardware-reduced is not restricted to ARM platforms, that's why
> >>>>
> >>>> I used depends on !(IA64 || X86) here.
> >>>
> >>> So what exactly are the other platforms using ACPI in the Linux kernel?
> >>>
> >>
> >> To telling the truth, I didn't see any other platform using ACPI except
> >> IA64, X86 and ARM/ARM64, I just used depends on !(IA64 || x86) for
> >> future purpose.
> > 
> > However, if you used "depends on ARM || ARM64" (the parens are not needed BTW),
> > the subsequent patches wouldn't need to check CONFIG_ARM/CONFIG_ARM64 in
> > addition to CONFIG_ACPI_REDUCED_HARDWARE.  That would simplify stuff somewhat.
> 
> Yes, you are right :)
> It is ok for me to use "depends on ARM || ARM64", but Robert Moore also
> suggested that hardware-reduced is not restricted to ARM platforms.

>From the ACPICA's point of view, it isn't.

In the kernel, however, x86 and ia64 are the only users of ACPI in addition to ARM.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
