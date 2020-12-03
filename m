Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A4DC433FE
	for <linux-acpi@archiver.kernel.org>; Thu,  3 Dec 2020 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF71206D6
	for <linux-acpi@archiver.kernel.org>; Thu,  3 Dec 2020 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgLCRsv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:48:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLCRsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 12:48:50 -0500
Received: from [192.168.1.155] ([95.118.71.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKbc4-1kSFrv2vtc-00KuCB; Thu, 03 Dec 2020 18:46:15 +0100
Subject: Re: [PATCH v2] drivers: acpi: add opt-out of apple-specific property
 parsing
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
References: <20201202122123.10229-1-info@metux.net>
 <ad917055-8b27-9ef3-bff1-873a6df354ab@infradead.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <3f336702-8883-b987-c487-0fe30fb934fd@metux.net>
Date:   Thu, 3 Dec 2020 18:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ad917055-8b27-9ef3-bff1-873a6df354ab@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8XUe8nqW+/GaWWOhaQHmRiYA4msZH5fv41mm7+HJRizEjm8aGTg
 YHL3JKMq2QxzUQN84FDwXlHmhnlp6xqEglLjZXeNOuZ20tkle/Y7YqIpPMf2o2A/WBHF5UW
 PsUg09xzgIAKYP1FHXKcKValT3cmN/SngA5Nf15nEJjQVq0HvmREMCow7UCrla8NIcJ7Yaq
 QAz73g71ReD8wydVhJbwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tiKXFWcOBk=:HUR24vhKMJ9yc8Flc+eiAY
 Tu3XKb6ltSdJC5bM017KKeveHje7Y+LqgeRGzkggzldl0tpZ83riBRF/T2up02R9I05m/Yx3F
 T50ELBgPEt3hGu6fMTXCZz4ulRC8a8izosAyNVcrGkkd50aPnUDrNTWY/bTrhnSM2K9wjlj47
 5o84e3aFQK57/5l+wEJISBsSdVN/b4U/iSs4yNZVMK5t34UWdmXsuYpE0dRNKQfAv63yXP/Sa
 zOzN/3rk6Mo2R4eIvSaxvQQczGaDYBb0MAj5dDdZ2FYpqaYn9zcM4Go0SukBwOw6ie18tJD9u
 o/B2zK7QjY1eAhi7QsN5/gasQ75z2DBJlkutdfnxOkq/L63esEslNKjJs5CymY2LeIRWlIFl/
 L8OGETS+3BEPgEKWoUabShL+ITEg9QkusKJ3SRlx07prdAVNKqKJF2ZCLVw/y
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02.12.20 18:51, Randy Dunlap wrote:

Hi,

>> +config ACPI_APPLE
>> +	bool "Apple ACPI properties support"
>> +	default y if X86
>> +	help
>> +	  Extraction of apple specific ACPI properties.>
> 	                Apple-specific

ok, thanks.

>> +
>> +	  Say N if you're sure the kernel won't be used on an Apple machine
>> +	  and wanna save a few kb of memory. (embedded or high-density VMs)
> 
> 	      want to
> 
> and kb == kilobits. Is that what you mean here?

around 6.6kb stripped, 74kb unstripped.

--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
