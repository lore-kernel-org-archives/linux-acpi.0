Return-Path: <SRS0=2hes=ZR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3763C43215
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FA52084D
	for <linux-acpi@archiver.kernel.org>; Mon, 25 Nov 2019 11:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKYLcy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:32:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:10081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfKYLcy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Nov 2019 06:32:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 03:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="216915093"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Nov 2019 03:32:50 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Nov 2019 13:32:50 +0200
Date:   Mon, 25 Nov 2019 13:32:50 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] gpiolib: acpi: Turn dmi_system_id table into a
 generic quirk table
Message-ID: <20191125113250.GP11621@lahna.fi.intel.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
 <20191122192334.61490-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122192334.61490-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 08:23:33PM +0100, Hans de Goede wrote:
> Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
> into a generic quirk table, storing the quirks in the driver_data ptr.
> 
> This is a preparation patch for adding other types of (DMI based) quirks.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
