Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9043BC433B4
	for <linux-acpi@archiver.kernel.org>; Wed, 31 Mar 2021 15:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C65161026
	for <linux-acpi@archiver.kernel.org>; Wed, 31 Mar 2021 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhCaPcA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 31 Mar 2021 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhCaPbp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 11:31:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CBC061574;
        Wed, 31 Mar 2021 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tVqwXPeMpcPjMcfmOMRW1o8lTeeHlqNgjZuJX1la08s=; b=d8zFFKvDQKtEVmP7HTfvP4NAUY
        AzF6ulglEVngy0V0aqIcVwoEIU3T1TqCdBcygwKED1eEMuOMiVsmx1ZJXDMjY42dGfUMoOLc/bObY
        cuSYd26KwHKIHyoUL7R8/68q8bKMspjnU3+Ic7+DUXA0tMKxtQvVhXF1+3vf7Fm+VFNwf1jaWr9BS
        NOJcWkTaLzncb9Z6rq415afi9G3EsLLm84uQorAK6NCp3aWC/2AfsH7/VcjVRe3OFXUXjmS3oRuqA
        I5lTH8Jl5ee2kDleUGAUpWVaMTIvZxFEVfsjwmdqRVJ1L5zLrnl5GUSyYtam/pgs5zMq/3y2pU+G4
        aQJslrZQ==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRcop-006uG5-BE; Wed, 31 Mar 2021 15:31:43 +0000
Subject: Re: linux-next: Tree for Mar 31 (acpi build warning)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
References: <20210331204357.4e439016@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae86c684-5d63-aea5-6bff-774f1512da82@infradead.org>
Date:   Wed, 31 Mar 2021 08:31:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331204357.4e439016@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/31/21 2:43 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next release on Friday or the following
> Monday.
> 
> Changes since 20210330:
> 

../drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #ifdef directive

#ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)

s/ifdef/if/


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
