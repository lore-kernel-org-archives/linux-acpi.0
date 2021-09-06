Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D72C433F5
	for <linux-acpi@archiver.kernel.org>; Mon,  6 Sep 2021 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B9560F14
	for <linux-acpi@archiver.kernel.org>; Mon,  6 Sep 2021 11:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhIFLwe (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 6 Sep 2021 07:52:34 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33883 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231173AbhIFLwe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Sep 2021 07:52:34 -0400
Received: from [192.168.0.4] (ip5f5ae911.dynamic.kabel-deutschland.de [95.90.233.17])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 62FD461E64860;
        Mon,  6 Sep 2021 13:51:27 +0200 (CEST)
Subject: Re: New warning: PRMT not found
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
Message-ID: <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
Date:   Mon, 6 Sep 2021 13:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Rafael, dear Len,


Intel’s MTA rejects Erik’s address:

     <erik.kaneda@intel.com>: host mga17.intel.com[192.55.52.151] said: 
550 #5.1.0
         Address rejected. (in reply to RCPT TO command)

So, I assume Erik left Intel.


Am 26.07.21 um 09:42 schrieb Paul Menzel:
> Dear Erik,
> 
> 
> The new code added in commit cefc7ca462 (ACPI: PRM: implement 
> OperationRegion handler for the PlatformRtMechanism subtype) causes 
> Linux to log a warning on my desktop system Asus F2A85-M PRO.
> 
>      PRMT not found
> 
> The help text for the Kconfig option `ACPI_PRMT` suggests it’s mainly 
> used for server systems, so the warning does not apply to a lot of 
> systems. Therefore, in my opinion, the option should not be selected by 
> default, or the warning be removed or demoted, and phrased in a way, 
> that users can understand the consequences.

The new warning shows up on a lot of systems, with no indication what to 
do about it or why Linux actually warns about it.

Should the message be removed entirely? Or is there another indicator 
for systems where absent PRMT causes problems, so should be warned about?


Kind regards,

Paul
