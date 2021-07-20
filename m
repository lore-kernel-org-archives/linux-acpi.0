Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E5FC636C9
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Jul 2021 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19946113C
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Jul 2021 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhGTM6S (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:58:18 -0400
Received: from foss.arm.com ([217.140.110.172]:58802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238682AbhGTM6N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jul 2021 08:58:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6E81FB;
        Tue, 20 Jul 2021 06:38:51 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F06353F694;
        Tue, 20 Jul 2021 06:38:49 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:37:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        guohanjun@huawei.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI / PPTT: get PPTT table in the first beginning
Message-ID: <20210720133751.u6k6bdm7qco3gn65@bogus>
References: <20210720112635.38565-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720112635.38565-1-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 20, 2021 at 07:26:35PM +0800, Xiongfeng Wang wrote:
> When I added might_sleep() in down_timeout(), I got the following

Sorry it is not clear if you are able to reproduce this issue without
any other modifications in the mainline kernel ?

> Calltrace:
> 
> [    8.775671] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:160
> [    8.777070] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 14, name: cpuhp/0

From this I guess you are adding sleep after raw_spin_lock_irqsave
in down_timeout(kernel/locking/semaphore.c).

> 
> It is because generic_exec_single() will disable local irq before
> calling _init_cache_level(). _init_cache_level() use acpi_get_table() to
> get the PPTT table, but this function could schedule out.
> 
> To fix this issue, we use a static pointer to record the mapped PPTT
> table in the first beginning. Later, we use that pointer to reference
> the PPTT table in acpi_find_last_cache_level(). We also modify other
> functions in pptt.c to use the pointer to reference PPTT table.
>

I don't follow this change at all.

-- 
Regards,
Sudeep
