Return-Path: <SRS0=wSSz=UC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FEBC04AB5
	for <linux-acpi@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA74248D5
	for <linux-acpi@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFCLIh (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:08:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:20226 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfFCLIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Jun 2019 07:08:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 04:08:36 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jun 2019 04:08:33 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Jun 2019 14:08:32 +0300
Date:   Mon, 3 Jun 2019 14:08:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, andy.shevchenko@gmail.com,
        masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Message-ID: <20190603110832.GA2781@lahna.fi.intel.com>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:
> @@ -1948,7 +1988,8 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
>  	if (!handle)
>  		return;
>  
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

Would it be simpler to differentiate here between Apple and non-Apple
systems? Then we don't need all that special code and the above becomes:

	depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
	..

Probably requires a comment explaining why we do it like that, though.
