From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] ACPI / X86: Add KIOX000A accelerometer on GPD win to
 always_present_ids array
Date: Mon, 10 Jul 2017 12:35:30 +0200
Message-ID: <722a926e-6fa9-2aa8-35d3-cf4044e939f1@redhat.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
 <20170709190514.3437-3-hdegoede@redhat.com>
 <1499682140.22624.318.camel@linux.intel.com>
 <03da3e2a-0a81-e4b8-092e-211d2f08cf93@redhat.com>
 <1499682570.22624.321.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbdGJKfd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 06:35:33 -0400
In-Reply-To: <1499682570.22624.321.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On 10-07-17 12:29, Andy Shevchenko wrote:
> On Mon, 2017-07-10 at 12:25 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10-07-17 12:22, Andy Shevchenko wrote:
>>> On Sun, 2017-07-09 at 21:05 +0200, Hans de Goede wrote:
>>>> The GPD win BIOS dated 20170320 has disabled the accelerometer,
>>>> the
>>>> drivers sometimes cause crashes under Windows and this is how the
>>>> manufacturer has solved this :|
>>>>
>>>> I see no other way to keep the accelerometer working under Windows
>>>> then
>>>> adding it to the always_present_ids array.
>>>>
>>>> +	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
>>>> +		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> 
>>>> +		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> 
> Just noticed above, don't think it's a good idea to place kinda defaults
> there.

That is why there is a comment above the entry:

         /*
          * The GPD win BIOS dated 20170320 has disabled the accelerometer, the
          * drivers sometimes cause crashes under Windows and this is how the
          * manufacturer has solved this :| Note that the the DMI data is less
          * generic then it seems, a board_vendor of "AMI Corporation" is quite
          * rare and a board_name of "Default String" also is rare.
          */

Most Cherry Trail BIOS-es (and we do a CPU-id check for Cherry Trail)
have both DMI_BOARD_NAME and DMI_PRODUCT_NAME set to something more
sensible then "Default string" and other then the GPD win / pocket no
other model that I know of has a DMI_BOARD_NAME of "Default string"

So we can be pretty sure that the combination of Cherry Trail CPU +
these DMI strings + a BIOS-date of "03/20/2017" + having an ACPI
device with a HID of KIOX000A" is unique.

Also note that even if we have a false positive, the KIOX000A driver
will fail with a probe error, unless there is an other i2c device at
the exact same address.

Regards,

Hans
