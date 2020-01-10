Return-Path: <SRS0=bwoO=27=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7AC33CA2
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Jan 2020 10:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3992072E
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Jan 2020 10:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgAJKvR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:51:17 -0500
Received: from foss.arm.com ([217.140.110.172]:42272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbgAJKvR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Jan 2020 05:51:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9262B328;
        Fri, 10 Jan 2020 02:51:16 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43BDA3F703;
        Fri, 10 Jan 2020 02:51:15 -0800 (PST)
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        linux-acpi@vger.kernel.org, John Garry <john.garry@huawei.com>,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <2ce224b2-d926-67b0-f9dd-85ac53d967c5@arm.com>
 <20200109160220.GA27079@e121166-lin.cambridge.arm.com>
 <4cee4a91-6459-819b-d4d4-f5e8899103b9@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1649ca0b-27c5-7365-2184-7ef95f210561@arm.com>
Date:   Fri, 10 Jan 2020 10:51:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4cee4a91-6459-819b-d4d4-f5e8899103b9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-01-10 6:22 am, Hanjun Guo wrote:
> On 2020/1/10 0:02, Lorenzo Pieralisi wrote:
>> On Mon, Jan 06, 2020 at 05:19:32PM +0000, Robin Murphy wrote:
>>> On 30/12/2019 12:27 pm, Hanjun Guo wrote:
>>>> The IORT spec [0] says Number of IDs = The number of IDs in the range minus
>>>> one, it is confusing but it was written down in the first version of the
>>
>> Why is it confusing ? Because we botched the kernel code :) ?
> 
> I think 'minus one' is not bringing any benefit :)

Well, in order to describe a 1:1 mapping of the entire possible ID 
space, the alternative would have to be to overload the 
otherwise-nonsensical value of 0 to mean 2^32, which I would argue is an 
even more non-obvious inconsistency. Encoding strictly positive values 
as 'value - 1' is a relatively common thing (at least in hardware design).

Robin.
