From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: Do pinswitch magic when reading
 GPADC
Date: Sun, 9 Jul 2017 20:16:11 +0200
Message-ID: <fc38898b-c612-876e-6a75-b84bc8dc9123@redhat.com>
References: <20170708134008.13930-1-hdegoede@redhat.com>
 <1499522283.22624.309.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbdGISQO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 Jul 2017 14:16:14 -0400
In-Reply-To: <1499522283.22624.309.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On 08-07-17 15:58, Andy Shevchenko wrote:
> On Sat, 2017-07-08 at 15:40 +0200, Hans de Goede wrote:
>> Testing has shown that the TS-pin's bias-current needs to be disabled
>> when reading the GPIO0 pin in GPADC mode.
>>
>> It seems that there is only 1 bias current source and to be able to
>> use it
>> for the GPIO0 pin in GPADC mode it must be temporarily turned off for
>> the
>> TS pin, but the datasheet does not mention this.
>>
>> This commit adds the necessary writes to turn the TS pin BIAS current
>> off before and back on after reading the GPADC. This fixes the GPADC
>> always returning a reading of 0.
>>
>>
> 
>> +	/* After switching to the GPADC pin give things some time to
>> settle */
>> +	usleep_range(6000, 10000);
> 
> msleep(6); ?

That will make checkpatch unhappy and may sleep for as long as 20ms, also see:
Documentation/timers/timers-howto.txt which advices against using msleep for
short sleeps.

Regards,

Hans

