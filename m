From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Leave modalias empty for devices
 which are not present
Date: Mon, 30 Oct 2017 23:23:00 +0100
Message-ID: <CAJZ5v0i2196_=tqM+zahZyGMYGB2ovBr9kvoSWZ_Y-gfd8zqAw@mail.gmail.com>
References: <20171015192449.16035-1-hdegoede@redhat.com> <CAJZ5v0hAx_-OUQNBngScNKHstZhZ42A42LwcBOFhR2g5pCFXOA@mail.gmail.com>
 <2550330b-38ff-28b1-6294-d55462c03cca@redhat.com> <cb4224a1-05fa-c46a-8447-0e742fa89cec@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:52364 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753373AbdJ3WXC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Oct 2017 18:23:02 -0400
Received: by mail-io0-f193.google.com with SMTP id f20so30739128ioj.9
        for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2017 15:23:02 -0700 (PDT)
In-Reply-To: <cb4224a1-05fa-c46a-8447-0e742fa89cec@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Oct 30, 2017 at 2:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 16-10-17 13:44, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 16-10-17 01:47, Rafael J. Wysocki wrote:
>>>
>>> On Sun, Oct 15, 2017 at 9:24 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Most Bay and Cherry Trail devices use a generic DSDT with all possible
>>>> peripheral devices present in the DSDT, with their _STA returning 0x00
>>>> or
>>>> 0x0f based on AML variables which describe what is actually present on
>>>> the board.
>>>>
>>>> Since ACPI device objects with a 0x00 status (not present) still get an
>>>> entry under /sys/bus/acpi/devices, and those entry had an acpi:PNPID
>>>> modalias, userspace would end up loading modules for non present
>>>> hardware.
>>>>
>>>> This commit fixes this by leaving the modalias empty for non present
>>>> devices. This results in 10 modules less being loaded with a generic
>>>> distro kernel config on my Cherry Trail test-device (a GPD pocket).
>>>
>>>
>>> Well, what about hotplug?
>>>
>>> On some systems _STA may change from 0 to nonzero for some devices, so
>>> what's going to happen to the modalias then?
>>
>>
>> A good question. I would expect a change uevent to be generated in
>> this case and when the device has become present in this new uvent the
>> modalias will no longer be empty and the module will get loaded, so
>> the module will not get loaded until the actual hotplug.
>>
>> The actual generation of this uevent should be done by the various
>> subsystems based on ACPI_RECONFIG_DEVICE_ADD messages, at which point
>> adev->status is already updated and then when the subsys calls
>> acpi_device_uevent_modalias() for the new uevent it will return a
>> non-empty modalias.
>
>
> Rafael, how do you want to move forward with this patch ?

Not sure yet, sorry.
