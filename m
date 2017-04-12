From: Linu Cherian <linucherian@gmail.com>
Subject: Re: [RFC PATCH 5/7] iommu/arm-smmu-v3: For ACPI based device probing,
 set relevant options for different SMMUv3 implementations.
Date: Wed, 12 Apr 2017 16:02:52 +0530
Message-ID: <CAGOz-0b5fXSaxbO_7rNMQP7rbNscXh8se7idR0q54r7bqf6=EA@mail.gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-6-git-send-email-linucherian@gmail.com> <20170412084336.GM4906@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35434 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbdDLKcx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2017 06:32:53 -0400
Received: by mail-yb0-f176.google.com with SMTP id f204so5558117ybc.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2017 03:32:53 -0700 (PDT)
In-Reply-To: <20170412084336.GM4906@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, Linu Cherian <linu.cherian@cavium.com>

>> +     switch (model) {
>> +     case ACPI_IORT_SMMU_V3:
>> +     case ACPI_IORT_SMMU_CORELINK_MMU600:
>> +             break;
>> +     case ACPI_IORT_SMMU_V3_HISILICON:
>> +             smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>> +             break;
>> +     case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
>> +             smmu->options |= (ARM_SMMU_OPT_PAGE0_REGS_ONLY |
>> +                               ARM_SMMU_OPT_USE_SHARED_IRQS);
>> +             break;
>> +     default:
>> +             ret = -ENODEV;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>>                                     struct arm_smmu_device *smmu)
>>  {
>>       struct acpi_iort_smmu_v3 *iort_smmu;
>>       struct device *dev = smmu->dev;
>>       struct acpi_iort_node *node;
>> +     int ret;
>>
>>       node = *(struct acpi_iort_node **)dev_get_platdata(dev);
>>
>>       /* Retrieve SMMUv3 specific data */
>>       iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>>
>> +     ret = acpi_smmu_get_options(iort_smmu->model, smmu);
>> +     if (ret < 0)
>> +             return ret;
>> +
>
> could we add at least:
>
>         dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
>
> We need a note to see which options have been enabled.
>

Yeah. Will add that.

Thanks.
