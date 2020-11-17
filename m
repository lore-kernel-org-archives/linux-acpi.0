Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F0C63798
	for <linux-acpi@archiver.kernel.org>; Tue, 17 Nov 2020 20:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23317206C0
	for <linux-acpi@archiver.kernel.org>; Tue, 17 Nov 2020 20:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="afKce7tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgKQUJU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQUJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 15:09:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022A8C0613CF;
        Tue, 17 Nov 2020 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oprj9F/K15BrPLDWenEHIh2OqJBVOGuDKraGGJLvwiM=; b=afKce7tGM8AXOADzvc4lOH7R3F
        BfjPKbabBxgatd4Ip247FXifpkmLTsgHQf5+zotjxBqun5XVkTjjoOtwPg/ClahA+KvO39lEIRRBT
        iR1Y2twoFFqRqtHHA/HKch0cZchCsuBAdOqVX+T20U56NGPDe7/trm91pvzw67694Fv1sdQosR+in
        2IumeTEA6quIrm2/gCJjtsXTCzDn6oMqC0y3Spn1+44Zbzrxzu6IRgQqpnOuqQEjPVlUrdd3DPw+b
        BMpXVRg6ZEOg4pu0Dc86Iq3n3w1fadFC9xjkrzxcCGsHayRef39B1RNn5y2I67dcVLEs9P52I8uhA
        4dObGCvQ==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf7Hw-0008C2-8B; Tue, 17 Nov 2020 20:09:16 +0000
Subject: Re: [PATCH 9/9] platform/surface: Add Surface ACPI Notify driver
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-10-luzmaximilian@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4ad59722-6834-a0f9-8d7a-16b8f22a1f26@infradead.org>
Date:   Tue, 17 Nov 2020 12:09:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201115192143.21571-10-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/15/20 11:21 AM, Maximilian Luz wrote:
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index cecad7a0cb7b..3b0da86546fa 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -40,6 +40,26 @@ config SURFACE_3_POWER_OPREGION
>  	  This driver provides support for ACPI operation
>  	  region of the Surface 3 battery platform driver.
>  
> +config SURFACE_ACPI_NOTIFY
> +	tristate "Surface ACPI Notify Driver"
> +	depends on ACPI
> +	depends on SURFACE_AGGREGATOR
> +	help
> +	  Surface ACPI Notify (SAN) driver for Microsoft Surface devices.

Drop "depends on ACPI" since SURFACE_AGGREGATOR already depends on ACPI.

-- 
~Randy

