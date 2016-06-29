From: Tony <tony.makkiel@daqri.com>
Subject: Re: [PATCH v7 1/1] leds: LED driver for TI LP3952 6-Channel Color LED
Date: Wed, 29 Jun 2016 11:07:10 +0100
Message-ID: <57739DCE.3030303@daqri.com>
References: <1467129919-27641-1-git-send-email-tony.makkiel@daqri.com>
 <3435169.nmqvdouPPq@vostro.rjw.lan> <57737021.1010603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38149 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbcF2KHN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 06:07:13 -0400
Received: by mail-wm0-f49.google.com with SMTP id r201so65722130wme.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2016 03:07:12 -0700 (PDT)
In-Reply-To: <57737021.1010603@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-leds@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org


On 29/06/16 07:52, Jacek Anaszewski wrote:
> Hi Rafael,

>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id lp3952_acpi_match[] = {
>>> +    {LP3952_ACPI_NAME, 0},
>>
>> No, you can't use "PRP0001" in this list.
>>
>>> +    {}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(acpi, lp3952_acpi_match);
>>
>> And you don't need this for the "PRP0001" thing to work.  The core will
>> take care of it for you then.
>>
>>> +#endif
>>
>> So the entire ACPI block can be dropped for now.
>>
>> And the driver doesn't have to depend on CONFIG_ACPI any more, does it?
>
> The driver currently supports probing only with ACPI.
> I have one question BTW: isn't there anything similar to the device tree
> bindings documentation required for ACPI overlays?
> Pointer to the discussion which led us to this solution:
>
> http://www.spinics.net/lists/linux-leds/msg06230.html
>
_DSD is working now. I managed to get "PRP0001" working as suggested by 
Rafael in
http://marc.info/?l=linux-acpi&m=146711623115228&w=2
with _DSD

  I will try adding names using _DSD. I am not sure why DSD didn't work 
earlier. The only reason I could think of is, upgrading my OS recently 
following a raid failure.

>
>>>
