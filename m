From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/1] of: Move OF property and graph API from base.c to
 property.c
Date: Wed, 29 Mar 2017 09:28:26 -0700
Message-ID: <58DBE0AA.2080403@gmail.com>
References: <1490353147-11917-1-git-send-email-sakari.ailus@linux.intel.com>
 <58DAF70E.9000305@gmail.com>
 <fb9cdd4e-e837-f925-da2b-9e4d25602e1e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33618 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdC2Q2p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 12:28:45 -0400
In-Reply-To: <fb9cdd4e-e837-f925-da2b-9e4d25602e1e@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com

On 03/29/17 02:14, Sakari Ailus wrote:
> Hi Frank,
> 
> Thank you for the review.
> 
> Frank Rowand wrote:
>> Hi Sakari,
>>
>> On 03/24/17 03:59, Sakari Ailus wrote:
>>> base.c contains both core OF functions and increasingly other
>>> functionality such as accessing properties and graphs, including
>>> convenience functions. In the near future this would also include OF
>>> specific implementation of the fwnode property and graph APIs. Prepare for
>>> this by moving the functionality to property.c.
>>
>> For future me, for when I look back and read this commit, please add something
>> to the effect of:
>>
>>   Create driver/of/property.c to contain procedures for accessing and
>>   interpreting device tree properties.  The procedures are moved from
>>   drivers/of/base.c, with no changes other than copying only the
>>   includes required by the moved procedures.
> 
> How about this as the commit message combining the two and dropping the last sentence from the original description:
> 
> base.c contains both core OF functions and increasingly other
> functionality such as accessing properties and graphs, including
> convenience functions. In the near future this would also include OF
> specific implementation of the fwnode property and graph APIs.
> 
> Create driver/of/property.c to contain procedures for accessing and
> interpreting device tree properties. The procedures are moved from
> drivers/of/base.c, with no changes other than copying only the
> includes required by the moved procedures.

Sounds good (and same for your below comments).

-Frank

> 
> ...
> 
>>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>>> new file mode 100644
>>> index 0000000..afcf00a
>>> --- /dev/null
>>> +++ b/drivers/of/property.c
>>> @@ -0,0 +1,727 @@
>>> +/*
>>> + * drivers/of/property.c - Devicetree properties and graphs.
>>
>>     * drivers/of/property.c - Procedures for accessing and interpreting
>>     * Devicetree properties and graphs.
>>     *
>>     * Initially created by copying procedures from drivers/of/base.c
>>
>> The reference to base.c provides a documentation trail to all of the
>> earlier git commits that created and modified the procedures.
> 
> I'll add that.
> 
>>
>> It would also be useful to say what procedures do and do not belong
>> in this file.  My understanding is that the intent is for
>> drivers/of/property.c and drivers/acpi/property.c to provide the
>> respective functionality that is used by drivers/base/property.c
>> and that drivers also may directly access the procedures in
>> drivers/of/property.c.
> 
> I'll add something along those lines. The fwnode op struct and the operations in that will be in this file as well.
> 

