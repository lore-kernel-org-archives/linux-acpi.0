From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Wed, 05 Aug 2015 16:49:37 -0700
Message-ID: <55C2A111.5090607@gmail.com>
References: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com> <1501387.bDOHyjjWvt@vostro.rjw.lan> <55C29981.8060308@caviumnetworks.com> <9593183.WnSqkeFNYV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36720 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbbHEXtl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 19:49:41 -0400
In-Reply-To: <9593183.WnSqkeFNYV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: David Daney <ddaney@caviumnetworks.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>

On 08/05/2015 04:55 PM, Rafael J. Wysocki wrote:
> On Wednesday, August 05, 2015 04:17:21 PM David Daney wrote:
>> On 08/05/2015 04:23 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, August 05, 2015 01:14:49 PM David Daney wrote:
>>>> On 08/05/2015 10:26 AM, David Daney wrote:
>>>>> On 08/05/2015 06:43 AM, Tomasz Nowicki wrote:
>>>>>> On 05.08.2015 15:48, Rafael J. Wysocki wrote:
>>>>>>> On Tuesday, August 04, 2015 04:01:59 PM David Daney wrote:
>>>>>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>>>>>
>>>>>>>> Fixes the following build error when building drivers as modules:
>>>>>>>>
>>>>>>>>     ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko]
>>>>>>>> undefined!
>>>>>>>>     ERROR: "acpi_dev_prop_read_single"
>>>>>>>> [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!
>>>>>>>
>>>>>>> Can you please tell me why the drivers in question use that function
>>>>>>> directly, although they aren't supposed to?
>>>>>>>
>>>>>>> Clearly, their authors had not tried to build them as modules or they
>>>>>>> would have noticed the problem at the development stage already.
>>>>>>>
>>>>>>> What would be wrong with using the generic device properties API
>>>>>>> instead?
>>>>>>>
>>>>>> Yes, you are right. We should use:
>>>>>> int device_property_read_u64_array(struct device *dev, const char
>>>>>> *propname, u64 *val, size_t nval);
>>>>>>
>>>>>
>>>>> Thanks all, for the review and suggestions.  We we try the suggested
>>>>> approach and see how it goes...
>>>>>
>>>>
>>>> Actually I don't think device_property_read_u64_array() will work.
>>>>
>>>> We are traversing a reference to a different acpi_device via
>>>> acpi_dev_get_property_reference(),
>>>
>>> Why?
>>
>> Network device has a "phy-handle" (traversed with
>> acpi_dev_get_property_reference()), and we want to get some properties
>> of that phy.
>>
>> I could turn the question around to you:  Why export
>> acpi_dev_get_property_reference()?  If there is a reason to export that,
>> then you should let people use the result.
>
> The GPIO core uses it and you *can* use the result (please see my other
> message).

It was somewhat of a rhetorical question.

I would actually like to do as you suggest, so I am looking at unwinding 
the driver code to use the interfaces you suggest.

It is a multi-step process for me though.  First I had to make the 
existing code work.  I now have it working, so next I will try to fix it.

>
> I wonder how does the ACPI table in question look like.  Do you have
> an acpidump output from that system by any chance?

Not handy.  I will be producing one soon though.

The good news is that I can change the firmware to make it correct if it 
has problems.


Thanks for your patience,
David Daney


