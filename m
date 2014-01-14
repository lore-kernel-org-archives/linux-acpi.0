From: Bradley Baetz <bbaetz@gmail.com>
Subject: Re: Multiple video backlight devices on Dell laptop
Date: Tue, 14 Jan 2014 23:34:23 +1100
Message-ID: <CAJrk0Bt42pBAHCYu7uPmyDs1oy5QcMNpnzc2YgHy7iBXX+4tWw@mail.gmail.com>
References: <CAJrk0Bv5w25vipp8vTmoZEegb-7Va+FLvek=QnTvSfHDFjvroA@mail.gmail.com>
	<52D4A5C4.5000405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35201 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaANMeZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 07:34:25 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so308855wgg.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2014 04:34:24 -0800 (PST)
In-Reply-To: <52D4A5C4.5000405@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Jan 14, 2014 at 1:49 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> On 01/11/2014 11:22 AM, Bradley Baetz wrote:
>> Hi,
>>
>> I have a Dell Vostro 3560 laptop, with hybrid graphics (intel + radeon).
>>
>> This exposes 3 backlight devices - acpi_video0, acpi_video1, and
>> intel_backlight. Only the intel_backlight/brightness file actually
>> changes the backlight. Is this a kernel bug, or should userspace
>> 'know' which backlight file to use based on which graphics device is
>> active? XFCE picks the first one it finds (acpi_video0), which doesn't
>> work.
>
> Solving it from userspace:
> You can specify which backlight interface to use by editing /etc/xorg.conf:
>  Section "Device"
>     Identifier  "Intel Graphics"
>     Driver      "intel"
>     Option      "AccelMethod"     "sna"
>     Option      "Backlight"       "intel_backlight" # use your backlight that works here
>     Driver      "intel"
>     BusID       "PCI:0:2:0"
>  EndSection
>
> See https://wiki.archlinux.org/index.php/Backlight
>
> solving it from kernel space:
> Since the firmware claims support of win8, you can forget the
> acpi_backlight=vendor cmdline option and just use video.use_native_backlight=1.

Thanks, that commandline option works on 3.13-rc.

Bradley
