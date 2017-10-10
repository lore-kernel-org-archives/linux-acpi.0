From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two steps mappings
Date: Tue, 10 Oct 2017 14:47:53 +0800
Message-ID: <CAGHbJ3DbuGeKH16zr+PdZYjoaZrHJrTmV5tmMxZ5CDPObErUCQ@mail.gmail.com>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
 <1506475215-2731-4-git-send-email-hanjun.guo@linaro.org> <20170927135449.GA11347@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46583 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdJJGry (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2017 02:47:54 -0400
Received: by mail-qt0-f182.google.com with SMTP id 1so8181192qtn.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Oct 2017 23:47:54 -0700 (PDT)
In-Reply-To: <20170927135449.GA11347@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lv Zheng <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>

Hi Lorenzo,

Sorry for the late reply, holidays in China for the past week.

At 2017/9/27 21:54, Lorenzo Pieralisi wrote:
> Hi Hanjun,
>
> On Wed, Sep 27, 2017 at 09:20:14AM +0800, Hanjun Guo wrote:
>> IORT revision C introduced SMMUv3 MSI support which adding a
>> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
>> device ID mapping for the output ID (dev ID for ITS) and the
>> link to which ITS.
>>
>> So if a platform supports SMMUv3 MSI for control interrupt,
>> there will be a additional single map entry under SMMU, this
>> will not introduce any difference for devices just use one
>> step map to get its output ID and parent (ITS or SMMU), such
>> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
>> do the special handling for two steps map case such as
>> PCI/NC--->SMMUv3--->ITS.
>>
>> Take a PCI hostbridge for example,
>>
>> |----------------------|
>> |  Root Complex Node   |
>> |----------------------|
>> |    map entry[x]      |
>> |----------------------|
>> |       id value       |
>> | output_reference     |
>> |---|------------------|
>>      |
>>      |   |----------------------|
>>      |-->|        SMMUv3        |
>>          |----------------------|
>>          |     SMMU dev ID      |
>>          |     mapping index 0  |
>>          |----------------------|
>>          |      map entry[0]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 1 (SMMU MSI domain)
>>          |----------------------|
>>          |      map entry[1]    |
>>          |----------------------|
>>          |       id value       |
>>          | output_reference-----------> ITS 2 (PCI MSI domain)
>>          |----------------------|
>>
>> When the SMMU dev ID mapping index is 0, there is entry[0]
>> to map to a ITS, we need to skip that map entry for PCI
>> or NC (named component), or we may get the wrong ITS parent.
>
> Is this actually true ? I think that currently we would simply skip
> the entry and print an error log but we can't get a wrong ITS parent.

So the only valid single mapping under type SMMUv3 is SMMUv3's dev id
mapping, we need to fix the IORT spec as well.

>
> I am rewriting this commit (I will probably split it), it is doing the
> right thing but the commit log is stale (probably caused by code
> reshuffling).

Do I need to resend another version, or you can help to update it?
please let me know.

By the way, this patch set was tested on Hisilicon Hip08 with MSI
for SMMU, and it works fine.

Thanks
Hanjun
