From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 3/4] device property: Move FW type specific
 functionality to FW specific files
Date: Tue, 21 Mar 2017 10:28:33 +0200
Message-ID: <74b1619e-72a9-f991-8138-845e5e8603b8@linux.intel.com>
References: <1489671289-20406-1-git-send-email-sakari.ailus@linux.intel.com>
 <1489671289-20406-4-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_Jsq+HGNCbiHw8dD0R+zj+GfGxaypk7di0sbxNr4bZsjqxbA@mail.gmail.com>
 <1655370d-6867-9466-6d26-f34a09789369@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755420AbdCUI2q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Mar 2017 04:28:46 -0400
In-Reply-To: <1655370d-6867-9466-6d26-f34a09789369@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>

Cc Frank.

Sakari Ailus wrote:
> Hi Rob,
>
> Rob Herring wrote:
>> On Thu, Mar 16, 2017 at 8:34 AM, Sakari Ailus
>> <sakari.ailus@linux.intel.com> wrote:
>>> The device and fwnode property API supports Devicetree, ACPI and pset
>>> properties. The implementation of this functionality for each firmware
>>> type was embedded in the fwnode property core. Move it out to firmware
>>> type specific locations, making it easier to maintain.
>>>
>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> ---
>>>  drivers/acpi/property.c |  87 +++++++++++++++
>>>  drivers/acpi/scan.c     |   1 +
>>>  drivers/base/property.c | 280
>>> +++++++++++++++++++-----------------------------
>>>  drivers/of/base.c       |  99 +++++++++++++++++
>>
>> This is the opposite direction everything else has been moving. For
>> example, I2C parsing is in drivers/i2c. But I guess this is a bit
>> different.
>>
>> In any case, please move this to drivers/of/property.c (and perhaps
>> move all of of_property_* there too).
>
> Ok.
>
> There appear to be quite a few functions dealing with properties in
> drivers/of/base.c either directly reading their values or otherwise
> accessing them. Let me see if I can find a roughly coherent set of
> functions to move to property.c. I'll move the existing functions there
> first, creating a new patch before this one.
>


-- 
Sakari Ailus
sakari.ailus@linux.intel.com
