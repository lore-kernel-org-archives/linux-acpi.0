Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AFDC38142
	for <linux-acpi@archiver.kernel.org>; Sat, 28 Jan 2023 01:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjA1Btz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA1Bty (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 20:49:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD57EFC7;
        Fri, 27 Jan 2023 17:49:53 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P3clb0KFRz16NQX;
        Sat, 28 Jan 2023 09:47:55 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 09:49:50 +0800
Message-ID: <f90e04d2-e1f3-15a7-2b60-8494d2bec866@huawei.com>
Date:   Sat, 28 Jan 2023 09:49:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC-V3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
From:   "lihuisong (C)" <lihuisong@huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
 <ef705471-0dd3-fef1-68df-6a5761410946@huawei.com>
 <20230103041826.qo67fp45vzpch4os@bogus>
 <bff0af77-91ed-e3d5-4beb-817214c979d6@huawei.com>
In-Reply-To: <bff0af77-91ed-e3d5-4beb-817214c979d6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2023/1/5 9:14, lihuisong (C) 写道:
>
> 在 2023/1/4 19:06, Sudeep Holla 写道:
>> On Wed, Dec 14, 2022 at 10:57:51AM +0800, lihuisong (C) wrote:
>>> Hi Sudeep,
>>>
>>> Can you take a look? This patch series works well for type3 and type4.
>>>
>> Hi Huisong Li,
>>
>> Sorry for the delay. I have been away and will be for some more time.
>> I will take a look at this ASAP. Thanks for your patience.
> Thank you for your advance notice. Looking forward to your comments.😁
>
> .
Hi Sudeep,

Can you take a look at this patch series?
