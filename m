Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D4C433DB
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Feb 2021 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1F64ECF
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Feb 2021 11:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBYLc4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 25 Feb 2021 06:32:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13087 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhBYLcf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 06:32:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmVvV632zz165qQ;
        Thu, 25 Feb 2021 19:30:14 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 19:31:45 +0800
Subject: Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
To:     <devel@acpica.org>, <linux-acpi@vger.kernel.org>
CC:     <Robert.Moore@intel.com>, <erik.kaneda@intel.com>,
        <robin.murphy@arm.com>, <rafael.j.wysocki@intel.com>,
        <guohanjun@huawei.com>, <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
References: <20210225112620.1827-1-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <319c8bd0-21f2-2e25-b1c9-a70697f9d315@huawei.com>
Date:   Thu, 25 Feb 2021 19:31:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225112620.1827-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/25 19:26, Zenghui Yu wrote:
> As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU

s/SMMU_IRD0/SMMU_IDR0/
