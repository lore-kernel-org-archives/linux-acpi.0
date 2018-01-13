From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [2/4] ACPI / battery: reorder headers alphabetically
Date: Sat, 13 Jan 2018 12:53:31 +0100
Message-ID: <20180113115331.GA13662@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45460 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbeAMLxg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2018 06:53:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id i186so16708160wmi.4
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jan 2018 03:53:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com

> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/jiffies.h>
> #include <linux/async.h>
> -#include <linux/dmi.h>
> #include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/suspend.h>
> -#include <asm/unaligned.h>
> +#include <linux/types.h>

These changes completely break my patch:
https://patchwork.kernel.org/patch/10142157/

Can we please postpone this patch until I hear back from Rafael
about my series, as my series does some of the things this patch
series does (like defining pr_fmt to shorten log prints) and this 
is a much smaller changeset and would require small changes on 
conflicts compared to my series?

Thanks.

Ognjen
