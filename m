Return-Path: <SRS0=gnzp=3D=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F016C33CB1
	for <linux-acpi@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF7924677
	for <linux-acpi@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgANJrK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:47:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbgANJrJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Jan 2020 04:47:09 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 0524B413676FB742ABE3;
        Tue, 14 Jan 2020 09:47:08 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 09:47:07 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 09:47:07 +0000
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <d3af932c-106e-ee6e-56d3-5a665fd9b357@huawei.com>
 <b67fa77a-af21-9013-9162-1cfbd946e648@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eef4fe19-5813-ab8d-6249-906dbb3dbbcd@huawei.com>
Date:   Tue, 14 Jan 2020 09:47:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b67fa77a-af21-9013-9162-1cfbd946e648@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14/01/2020 07:19, Hanjun Guo wrote:
> On 2020/1/13 17:34, John Garry wrote:
>> On 30/12/2019 12:27, Guohanjun (Hanjun Guo) wrote:
>>> +};
>>> +
>>> +static bool apply_id_count_workaround;
>>> +
>>> +static struct iort_workaround_oem_info wa_info[] __initdata = {
>>> +    {
>>> +        .oem_id        = "HISI  ",
>>> +        .oem_table_id    = "HIP07   ",
>>> +        .oem_revision    = 0,
>>> +    }, {
>>> +        .oem_id        = "HISI  ",
>>> +        .oem_table_id    = "HIP08   ",
>>> +        .oem_revision    = 0,
>>> +    }
>>> +};
>>
>> Am I right in saying that any future BIOS for these chipsets will have to continue to have buggy firmware? If so, it's unfortunate.
> 
> For better compatibility, I would say yes :(
> 
> For example, if you fix that in the firmware, and update
> the IORT revision number, then it will run pretty good
> on new version of the kernel, but not on old version of
> kernel without the backporting of this patch.

ok, so that seems to be a trade off then. Having to backport introduces 
a risk.

So then it might be good to add a comment to ID count members in 
open-source edk2-platforms hip07 and hip08 IORTs to mention it is buggy, 
so not to be copied as a reference.

Cheers,
John
