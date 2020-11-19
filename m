Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A2CC5519F
	for <linux-acpi@archiver.kernel.org>; Thu, 19 Nov 2020 01:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59286246CA
	for <linux-acpi@archiver.kernel.org>; Thu, 19 Nov 2020 01:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgKSBxk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:53:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8110 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgKSBxk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 20:53:40 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cc2l23NVQzLmCY;
        Thu, 19 Nov 2020 09:53:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.144) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Nov 2020
 09:53:33 +0800
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in
 nfit_handle_mce()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
 <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
 <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <390a0fb5-5feb-527c-b90e-1c7b6ea65d5f@huawei.com>
Date:   Thu, 19 Nov 2020 09:53:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020/11/19 3:16, Dan Williams wrote:
> On Wed, Nov 18, 2020 at 12:55 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>> On 2020/11/18 16:41, Zhen Lei wrote:
>>> The badrange to be reported should always cover mce->addr.
>> Maybe I should change this description to:
>> Make sure the badrange to be reported can always cover mce->addr.
> 
> Yes, I like that better. Can you also say a bit more about how you
> found this bug? As far as I can see this looks like -stable material.

I found it when I was learning the code. I'm looking at it carefully.

> 
> 

