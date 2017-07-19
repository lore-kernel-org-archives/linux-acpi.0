From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: ATK0110 GITM[0x6020011] ACPI exception: AE_BAD_PARAMETER errors
Date: Wed, 19 Jul 2017 15:04:48 +0100
Message-ID: <CAKPcRGpAGoHmGLEcpWubzwVnJ8396QPEKnKsUa_Kcao3VzvtVA@mail.gmail.com>
References: <c3774583-930e-a683-bf2f-0684689e12a4@internode.on.net>
 <CAKPcRGqKkUu3124kO+teFvDRuVkQHj1mgQxrmPfda7534HYQbQ@mail.gmail.com> <89f29b17-ebb3-6a0c-b806-16cde359a0f6@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33223 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdGSOEu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2017 10:04:50 -0400
Received: by mail-vk0-f41.google.com with SMTP id p193so774084vkd.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2017 07:04:50 -0700 (PDT)
In-Reply-To: <89f29b17-ebb3-6a0c-b806-16cde359a0f6@internode.on.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi,

On 10 July 2017 at 17:09, Arthur Marsh <arthur.marsh@internode.on.net> wrote:
>
>
> Luca Tettamanti wrote on 10/07/17 19:35:
>>
>> Hi,
>>
>> On 9 July 2017 at 05:35, Arthur Marsh <arthur.marsh@internode.on.net>
>> wrote:
>>>
>>> On post 4.12.0 kernels
>>
>>
>> So 4.11.9 works but 4.12 doesn't, correct?
>
>
> I tried the latest stock Debian 4.11, which is 4.11.6-1, which didn't have
> the ACPI exceptions.
>
>
>>
>>> on an ASUS M3A7A Pro motherboard, I've been getting
>>> messages about the asus_atk0110 module:
>>>
>>> am64:/usr/src/linux# dmesg|grep -i atk
>>> [   12.517304] ATK0110 ATK0110:00: hwmon_device_register() is deprecated.
>>> Please convert the driver to use hwmon_device_register_with_info().
>>> [   54.749748] ATK0110 ATK0110:00: GITM[0x6020011] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.752680] ATK0110 ATK0110:00: GITM[0x6020061] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.755502] ATK0110 ATK0110:00: GITM[0x6020062] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758310] ATK0110 ATK0110:00: GITM[0x6020063] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758390] ATK0110 ATK0110:00: GITM[0x6040013] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758466] ATK0110 ATK0110:00: GITM[0x6040073] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758527] ATK0110 ATK0110:00: GITM[0x60400c3] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758579] ATK0110 ATK0110:00: GITM[0x6030012] ACPI exception:
>>> AE_BAD_PARAMETER
>>> [   54.758631] ATK0110 ATK0110:00: GITM[0x6030074] ACPI exception:
>>> AE_BAD_PARAMETER
>>>
>>> This might be related to hard CPU lock-ups that I see later on, so for
>>> now
>>> I've unloaded the asus_atk0110 module to see if that prevents later
>>> lock-ups.
>>>
>>> I can supply more configuration/log information and run tests if anyone
>>> want
>>> them.
>>
>>
>> Can you please supply the full dmesg when booting with loglevel=7?
>> Also please attach a copy of the DSDT table
>> (/sys/firmware/acpi/tables/DSDT).

So I don't see anything strange in the DSDT and the fact that older
kernels work fine makes me think that something changed in acpica.
Rafael, you merged acpica post v4.12 (the last working kernel): can
you see anything that could have changed the way parameter validation
works?

L.
