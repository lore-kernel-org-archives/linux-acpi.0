From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ILK ACPI boot-up problem on HP 8100 SFF, bisected
Date: Mon, 9 Jan 2017 23:07:35 +0100
Message-ID: <CAJZ5v0hgZ575POz0hSmOJ+-0UKzk5j-zrhmaV9EF_QehFmFysw@mail.gmail.com>
References: <2435796.hnfxsDQFWV@fractal.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32865 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdAIWHg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 17:07:36 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so14066151oih.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2017 14:07:35 -0800 (PST)
In-Reply-To: <2435796.hnfxsDQFWV@fractal.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lv <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, intel-gfx-ci@eclists.intel.com

Hi,

On Mon, Jan 9, 2017 at 5:01 PM, Tomi Sarvela <tomi.p.sarvela@intel.com> wrote:
> Hello there,
>
> We have couple of Iron Lake machines here, and one started hanging around Christmas in early boot on ACPI initialization. Dmesg below, full dmesgs available on request.
>
> Exact model of the machine is HP Compaq 8100 Elite Small Form Factor PC. BIOS update from 2010 to 2011 (newest) didn't change anything.
> HP Elite laptop (ILK m540) or Dell SFF PC (ILK 650) don't have this particular problem.
>
> I've bisected the problem to the following commit:
>
> ----
> commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
> Author: Lv Zheng <lv.zheng@intel.com>
> Date:   Wed Dec 14 15:04:25 2016 +0800
>
>     ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel
>
>     ACPICA commit cac6790954d4d752a083e6122220b8a22febcd07
> ----
>
> The affected machine is a testhost and readily available for any patches that might help pinpoint this bug.
>
> If you need any more information, you can contact me directly to this address.

Thanks for the report!

Does this patch make any difference:
https://patchwork.kernel.org/patch/9504277/ ?

Thanks,
Rafael
