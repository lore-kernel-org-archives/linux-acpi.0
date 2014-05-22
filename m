From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: baytrail: Register GPIO chip after
 chip->to_irq is set
Date: Thu, 22 May 2014 23:47:21 +0200
Message-ID: <CACRpkda+hjtO=uPqurhx578ceHtf68kwJqhc15ZeR4JehqATPA@mail.gmail.com>
References: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
	<1400167727-20233-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:50482 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaEVVrV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2014 17:47:21 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so4623404oac.8
        for <linux-acpi@vger.kernel.org>; Thu, 22 May 2014 14:47:21 -0700 (PDT)
In-Reply-To: <1400167727-20233-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jin Yao <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, May 15, 2014 at 5:28 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> From: Jin Yao <yao.jin@intel.com>
>
> If chip->to_irq is NULL ACPI GPIO helpers don't register GPIO event
> handlers thus preventing any ACPI GPIO triggered events. Solve this by
> calling gpiochip_add() after we have set up drivers chip->to_irq hook.
>
> Signed-off-by: Jin Yao <yao.jin@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied for fixes, sorry for running a bit late, we are
late.

Yours,
Linus Walleij
