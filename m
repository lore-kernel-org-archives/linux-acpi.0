From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI / init: Switch over platform to the ACPI mode later
Date: Wed, 10 Jun 2015 10:06:40 +0800
Message-ID: <55779BB0.6030900@linaro.org>
References: <12578608.kKCTgirQ6f@vostro.rjw.lan> <1433351637.23540.170.camel@misato.fc.hp.com> <13170654.9h99FfQLut@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33229 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFJCGs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2015 22:06:48 -0400
Received: by pdjn11 with SMTP id n11so26582586pdj.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2015 19:06:48 -0700 (PDT)
In-Reply-To: <13170654.9h99FfQLut@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Toshi Kani <toshi.kani@hp.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Marius Tolzmann <tolzmann@molgen.mpg.de>, Matt Fleming <matt@codeblueprint.co.uk>, Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>

On 06/10/2015 07:48 AM, Rafael J. Wysocki wrote:
> On Wednesday, June 03, 2015 11:13:57 AM Toshi Kani wrote:
>> On Sat, 2015-05-30 at 14:21 +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before
>>> timekeeping_init()" moved the ACPI subsystem initialization,
>>> including the ACPI mode enabling, to an earlier point in the
>>> initialization sequence, to allow the timekeeping subsystem
>>> use ACPI early.  Unfortunately, that resulted in boot regressions
>>> on some systems and the early ACPI initialization was moved toward
>>> its original position in the kernel initialization code by commit
>>> c4e1acbb35e4 "ACPI / init: Invoke early ACPI initialization later".
>>>
>>> However, that turns out to be insufficient, as boot is still broken
>>> on the Tyan S8812 mainboard.
>>>
>>> To fix that issue, split the ACPI early initialization code into
>>> two pieces so the majority of it still located in acpi_early_init()
>>> and the part switching over the platform into the ACPI mode goes into
>>> a new function, acpi_subsystem_init(), executed at the original early
>>> ACPI initialization spot.
>>>
>>> That fixes the Tyan S8812 boot problem, but still allows ACPI
>>> tables to be loaded earlier which is useful to the EFI code in
>>> efi_enter_virtual_mode().
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=97141
>>> Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Can you add comments to acpi_early_init() and acpi_subsystem_init() to
>> clarify what ACPI features are enabled at each phase, and what
>> dependency they have in the boot sequence?  (The same goes to
>> early_acpi_boot_init() and acpi_boot_init().)
>
> OK, update follows.
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / init: Switch over platform to the ACPI mode later
>
> Commit 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before
> timekeeping_init()" moved the ACPI subsystem initialization,
> including the ACPI mode enabling, to an earlier point in the
> initialization sequence, to allow the timekeeping subsystem
> use ACPI early.  Unfortunately, that resulted in boot regressions
> on some systems and the early ACPI initialization was moved toward
> its original position in the kernel initialization code by commit
> c4e1acbb35e4 "ACPI / init: Invoke early ACPI initialization later".
>
> However, that turns out to be insufficient, as boot is still broken
> on the Tyan S8812 mainboard.
>
> To fix that issue, split the ACPI early initialization code into
> two pieces so the majority of it still located in acpi_early_init()
> and the part switching over the platform into the ACPI mode goes into
> a new function, acpi_subsystem_init(), executed at the original early
> ACPI initialization spot.
>
> That fixes the Tyan S8812 boot problem, but still allows ACPI
> tables to be loaded earlier which is useful to the EFI code in
> efi_enter_virtual_mode().
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=97141
> Fixes: 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before timekeeping_init()"
> Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Toshi Kani <toshi.kani@hp.com>
> ---
>   drivers/acpi/bus.c   |   56 +++++++++++++++++++++++++++++++++++++--------------
>   include/linux/acpi.h |    2 +
>   init/main.c          |    1
>   3 files changed, 44 insertions(+), 15 deletions(-)
>
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -470,6 +470,16 @@ static int __init acpi_bus_init_irq(void
>   	return 0;
>   }
>
> +/**
> + * acpi_early_init - Initialize ACPICA and populate the ACPI namespace.
> + *
> + * The ACPI tables are accessible after this, but the handling of events has not

Maybe we need to explicitly say that it's DSDT/SSDT, because static
tables such as FADT and MADT are accessible in the very early stage
of boot (in setup_arch()).

Other than that,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
