Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A39C433ED
	for <linux-acpi@archiver.kernel.org>; Wed, 28 Apr 2021 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F006141B
	for <linux-acpi@archiver.kernel.org>; Wed, 28 Apr 2021 12:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhD1MR4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:17:56 -0400
Received: from mail1.perex.cz ([77.48.224.245]:56886 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhD1MRz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:17:55 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 121EBA0049;
        Wed, 28 Apr 2021 14:17:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 121EBA0049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1619612230; bh=856iQgpN6IstyBdDVZOVkYyG4rY7JY7nzEPQiXG6IV0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TwICAMM8dzZr560wpP1sQvKeaR6F7VCh8UwWyaRlZEavqO1f9RcGwa8dNKHg5EvOo
         DA2yHdG9/IR+7mMEPiuY3Nrrbu5GMGfelg3LFarEGguoQRHPb+QDblGz2E2S0B3GfI
         ifBLT/5HjS1Jh2HRe8mlN3VsaTxHWoeE/qGHPX4s=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 28 Apr 2021 14:17:00 +0200 (CEST)
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
To:     Greg KH <gregkh@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <56ea648f-3742-6dd6-9deb-5f1ba441905f@perex.cz>
Date:   Wed, 28 Apr 2021 14:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIlCzOl/rkYeOWVW@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dne 28. 04. 21 v 13:11 Greg KH napsal(a):
> On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
>> isapnp code is very old and according to this link
>> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
>> from Wikipedia, even Windows Vista disabled ISA PnP by default.
>>
>> This change is in follow up to
>> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
>> and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
>>
>> Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> 
> Has the maintainer said this is unsupported?

I've no idea, if there're any users at the time, but there are many drivers
which depend on this code.

I'll try to reply to patch threads.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
