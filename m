From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] ACPI: Add GPIO-signaled event simulator.
Date: Fri, 8 Aug 2014 14:36:02 +0200
Message-ID: <CACRpkdZmKJmaTRBpDrzd7+EhPuFeScr6jEHC8+0z6-4knjFqkA@mail.gmail.com>
References: <1406217076-17150-1-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:41119 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbaHHMgD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Aug 2014 08:36:03 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so4011292oag.11
        for <linux-acpi@vger.kernel.org>; Fri, 08 Aug 2014 05:36:02 -0700 (PDT)
In-Reply-To: <1406217076-17150-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Thu, Jul 24, 2014 at 5:51 PM, Tomasz Nowicki
<tomasz.nowicki@linaro.org> wrote:

> GPIO signaled events is quite new thing in Linux kernel.
> AFAIK, there are not many board which can take advantage of it.
> However, GPIO events are very useful feature during work on ACPI
> subsystems.

Overall this seems like a pretty nice debug feature.

> This commit emulates GPIO h/w behaviour and consists on read/write
> operation to debugfs file. GPIO device instance is still required in DSDT
> table along with _AEI resources and event methods.
>
> Reading from file provides pin to GPIO device map e.g. :
> $ cat /sys/kernel/debug/acpi/gpio_event
> GPIO device name: /__SB.GPI0
> Available GPIO pin map:
> /__SB.GPI0 <-> pin 0x100
>
> Based on that, user can trigger method corresponding to device pin number:
> $ echo "/__SB.GPI0 0x100" > /sys/kernel/debug/acpi/gpio_event

I need input from Rafael and Mika as to whether this is a
good interface.

It seems a bit confusing for me: why do you have to extract
a number from one file and then insert the same magic number
somewhere else?

Yours,
Linus Walleij
