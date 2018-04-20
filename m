From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
Date: Fri, 20 Apr 2018 14:32:37 +0100
Message-ID: <687812a4-6fe4-77df-8022-92938f8efaff@huawei.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-3-git-send-email-john.garry@huawei.com>
 <1524228606.21176.472.camel@linux.intel.com>
 <e838b3ef-5cf8-ac12-6b44-a1f8001f8b94@huawei.com>
 <1524230910.21176.474.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524230910.21176.474.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, lenb@kernel.org, mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org, helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On 20/04/2018 14:28, Andy Shevchenko wrote:
> On Fri, 2018-04-20 at 14:09 +0100, John Garry wrote:
>> On 20/04/2018 13:50, Andy Shevchenko wrote:
>>> On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:
>
>>>> +			if (res->flags | IORESOURCE_IO)
>>>
>>> What does this mean?
>>
>> Here we check the resource flag for each resource for this PNP device
>> -
>> for IO resources we must translate the resource value from the bus
>> address to the logical PIO address.
>
> Please, re-read your code again.
>

Got it. But then again there is a helper for this, as Mika pointed out... :)

Cheers
