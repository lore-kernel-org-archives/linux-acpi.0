From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 00/16] Convert WMI to a proper bus
Date: Sat, 27 May 2017 23:01:16 +0300
Message-ID: <CAHp75Vc=fFvqf2OKEAisObkBkbHdD+RjE-kK2FDeg1GyX36v5w@mail.gmail.com>
References: <cover.1495862272.git.dvhart@infradead.org> <3214691.4YNsAb1L33@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35058 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdE0UBS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 16:01:18 -0400
In-Reply-To: <3214691.4YNsAb1L33@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, May 27, 2017 at 10:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, May 26, 2017 10:31:14 PM Darren Hart wrote:
>> From: "Darren Hart (VMware)" <dvhart@infradead.org>
>>
>> This series is based on the original work of
>> Andy Lutomirski <luto@amacapital.net> [1]. I have made minor edits, and in
>> one instance, squashed two patches in which the latter undid the former.
>>
>> This series converts WMI [2] into a proper bus, adds some useful information via
>> sysfs, and exposes the embedded MOF [3] binary. It converts dell-wmi to use the
>> new WMI bus architecture.
>>
>> This is the first part of an ongoing effort to enhance the WMI infrastructure
>> within the kernel, and eventually expose WMI to userspace for the consumption of
>> management utilities as it was intended.
>>
>> 1. https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=platform/wmi
>> 2. https://msdn.microsoft.com/en-us/library/windows/hardware/dn614028(v=vs.85).aspx
>> 3. https://msdn.microsoft.com/en-us/library/aa823192(v=vs.85).aspx
>>
>> Andy Lutomirski (15):
>>   platform/x86: wmi: Drop "Mapper (un)loaded" messages
>>   platform/x86: wmi: Pass the acpi_device through to parse_wdg
>>   platform/x86: wmi: Clean up acpi_wmi_add
>>   platform/x86: wmi: Track wmi devices per ACPI device
>>   platform/x86: wmi: Turn WMI into a bus driver
>>   platform/x86: wmi: Fix error handling when creating devices
>>   platform/x86: wmi: Split devices into types and add basic sysfs attributes
>>   platform/x86: wmi: Probe data objects for read and write capabilities
>>   platform/x86: wmi: Instantiate all devices before adding them
>>   platform/x86: wmi: Incorporate acpi_install_notify_handler
>>   platform/x86: wmi: Add a new interface to read block data
>>   platform/x86: wmi: Bind the platform device, not the ACPI node
>>   platform/x86: wmi: Add an interface for subdrivers to access sibling devices
>>   platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
>>   platform/x86: dell-wmi: Convert to the WMI bus infrastructure
>>
>> Darren Hart (VMware) (1):
>>   platform/x86: wmi: Require query for data blocks, rename writable to setable
>>
>>  drivers/platform/x86/Kconfig    |  12 +
>>  drivers/platform/x86/Makefile   |   1 +
>>  drivers/platform/x86/dell-wmi.c | 136 ++++----
>>  drivers/platform/x86/wmi-mof.c  | 125 ++++++++
>>  drivers/platform/x86/wmi.c      | 677 ++++++++++++++++++++++++++++++++--------
>>  include/linux/wmi.h             |  59 ++++
>>  6 files changed, 815 insertions(+), 195 deletions(-)
>>  create mode 100644 drivers/platform/x86/wmi-mof.c
>>  create mode 100644 include/linux/wmi.h
>
> All of this makes sense from the ACPI core perspective, so
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, Rafael.

> for the series and I'm assuming that it will go in via the platform/x86 tree.

Correct.

-- 
With Best Regards,
Andy Shevchenko
