From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 6/8] gpio: pca953x: support ACPI devices found on
 Galileo Gen2
Date: Fri, 2 Oct 2015 03:54:27 -0700
Message-ID: <CACRpkdbW=5tQg-ZRqtw4k3U2Rt+ZPp29O0UhK8W39vSwy_QFaw@mail.gmail.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1442916619-140607-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34394 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbJBKy2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2015 06:54:28 -0400
Received: by oiev17 with SMTP id v17so55688650oie.1
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2015 03:54:27 -0700 (PDT)
In-Reply-To: <1442916619-140607-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Sep 22, 2015 at 3:10 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This patch adds a support of the expandes found on Intel Galileo Gen2 board.
> The platform information comes from ACPI.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Paging Gregory, Grygorii, Graeme on this patch too.

Yours,
Linus Walleij
