From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after
 suspend
Date: Wed, 30 Jul 2014 16:32:48 +0800
Message-ID: <20140730083248.GA31763@aaronlu.sh.intel.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
 <53D7AF8F.7060401@intel.com>
 <CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26392 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbaG3Ic6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2014 04:32:58 -0400
Content-Disposition: inline
In-Reply-To: <CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Marsden <john.d.marsden@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Jul 29, 2014 at 07:20:59PM +0100, John Marsden wrote:
> On 29 July 2014 15:28, Aaron Lu <aaron.lu@intel.com> wrote:
> > Please attach acpidump to the Ubuntu bug page.
> 
> I installed acpidump from the Ubuntu Software Centre and tried running
> it with the following result:
>     sudo acpidump -z
> 
>    Intel ACPI Component Architecture
>    ACPI Binary Table Dump Utility version 20140214-64 [Mar 29 2014]
>    Copyright (c) 2000 - 2014 Intel Corporation
> 
>    Cannot map /dev/mem
>    Could not map table at 0x00000000000F0030 length FEDA0000
>    Could not get ACPI tables, AE_ACCESS

Hmm, no idea why this occured.
The acpidump utility is available in the kernel tree:
linux/tools/power/acpi

> 
> I'm out of my depth with this.  However, with Google's help I found
> https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt
> at the end of which it says:
> "Alternatively, used ACPI tables can be retrieved via sysfs in latest
> kernels: /sys/firmware/acpi/tables"
> Using this hint I've saved the binary files from sysfs and then used
> "acpidump -f filename" to create the file I've uploaded to the Ubuntu
> bug.  Please advise if I need to follow some other procedure to get
> what you want.

It works, thanks.

> 
> > BTW, do you always have this problem or it starts to occur
> > from some kernel version?
> 
> While triaging the bug on Ubuntu we've gone as far back as Ubuntu
> 12.04.0 (Precise) which is what I first installed on the computer in
> question.  It's been present in all versions we tested.
> 
> > Please also list your /sys/class/backlight with v3.16-rc kernel.
> I trust this is what you require:
> 
>  ls -l /sys/class/backlight
> total 0
> lrwxrwxrwx 1 root root 0 Jul 29 17:06 acpi_video0 ->
> ../../devices/pci0000:00/0000:00:02.0/backlight/acpi_video0
> lrwxrwxrwx 1 root root 0 Jul 29 17:06 intel_backlight ->
> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
> lrwxrwxrwx 1 root root 0 Jul 29 17:06 toshiba ->
> ../../devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/backlight/toshiba
> 
> /sys/class/backlight/acpi_video0/* {cat or ls -l}
>   actual_brightness: 7
>   bl_power: 0
>   brightness: 7
>   device -> ../../../0000:00:02.0
>   max_brightness: 7
>   power/async:  disabled
>   power/autosuspend_delay_ms - Input/output error
>   power/control:  auto
>   power/runtime_active_kids:  0
>   power/runtime_active_time:  0
>   power/runtime_enabled:  disabled
>   power/runtime_status:  unsupported
>   power/runtime_suspended_time:  0
>   power/runtime_usage:  0
>   subsystem -> ../../../../../class/backlight
>   type: firmware
>   uevent:
> 
> /sys/class/backlight/intel_backlight/* {cat or ls -l}
>   actual_brightness: 249
>   bl_power: 0
>   brightness: 249
>   device -> ../../card0-LVDS-1
>   max_brightness: 4539
>   power/async:  disabled
>   power/autosuspend_delay_ms - Input/output error
>   power/control:  auto
>   power/runtime_active_kids:  0
>   power/runtime_active_time:  0
>   power/runtime_enabled:  disabled
>   power/runtime_status:  unsupported
>   power/runtime_suspended_time:  0
>   power/runtime_usage:  0
>   subsystem -> ../../../../../../../class/backlight
>   type: raw
>   uevent:
> 
> /sys/class/backlight/toshiba/* {cat or ls -l}
>   actual_brightness: 7
>   bl_power: 0
>   brightness: 7
>   device -> ../../../TOS6208:00
>   max_brightness: 7
>   power/async:  disabled
>   power/autosuspend_delay_ms - Input/output error
>   power/control:  auto
>   power/runtime_active_kids:  0
>   power/runtime_active_time:  0
>   power/runtime_enabled:  disabled
>   power/runtime_status:  unsupported
>   power/runtime_suspended_time:  0
>   power/runtime_usage:  0
>   subsystem -> ../../../../../../class/backlight
>   type: platform
>   uevent:
> 
> 
> Thank you for your help.  John

You are welcome.

I checked the dsdt table, the ACPI backlight interface makes use of SMI
to do the backlight control(because of the 0xb2 io port write). It's
beyond our control so I don't know how to fix the problem.

Does the other interface work after resume? I mean the intel_backlight
and the toshiba one?

Thanks,
Aaron
