Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D51BC77B7F
	for <linux-acpi@archiver.kernel.org>; Tue, 16 May 2023 11:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjEPLOD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 May 2023 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjEPLNs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:13:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5EC72B9;
        Tue, 16 May 2023 04:12:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66C52F4;
        Tue, 16 May 2023 04:12:42 -0700 (PDT)
Received: from [10.163.71.75] (unknown [10.163.71.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CC03F663;
        Tue, 16 May 2023 04:11:51 -0700 (PDT)
Message-ID: <a03cc9da-4990-26d5-b3d5-acec2106ea2d@arm.com>
Date:   Tue, 16 May 2023 16:41:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 2/5] coresight: etm4x: Drop iomem 'base' argument from
 etm4_probe()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-3-anshuman.khandual@arm.com>
 <60e86c22-ca05-81a0-da0a-73928e4b2c93@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <60e86c22-ca05-81a0-da0a-73928e4b2c93@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/4/23 20:52, James Clark wrote:
> 
> On 27/03/2023 06:05, Anshuman Khandual wrote:
>> 'struct etm4_drvdata' itself can carry the base address before etm4_probe()
>> gets called. Just drop that redundant argument from etm4_probe().
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 10119c223fbe..5d77571a8df9 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -2048,7 +2048,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>>  	return 0;
>>  }
>>  
>> -static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>> +static int etm4_probe(struct device *dev, u32 etm_pid)
>>  {
>>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>>  	struct csdev_access access = { 0 };
>> @@ -2069,8 +2069,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>>  			return -ENOMEM;
>>  	}
>>  
>> -	drvdata->base = base;
>> -
>>  	spin_lock_init(&drvdata->spinlock);
>>  
>>  	drvdata->cpu = coresight_get_cpu(dev);
>> @@ -2124,8 +2122,9 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>>  	if (!drvdata)
>>  		return -ENOMEM;
>>  
>> +	drvdata->base = base;
>>  	dev_set_drvdata(dev, drvdata);
>> -	ret = etm4_probe(dev, base, id->id);
>> +	ret = etm4_probe(dev, id->id);
>>  	if (!ret)
>>  		pm_runtime_put(&adev->dev);
>>  
>> @@ -2141,6 +2140,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>>  	if (!drvdata)
>>  		return -ENOMEM;
>>  
>> +	drvdata->base = NULL;
> Very minor point, drvdata is zero alloced so it doesn't make sense to
> zero this field but not the others. It's harmless, but it might imply
> something and confuse someone.

Just to keep changes to both call sites of etm4_probe() similar i.e
etm4_probe()'s 'base' argument being pre-assigned as drvdata->base,
let's keep the NULL assignment above unchanged.

> 
> Either way:
> Reviewed-by: James Clark <james.clark@arm.com>
> 
