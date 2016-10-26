From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] ACPICA: Interpreter: Improve lock order fixes
Date: Wed, 26 Oct 2016 02:51:23 +0200
Message-ID: <CAJZ5v0hi4QHwCzFFwfeotSV3ckXERha_LvFn4FwfhxcU2oe4GA@mail.gmail.com>
References: <cover.1477372449.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33391 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbcJZAvZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2016 20:51:25 -0400
In-Reply-To: <cover.1477372449.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <zetalog@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>

On Tue, Oct 25, 2016 at 7:20 AM, Lv Zheng <zetalog@gmail.com> wrote:
> This patchset improves ACPICA intepreter lock order fixes. Including
> several urgent regression fixes [PATCH 0-3].

OK, thanks!

So patches [4-6/6] appear to be cleanups and I'd prefer them to be
applied in a usual way (ie. via the upstream ACPICA).

I'd like to take the [1-3/6] as fixes for 4.9-rc3 though, but for that
I need you to tell me which mainline kernel commits are fixed by them.

IOW, what should I put into the Fixes: tags.

[In the future, if you post a regression fix, please always add a
FIxes: tag to it pointing to the commit being fixed.]

> Patches tested with customized ACPI table where _PS0/_PS3 methods are
> customized to invoke a serialized control method which creates named
> objects. When pm_async=yes, AE_ALREADY_EXISTS can be seen in suspend/resume
> process. This is an existing issue, triggered in 4.9-rc1 by ACPICA
> interpreter lock order fixes, and can be fixed by [PATCH 1] in this series.
>
> Lv Zheng (6):
>   ACPICA: Dispatcher: Fix order issue of method termination
>   ACPICA: Dispatcher: Fix an unbalanced lock exit path in
>     acpi_ds_auto_serialize_method()
>   ACPICA: Dispatcher: Tune interpreter lock around
>     acpi_ev_initialize_region()
>   ACPICA: Events: Cleanup acpi_ev_initialize_region()
>   ACPICA: Tables: Cleanup acpi_tb_install_and_load_table()
>   ACPICA: Tables: Add acpi_tb_unload_table()

Thanks,
Rafael
