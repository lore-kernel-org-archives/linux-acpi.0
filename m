From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 1/3] mfd: Add new mfd device TPS68470
Date: Tue, 8 Aug 2017 08:39:37 +0100
Message-ID: <20170808073937.w4bj37a47xaxnnpj@dell>
References: <1501288226-27469-1-git-send-email-rajmohan.mani@intel.com>
 <1501288226-27469-2-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38584 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHHHjl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2017 03:39:41 -0400
Received: by mail-wr0-f176.google.com with SMTP id f21so9574216wrf.5
        for <linux-acpi@vger.kernel.org>; Tue, 08 Aug 2017 00:39:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501288226-27469-2-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, sakari.ailus@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>

On Fri, 28 Jul 2017, Rajmohan Mani wrote:

> The TPS68470 device is an advanced power management
> unit that powers a Compact Camera Module (CCM),
> generates clocks for image sensors, drives a dual
> LED for Flash and incorporates two LED drivers for
> general purpose indicators.
> 
> This patch adds support for TPS68470 mfd device.
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---
>  drivers/mfd/Kconfig          |  18 ++++++++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/tps68470.c       | 106 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps68470.h |  97 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/mfd/tps68470.c
>  create mode 100644 include/linux/mfd/tps68470.h

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
