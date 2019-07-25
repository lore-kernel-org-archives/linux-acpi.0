Return-Path: <SRS0=qznh=VW=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8909C7618B
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Jul 2019 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DA022C7B
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Jul 2019 12:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfGYMqd (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:46:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388497AbfGYMqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 08:46:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C016152D;
        Thu, 25 Jul 2019 05:46:32 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7782F3F71F;
        Thu, 25 Jul 2019 05:46:31 -0700 (PDT)
Subject: Re: [PATCH v4] ACPI / APEI: release resources if gen_pool_add fails
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
References: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3c4ce1be-f873-8acd-0e9b-061f1c079717@arm.com>
Date:   Thu, 25 Jul 2019 13:46:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Liguang,

On 15/07/2019 07:58, luanshi wrote:
> To avoid memory leaks, destroy ghes_estatus_pool and release memory
> allocated via vmalloc() on errors in ghes_estatus_pool_init().
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---

Playing spot-the-difference with [v3], you've moved an empty line.

Please include a change log in this space below the '---' tearoff. This helps reviewers
know what you changed between versions, and git knows not to add stuff in here to the log.

This is still:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

[v3]
https://lore.kernel.org/linux-acpi/1561258201-26917-1-git-send-email-zhangliguang@linux.alibaba.com/


>  drivers/acpi/apei/ghes.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

[...]
