Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC5C433FE
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Nov 2022 17:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiKHRZB (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiKHRZA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2022 12:25:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F7B1F9;
        Tue,  8 Nov 2022 09:24:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786BCB81BE0;
        Tue,  8 Nov 2022 17:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C9C433D6;
        Tue,  8 Nov 2022 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667928297;
        bh=8EOs/T0LKq4Dl/T4cvSYTwiBspLPJ57siJTF/a3e9i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvrUxykUeefZY4AkjD9fTgBv55XgM51TCzUZkY9uEM7XaMjkAO57x9NFTjF/1CFEC
         PbgUDKdB3kmw8NqGCk1kLxy9aoqqSGdqU5JuA3DnR/tYWeaHpgGpDbRs8yTxjC3QXC
         u9gmlLLdCMu6VO1wA5QcLaizH/GQhl7ydul/t4PU=
Date:   Tue, 8 Nov 2022 18:24:53 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Larry Lai <larry.lai@yunjingtech.com>
Cc:     Lee Jones <lee@kernel.org>, chengwei <foxfly.lai.tw@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH 1/5] mfd: Add
 support for UP board CPLD/FPGA
Message-ID: <Y2qQ5fq1kJBdlUYi@kroah.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-2-larry.lai@yunjingtech.com>
 <Y1/ik4XGNWsOg5KH@google.com>
 <SG2PR06MB3742D3714B6A255914DC73E4F93F9@SG2PR06MB3742.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3742D3714B6A255914DC73E4F93F9@SG2PR06MB3742.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 08, 2022 at 04:31:17PM +0000, Larry Lai wrote:
> Send again with Text only.

Sorry, was in HTML format :(
