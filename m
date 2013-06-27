From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Sys backlight is empty since landing of "ACPI / PCI: Make PCI
 root driver use struct acpi_scan_handler"
Date: Thu, 27 Jun 2013 09:38:49 +0800
Message-ID: <51CB97A9.30704@intel.com>
References: <117469492.1598370.1372275060043.JavaMail.root@qzdev.se> <1463901.DnHXCr77ks@vostro.rjw.lan> <450286594.1598749.1372279129153.JavaMail.root@qzdev.se> <2662547.VNNgPCsUL0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42312 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3F0BiX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 21:38:23 -0400
In-Reply-To: <2662547.VNNgPCsUL0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Cork <kernel@box.qzdev.se>
Cc: linux-acpi@vger.kernel.org

On 06/27/2013 06:08 AM, Rafael J. Wysocki wrote:
> On Wednesday, June 26, 2013 08:38:49 PM Cork wrote:
>> // Cork
> 
> OK, thanks.
> 
> The initialization ordering obviously changed in 3.9 and the ACPI video
> driver fails to find your backlight device.
> 
> Can you please tell me what the output of
> 
> $ find /sys/devices/ -name LNXVIDEO\*
> 
> is on your system in 3.9 and 3.8?

This should be the same problem as bug 58091, where one of the reporter
is using a similar system Clevo_P150HMx. And I've checked the ACPI dump
of Cork's system, there is also a _ROM method under PCI0.

Cork,
Possible to test v3.10-rc6 or later kernels? There is a fix for your
problem, thanks.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=58091

-Aaron

> 
> Rafael
> 
> 
>>
>> ----- Original Message -----
>>> From: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> To: "Cork" <kernel@box.qzdev.se>
>>> Cc: linux-acpi@vger.kernel.org, "Aaron Lu" <aaron.lu@intel.com>
>>> Sent: Wednesday, 26 June, 2013 10:05:38 PM
>>> Subject: Re: Sys backlight is empty since landing of "ACPI / PCI: Make PCI root driver use struct acpi_scan_handler"
>>>
>>> On Wednesday, June 26, 2013 09:52:46 PM Rafael J. Wysocki wrote:
>>>> On Wednesday, June 26, 2013 07:31:00 PM Cork wrote:
>>>>> Hello. This is my first time sending a report like this, so
>>>>> please excuse me if I'm missing some vital information.
>>>>>
>>>>> From updating the kernel in Arch linux to 3.9 the brightness
>>>>> controls stopped working on my Clevo P0150HM. I have tried the
>>>>> acpi_backlight=vendor boot parameter but it makes no difference.
>>>>>
>>>>> While researching this problem I've found that
>>>>> /sys/class/backlight is empty in the versions where the buttons
>>>>> isn't working. Bisecting points to
>>>>> 00c43b9682507dc622c03172fde1032e2a216e9d [1] as the first commit
>>>>> showing the symptoms.
>>>>>
>>>>> Attached is the output from journalctl -b _TRANSFORM=kernel for
>>>>> the two versions. Not sure what other useful information I can
>>>>> provide apart from that, so please direct me if there is
>>>>> something missing.
>>>>>
>>>>> [1]
>>>>> https://github.com/torvalds/linux/commit/00c43b9682507dc622c03172fde1032e2a216e9d
>>>>
>>>> Interesting.
>>>>
>>>> Please send the output of acpidump from your machine.
>>>
>>> Also please put initcall_debug into the kernel command line and send
>>> dmesg from
>>> the working and not working kernels with that.
>>>
>>> Thanks,
>>> Rafael
>>>
>>>
>>> --
>>> I speak only for myself.
>>> Rafael J. Wysocki, Intel Open Source Technology Center.
>>>

