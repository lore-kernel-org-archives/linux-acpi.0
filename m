From: Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
Date: Thu, 1 Sep 2016 10:16:02 +0800
Message-ID: <57C78F62.7030803@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
 <1472644094-82731-4-git-send-email-liudongdong3@huawei.com>
 <5406169.iVLlEcSJ8X@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28750 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbcIACSa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2016 22:18:30 -0400
In-Reply-To: <5406169.iVLlEcSJ8X@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com



在 2016/8/31 19:48, Arnd Bergmann 写道:
> On Wednesday, August 31, 2016 7:48:14 PM CEST Dongdong Liu wrote:
>> +static struct hisi_rc_res rc_res[] = {
>> +       {
>> +               HIP05,
>> +               {
>> +                       DEFINE_RES_MEM(0xb0070000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xb0080000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xb0090000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xb00a0000, SZ_4K)
>> +               }
>> +       },
>> +       {
>> +               HIP06,
>> +               {
>> +                       DEFINE_RES_MEM(0xa0090000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa0200000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa00a0000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa00b0000, SZ_4K)
>> +               }
>> +       },
>> +       {
>> +               HIP07,
>> +               {
>> +                       DEFINE_RES_MEM(0xa0090000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa0200000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa00a0000, SZ_4K),
>> +                       DEFINE_RES_MEM(0xa00b0000, SZ_4K),
>> +                       DEFINE_RES_MEM(0x8a0090000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x8a0200000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x8a00a0000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x8a00b0000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x600a0090000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x600a0200000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x600a00a0000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x600a00b0000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x700a0090000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x700a0200000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x700a00a0000UL, SZ_4K),
>> +                       DEFINE_RES_MEM(0x700a00b0000UL, SZ_4K)
>> +               }
>> +       },
>
> I don't know much about ACPI, but I'm pretty sure this is not
> the normal way to find MMIO resources. Why not read them from
> the ACPI tables?
>

Hi Arnd

Our host bridge is non ECAM only for the RC bus config space;
for any other bus underneath the root bus we support ECAM access.

We have not found a comfortable ACPI way to describle RC itself config (not ECAM) resource .


Thanks
Dongdong

> 	Arnd
>
> .
>

