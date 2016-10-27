From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] ACPICA: Interpreter: Fix regressions in lock order improvement
Date: Thu, 27 Oct 2016 12:22:56 +0200
Message-ID: <CAJZ5v0hE48oR45zWqDjngS+W2JgARqqyNT5BV_nBoyhK05TcxQ@mail.gmail.com>
References: <cover.1477372449.git.lv.zheng@intel.com> <cover.1477465173.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36150 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936559AbcJ0OLQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2016 10:11:16 -0400
In-Reply-To: <cover.1477465173.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <zetalog@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>

On Wed, Oct 26, 2016 at 9:39 AM, Lv Zheng <zetalog@gmail.com> wrote:
> This patchset fixes regressions in ACPICA intepreter lock order
> improvement.
>
> Patches tested with customized ACPI table where _PS0/_PS3 methods are
> customized to invoke a serialized control method which creates named
> objects. When pm_async=yes, AE_ALREADY_EXISTS can be seen in suspend/resume
> process. This is an existing issue, triggered in 4.9-rc1 by ACPICA
> interpreter lock order fixes, and can be fixed by [PATCH 1] in this series.
>
> v2:
> 1. Remove non-regression-fixes.
> 2. Add "Fixes" tags.
>
> Lv Zheng (3):
>   ACPICA: Dispatcher: Fix order issue of method termination
>   ACPICA: Dispatcher: Fix an unbalanced lock exit path in
>     acpi_ds_auto_serialize_method()
>   ACPICA: Dispatcher: Tune interpreter lock around
>     acpi_ev_initialize_region()

Thanks!

I'm queuing up this series for the next ACPI pull request.

Thanks,
Rafael
