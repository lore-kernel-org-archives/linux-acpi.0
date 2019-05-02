Return-Path: <SRS0=GW3r=TC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F869C43219
	for <linux-acpi@archiver.kernel.org>; Thu,  2 May 2019 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6F52085A
	for <linux-acpi@archiver.kernel.org>; Thu,  2 May 2019 08:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfEBIDC (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 2 May 2019 04:03:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:60394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBIDB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 May 2019 04:03:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 01:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="169840867"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 May 2019 01:02:55 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 02 May 2019 11:02:55 +0300
Date:   Thu, 2 May 2019 11:02:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 4/4] gpio: mb86s7x: enable ACPI support
Message-ID: <20190502080255.GS26516@lahna.fi.intel.com>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
 <20190429131208.3620-5-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429131208.3620-5-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190502080255.XgCk6_t5Gq1hhi76fdk9H77YjYomutll7xHMVlLB2ZM@z>

On Mon, Apr 29, 2019 at 03:12:08PM +0200, Ard Biesheuvel wrote:
> @@ -160,13 +177,15 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
>  	if (IS_ERR(gchip->base))
>  		return PTR_ERR(gchip->base);
>  
> -	gchip->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(gchip->clk))
> -		return PTR_ERR(gchip->clk);
> +	if (!ACPI_COMPANION(&pdev->dev)) {

Since you don't use the returned ACPI object, you can also use
has_acpi_companion(&pdev->dev) here and other similar places.

Regardless of that,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
