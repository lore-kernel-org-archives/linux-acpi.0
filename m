Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA9C433ED
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DCC61452
	for <linux-acpi@archiver.kernel.org>; Thu, 22 Apr 2021 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhDVNnJ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:43:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17390 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNnJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2021 09:43:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FQz7z4j2RzlYWs;
        Thu, 22 Apr 2021 21:40:31 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 22 Apr 2021 21:42:24 +0800
Subject: Re: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, "Len Brown" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@android.com>
References: <20210421164317.1718831-1-maz@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b20ed406-5ba4-337b-840d-fc805da642ad@huawei.com>
Date:   Thu, 22 Apr 2021 21:42:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/4/22 0:43, Marc Zyngier wrote:
> Dann recently reported that his ThunderX machine failed to boot since
> 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
> interrupts"), with a not so pretty crash while trying to send an IPI.
> 
> It turned out to be caused by a mix of broken firmware and a buggy
> GTDT watchdog driver. Both have forever been buggy, but the above
> commit revealed that the error handling path of the driver was
> probably the worse part of it all.
> 
> Anyway, this short series has two goals:
> - handle broken firmware in a less broken way
> - make sure that the route cause of the problem can be identified
>    quickly

Tested on Kunpeng920 ARM64 server, didn't any issue after applying
this patch set,

Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
