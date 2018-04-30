From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Date: Mon, 30 Apr 2018 10:35:13 +0100
Message-ID: <6e71041d-1fc5-40b1-11b2-4af2f2d9c569@huawei.com>
References: <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
 <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
 <20180426140808.GK2173@lahna.fi.intel.com>
 <15443a87-2622-01ee-f7f2-426a51ca0f11@huawei.com>
 <44e047a2-93e1-9eff-45b8-d538a7ae9092@huawei.com>
 <20180430053611.GA11990@dell>
 <67a620ee-fd1f-4b5e-aa91-9f280a63807b@huawei.com>
 <20180430092659.GA5147@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430092659.GA5147@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, andriy.shevchenko@linux.intel.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org, helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
List-Id: linux-acpi@vger.kernel.org

>>>> So we using the mfd_cell to match child devices using _HID. At a glance, I
>>>> don't actually see other drivers to use mfd_cell_acpi_match.pnpid .
>>>>
>>>> Anyway we don't use static tables as we need to update the resources of the
>>>> cell dynamically. However I do look at a driver like intel_quark_i2c_gpio.c,
>>>> and this dynamically modifies the value of global mfd_cell array here:
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/intel_quark_i2c_gpio.c#L266
>>>>
>>>> I know the cell array is only used at probe time, but this did not look to
>>>> be good standard practice to me.
>>>
>>> Lots of drivers do this to supply dynamic data.  If there is no other
>>> sane way of providing such data, it's fine to do.  Although each
>>> situation should be dealt with on a case-by-case basis.
>>>
>>
>> Hi Lee,
>>
>> Thanks for your input.
>>
>> I do see others drivers which use dynamic mem for the mfd_cells (like
>> cros_ec_dev.c), so what we're doing in this driver already is not totally
>> unchartered territory. But creating the MFD cells from the ACPI table could
>> be ...
>
> Right.  I don't normally like mixing platform data technologies (MFD,
> ACPI and DT).  I normally NACK patches which take information from
> Device Tree and populate MFD cells with it.  ACPI would be the same I
> guess.

Oh, well that is what we have in this driver. So what's the preferred 
approach? Just not use MFD model at all if ACPI/DT needs to be scanned 
for data to create the cells?

Thanks,
John

>
>> Anyway, I'll cc you in my next patchset and maybe you can kindly check it.
>>
>
