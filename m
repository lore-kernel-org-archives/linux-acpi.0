Return-Path: <SRS0=qznh=VW=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E172C7618B
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA5217F4
	for <linux-acpi@archiver.kernel.org>; Thu, 25 Jul 2019 12:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfGYMo5 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:44:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfGYMo5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 08:44:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D83E152D;
        Thu, 25 Jul 2019 05:44:55 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4BAB3F71F;
        Thu, 25 Jul 2019 05:44:53 -0700 (PDT)
Subject: Re: [PATCH v1] ACPI / APEI: Get rid of NULL_UUID_LE constant
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christoph Hellwig <hch@lst.de>
References: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c203f51b-3bf0-441a-1c5e-a9adf1e86ec5@arm.com>
Date:   Thu, 25 Jul 2019 13:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 17/07/2019 11:55, Andy Shevchenko wrote:
> This is a missed part of the commit 5b53696a30d5
> ("ACPI / APEI: Switch to use new generic UUID API"), i.e.
> replacing old definition with a global constant variable.

Reviewed-by: James Morse <james.morse@arm.com>

Thanks,

James
