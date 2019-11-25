Return-Path: <SRS0=2hes=ZR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CFFC43215
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910852084D
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 11:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKYLdm (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:33:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:60588 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfKYLdm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Nov 2019 06:33:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 03:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="216915188"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Nov 2019 03:33:38 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Nov 2019 13:33:37 +0200
Date:   Mon, 25 Nov 2019 13:33:37 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add honor_wakeup module-option +
 quirk mechanism
Message-ID: <20191125113337.GQ11621@lahna.fi.intel.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
 <20191122192334.61490-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122192334.61490-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 08:23:34PM +0100, Hans de Goede wrote:
> On some laptops enabling wakeup on the GPIO interrupts used for ACPI _AEI
> event handling causes spurious wakeups.
> 
> This commit adds a new honor_wakeup option, defaulting to true (our current
> behavior), which can be used to disable wakeup on troublesome hardware
> to avoid these spurious wakeups.
> 
> This is a workaround for an architectural problem with s2idle under Linux
> where we do not have any mechanism to immediately go back to sleep after
> wakeup events, other then for embedded-controller events using the standard
> ACPI EC interface, for details see:
> https://lore.kernel.org/linux-acpi/61450f9b-cbc6-0c09-8b3a-aff6bf9a0b3c@redhat.com/
> 
> One series of laptops which is not able to suspend without this workaround
> is the HP x2 10 Cherry Trail models, this commit adds a DMI based quirk
> which makes sets honor_wakeup to false on these models.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
