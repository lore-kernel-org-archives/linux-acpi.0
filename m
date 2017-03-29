From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] of: Move OF property and graph API from base.c to
 property.c
Date: Wed, 29 Mar 2017 12:14:01 +0300
Message-ID: <fb9cdd4e-e837-f925-da2b-9e4d25602e1e@linux.intel.com>
References: <1490353147-11917-1-git-send-email-sakari.ailus@linux.intel.com>
 <58DAF70E.9000305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17265 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbdC2JOM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Mar 2017 05:14:12 -0400
In-Reply-To: <58DAF70E.9000305@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com

Hi Frank,

Thank you for the review.

Frank Rowand wrote:
> Hi Sakari,
>
> On 03/24/17 03:59, Sakari Ailus wrote:
>> base.c contains both core OF functions and increasingly other
>> functionality such as accessing properties and graphs, including
>> convenience functions. In the near future this would also include OF
>> specific implementation of the fwnode property and graph APIs. Prepare for
>> this by moving the functionality to property.c.
>
> For future me, for when I look back and read this commit, please add something
> to the effect of:
>
>   Create driver/of/property.c to contain procedures for accessing and
>   interpreting device tree properties.  The procedures are moved from
>   drivers/of/base.c, with no changes other than copying only the
>   includes required by the moved procedures.

How about this as the commit message combining the two and dropping the 
last sentence from the original description:

base.c contains both core OF functions and increasingly other
functionality such as accessing properties and graphs, including
convenience functions. In the near future this would also include OF
specific implementation of the fwnode property and graph APIs.

Create driver/of/property.c to contain procedures for accessing and
interpreting device tree properties. The procedures are moved from
drivers/of/base.c, with no changes other than copying only the
includes required by the moved procedures.

...

>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> new file mode 100644
>> index 0000000..afcf00a
>> --- /dev/null
>> +++ b/drivers/of/property.c
>> @@ -0,0 +1,727 @@
>> +/*
>> + * drivers/of/property.c - Devicetree properties and graphs.
>
>     * drivers/of/property.c - Procedures for accessing and interpreting
>     * Devicetree properties and graphs.
>     *
>     * Initially created by copying procedures from drivers/of/base.c
>
> The reference to base.c provides a documentation trail to all of the
> earlier git commits that created and modified the procedures.

I'll add that.

>
> It would also be useful to say what procedures do and do not belong
> in this file.  My understanding is that the intent is for
> drivers/of/property.c and drivers/acpi/property.c to provide the
> respective functionality that is used by drivers/base/property.c
> and that drivers also may directly access the procedures in
> drivers/of/property.c.

I'll add something along those lines. The fwnode op struct and the 
operations in that will be in this file as well.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
