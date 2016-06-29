From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Wed, 29 Jun 2016 23:32:16 +0200
Message-ID: <CAJZ5v0iD5OYjp7ozmzoQ3zK-3+eMpdwzDxYgD=saLPjNeoq0Qg@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34777 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbcF2VcZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2016 17:32:25 -0400
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee

On Wed, Jun 29, 2016 at 8:15 PM,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer
>         1. Move some enums and marcos to header file
>         2. Add a new enum for spi type.
>         3. Improve printk relevant code
>
>     (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (3)Simplify ACPI code for arm_arch_timer
>
>     (4)Add GTDT support for ARM memory-mapped timer

GTDT is ARM-specific AFAICS.

If so, why do we need that code to reside in drivers/acpi/ ?

Thanks,
Rafael
