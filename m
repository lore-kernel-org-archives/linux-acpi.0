From: Adam Pigg <piggz1@gmail.com>
Subject: Re: Problems with Toshiba Satellite L355
Date: Fri, 6 Feb 2009 21:57:38 +0000
Message-ID: <200902062157.39694.adam@piggz.co.uk>
References: <200902052311.31794.adam@piggz.co.uk> <1233883554.3625.8.camel@localhost.localdomain>
Reply-To: adam@piggz.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:4249 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZBFWA1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 17:00:27 -0500
Received: by nf-out-0910.google.com with SMTP id d3so171264nfc.21
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2009 14:00:25 -0800 (PST)
In-Reply-To: <1233883554.3625.8.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi 
Another problem which may or may not be related to acpi, but i suspect it 
could be.

When i plug in my firewire expresscard while running it is not 
detected...nothing in dmesg or lspci.

But it does work if the card is in when the machine is switched on.

Cheers


Adam


On Friday 06 February 2009 01:25:54 yakui_zhao wrote:
> On Fri, 2009-02-06 at 07:11 +0800, Adam Pigg wrote:
> > Hi
> >
> > i have 2 acpi related (i think) problems with my satellite l355 which i
> > hope someone can help with.
> >
> > 1. /proc/acpi/ac_adapter.../state always show the correct state, but
> > acpi_listen and lshal --monitor dont see any un/plug events.
>
> Will you please do the following test?
>    a. kill the process which is using /proc/acpi/event (Use the command
> of "lsof /proc/acpi/event" to get the process ID)
>    b. grep . /sys/firmware/acpi/interrupts/* >interrupts_before;
>    c. cat /proc/acpi/event . then you plug/unplug the AC adapter and see
> whether the ACPI event can be reported
>    d. after the test, grep . /sys/firmware/acpi/interrupts/* >
> interrupts_after
>
>    If no ACPI event is reported, will you please file a bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
> output of acpidump, lspci -vxxx ?
>    Thanks.
>
> > 2. The machine will suspend to ram, resume, but after a second suspend,
> > wont resume.
>
>      Will you please add the boot option of "acpi_sleep=s3_beep" and do
> the following test?
>     a. kill the process which is using /proc/acpi/event
>     b. echo mem > /sys/power/state; dmesg >dmesg_after;
>     c. press the power button and see whether the box can be resumed.
>
>     If it can't be resumed, please reboot the system and check whether
> there exists the file of "dmesg_after".
>     Thanks.
>
> > I think i saw a similar sounding problem on an R500, but it was fixed.
> >
> > Ive attached the output of dmidecode, and am using 2.6.29rc3.
> >
> > Anything else that will  help let me know.
> >
> > Cheers
> >
> > Adam


