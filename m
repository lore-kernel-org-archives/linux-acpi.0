From: Mayuresh Chitale <mchitale@apm.com>
Subject: Re: ACPI support for optee driver
Date: Wed, 20 Sep 2017 22:07:05 +0530
Message-ID: <CAL-zptMbqW7opSFgsF-gd9icu1p9qYcFVt1GM6vrKB3JAPQ_+A@mail.gmail.com>
References: <CAL-zptO3xg4k_B_S1SfKOghHGAUjqp56W9vqDdV3xgpUJ6b8dQ@mail.gmail.com>
 <20170920103918.GA4630@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:49402 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdITQhG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Sep 2017 12:37:06 -0400
Received: by mail-pf0-f173.google.com with SMTP id l188so1789126pfc.6
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2017 09:37:06 -0700 (PDT)
In-Reply-To: <20170920103918.GA4630@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-acpi@vger.kernel.org

On 9/20/17, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> On Wed, Sep 20, 2017 at 02:17:38PM +0530, Mayuresh Chitale wrote:
>> Hi,
>>
>> I am working on adding APCI support to optee kernel driver and was
>> considering implementing it in the following way:
>>
>> - An optee device node would be added to the bios as follows:
>> Device(OPTE) {
>>       Name(_HID, ...)
>>       Name(_CID, ...)
>>       Name(_DDN, ...)
>>       Name (_DSD, Package () {
>>           Package () {
>>             Package (2) {"method", "smc"}
>>           }
>
> This _DSD is malformed as it is missing UUID.
Actually it is present in the code. I just wanted to present the
required details. Sorry for the ambiguity.
>
>>       })
>>     }
>>
>> - The optee kernel driver would then search for \\SB.OPTE device using
>> acpi_get_handle and parse the node to get the conduit method.
>
> You can use the standard device_property_* (see
> include/linux/property.h) accessors which fully support _DSD device
> properties.
>
>> I was wondering if this is the correct way to implement it and if so
>> do I need to get the OPTE device registered?  Your feedback is really
>> appreciated.
>
> There is something documented here:
>
> Documentation/acpi/DSD-properties-rules.txt
>
In DT, the optee node is placed under the firmware directory but I
dont think there is any equivalent to that in ACPI so I added the
'OPTE' node. I was wondering if this needs to be registered with
UEFI/ACPI forum.
