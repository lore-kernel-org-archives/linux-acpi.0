From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Wed, 05 Aug 2015 13:14:49 -0700
Message-ID: <55C26EB9.7010504@gmail.com>
References: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com> <5621301.c1YGTkGNQk@vostro.rjw.lan> <55C212F6.40504@linaro.org> <55C24737.8000309@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C24737.8000309@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-acpi@vger.kernel.org

On 08/05/2015 10:26 AM, David Daney wrote:
> On 08/05/2015 06:43 AM, Tomasz Nowicki wrote:
>> On 05.08.2015 15:48, Rafael J. Wysocki wrote:
>>> On Tuesday, August 04, 2015 04:01:59 PM David Daney wrote:
>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>
>>>> Fixes the following build error when building drivers as modules:
>>>>
>>>>   ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko]
>>>> undefined!
>>>>   ERROR: "acpi_dev_prop_read_single"
>>>> [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!
>>>
>>> Can you please tell me why the drivers in question use that function
>>> directly, although they aren't supposed to?
>>>
>>> Clearly, their authors had not tried to build them as modules or they
>>> would have noticed the problem at the development stage already.
>>>
>>> What would be wrong with using the generic device properties API
>>> instead?
>>>
>> Yes, you are right. We should use:
>> int device_property_read_u64_array(struct device *dev, const char
>> *propname, u64 *val, size_t nval);
>>
>
> Thanks all, for the review and suggestions.  We we try the suggested
> approach and see how it goes...
>

Actually I don't think device_property_read_u64_array() will work.

We are traversing a reference to a different acpi_device via 
acpi_dev_get_property_reference(), so there is no struct device * 
available for a call to device_property_read_u64_array().  This looks 
like a deficiency in the device_property_* framework, so for the time 
being I guess we will call acpi_dev_get_property(), which is exported, 
and decode the thing in the driver.

David Daney
