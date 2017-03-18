From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation units
Date: Sat, 18 Mar 2017 17:59:30 +0100
Message-ID: <CACRpkdYVP0snBv_K18qkKgDBVEZ19RYkDLb5Kp9dVTBo7rOAcA@mail.gmail.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:38771 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdCRRAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Mar 2017 13:00:04 -0400
Received: by mail-it0-f46.google.com with SMTP id m27so58400617iti.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Mar 2017 09:59:31 -0700 (PDT)
In-Reply-To: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Fri, Mar 17, 2017 at 4:37 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Crystal Cove and Whiskey Cove are two different PMICs which are
> installed on Intel Atom SoC based platforms.
>
> Moreover there are two independent drivers that by some reason were
> supposed (*) to get into one kernel module.
>
> Fix the mess by clarifying Kconfig option for Crystal Cove and split
> Whiskey Cove out of it.
>
> (*) It looks like the configuration was never tested with
>     INTEL_SOC_PMIC=n. The line in Makefile is actually wrong.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> Cc: Linus Walleij <linus.walleij@linaro.org> (maintainer:GPIO SUBSYSTEM)
> Cc: Zhang Rui <rui.zhang@intel.com> (supporter:THERMAL)
> Cc: Eduardo Valentin <edubezval@gmail.com> (supporter:THERMAL)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
