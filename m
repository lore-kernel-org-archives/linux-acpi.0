Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4770DC04A94
	for <linux-acpi@archiver.kernel.org>; Wed, 26 Jul 2023 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGZJ2P (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 26 Jul 2023 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjGZJ1m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 05:27:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D9423B;
        Wed, 26 Jul 2023 02:25:58 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9p1B1gzvz1GDKg;
        Wed, 26 Jul 2023 17:06:38 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:07:30 +0800
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "alikernel-developer@linux.alibaba.com" 
        <alikernel-developer@linux.alibaba.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZLZEq0QBBW4rcxJM@lpieralisi> <597f481b0e5149dabe4821ca618af6b3@huawei.com>
 <613da2c3-d515-b49c-4ff3-cf94836b2acf@huawei.com>
Message-ID: <7689b8a7-105c-d8a4-4ba0-10aafdfd75e8@huawei.com>
Date:   Wed, 26 Jul 2023 17:07:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <613da2c3-d515-b49c-4ff3-cf94836b2acf@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023/7/19 17:13, Hanjun Guo wrote:
> On 2023/7/18 16:56, Shameerali Kolothum Thodi wrote:
>>> [+Catalin, Will, Shameer]
[...]
>>> Shameer, I know this may look like overkill since the hunk we are
>>> removing is buggy but can you please test this patch on platforms
>>> with RMR to make sure we are not triggering regressions by removing
>>> it (by the specs that's what should be done but current firmware
>>> is always something to reckon with) ?
>> Yes, that is a valid fix. Unlikely it will be a problem. Anyway, I 
>> have requested
>> Hanjun to help with the testing as I don't have a test setup with me now.
> 
> Valid fix for me as well, we had a firmware bug which reported the
> numbers of ID as 1 when we only have one ID mapping, so remove the
> check is fine for the old firmware, but to make it sure, we need some
> test before give it a pass.
> 
>>
>> Hanjun, please help.
> 
> I need some time to get it properly tested on two versions of firmware,
> and get the test machine properly setup, please allow me give the
> feedback next week.

No regressions were found,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
