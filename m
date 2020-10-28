Return-Path: <SRS0=W+nf=EE=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD35C55179
	for <linux-acpi@archiver.kernel.org>; Thu, 29 Oct 2020 02:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA6E20704
	for <linux-acpi@archiver.kernel.org>; Thu, 29 Oct 2020 02:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgJ1Vsv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:48:51 -0400
Received: from foss.arm.com ([217.140.110.172]:38348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgJ1VrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACC515EC;
        Wed, 28 Oct 2020 12:19:32 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E2803F68F;
        Wed, 28 Oct 2020 12:19:31 -0700 (PDT)
Subject: Re: [PATCH] Fix incorrect return value of pre_map_gar_callback
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
References: <20201026061509.48212-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6b71b5b3-b423-6768-15f4-44f7aa7dc12d@arm.com>
Date:   Wed, 28 Oct 2020 19:19:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026061509.48212-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!

On 26/10/2020 06:15, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
> will return logical address or NULL for error, but pre_map_gar_callback,for
> ACPI_ADR_SPACE_SYSTEM_IO case, it should

'it should' refers to pre_map_gar_callback(), not acpi_os_map_generic_address()?


> be also return 0,as it's a
> normal case, but now it will return -ENXIO. so check it out for such case
> to avoid einj module initialization fail.

apei_map_generic_address() calls acpi_os_map_generic_address() which returns NULL for any
address space that isn't ACPI_ADR_SPACE_SYSTEM_MEMORY.
That commit now maps this to an error code, where-as before: this code was getting away
with it.

The bug is it tries to map a GAR that doesn't need mapping.


Could we avoid this problem more clearly by returning 0 from apei_map_generic_address()
for address spaces that don't need mapping? (e.g. IO)

This would also fix any other callers lurking in apei.


Thanks,

James


> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 552fd9ffaca4..042d2dbdb855 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -230,7 +230,8 @@ static int pre_map_gar_callback(struct apei_exec_context *ctx,
>  {
>  	u8 ins = entry->instruction;
>  
> -	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER)
> +	if (ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER &&
> +	 entry->register_region.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return apei_map_generic_address(&entry->register_region);
>  
>  	return 0;


