From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v7 2/6] device property: Move FW type specific
 functionality to FW specific files
Date: Mon, 12 Jun 2017 16:53:11 +0300
Message-ID: <c3a10325-05a0-b383-0140-09962ea6cced@linux.intel.com>
References: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
 <1496741861-8240-3-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqKqW42pTOsw=1iTrCyHgF5E0WZqBC0k9QwVQ2uW5RFutA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27680 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbdFLNxU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jun 2017 09:53:20 -0400
In-Reply-To: <CAL_JsqKqW42pTOsw=1iTrCyHgF5E0WZqBC0k9QwVQ2uW5RFutA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>

Hi Rob,

Rob Herring wrote:
> On Tue, Jun 6, 2017 at 4:37 AM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
>> The device and fwnode property API supports Devicetree, ACPI and pset
>> properties. The implementation of this functionality for each firmware
>> type was embedded in the fwnode property core. Move it out to firmware
>> type specific locations, making it easier to maintain.
>>
>> Depends-on: ("of: Move OF property and graph API from base.c to property.c")
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>>  drivers/acpi/property.c |  68 ++++++++++++++++
>>  drivers/acpi/scan.c     |   1 +
>>  drivers/base/property.c | 208 +++++++++++++++++++-----------------------------
>>  drivers/of/property.c   |  90 +++++++++++++++++++++
>>  include/linux/acpi.h    |   4 +
>>  include/linux/fwnode.h  |  54 +++++++++++++
>>  include/linux/of.h      |   2 +
>>  7 files changed, 302 insertions(+), 125 deletions(-)
>>
>> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
>> index 9364398..14013f6 100644
>> --- a/drivers/acpi/property.c
>> +++ b/drivers/acpi/property.c
>> @@ -57,6 +57,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
>>
>>         dn->name = link->package.elements[0].string.pointer;
>>         dn->fwnode.type = FWNODE_ACPI_DATA;
>> +       dn->fwnode.ops = &acpi_fwnode_ops;
>
> Mainly in interest of not growing fwnode_handle, we could remove .type
> and just have checks like "ops == &acpi_fwnode_ops".
>
> Otherwise, for patches 2,3,4:
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for the ack!

The ops field is currently not unique for all types of fwnodes:

type			ops
---------------------------------------
FWNODE_ACPI_STATIC	acpi_fwnode_ops
FWNODE_ACPI_DATA	acpi_fwnode_ops
FWNODE_ACPI		acpi_fwnode_ops
FWNODE_OF		of_fwnode_ops
FWNODE_PSET		pset_fwnode_ops
FWNODE_IRQCHIP		NULL

We could define three more ops for fwnodes (ACPI_STATIC, ACPI_DATA and 
IRQCHIP). I presume the effect on the total memory consumption is still 
a positive one. Especially it does not increase as much with the number 
of fwnodes.

I have a patch but I'll test it still a little before submitting it.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
