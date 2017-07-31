From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Mon, 31 Jul 2017 18:50:38 +0800
Message-ID: <a8024347-ce0b-c59b-74ea-45a822e54ee6@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:39340 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdGaLBs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 07:01:48 -0400
In-Reply-To: <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, bhe@redhat.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Julian Wollrath <jwollrath@web.de>, Borislav Petkov <bp@alien8.de>

Hi,

At 07/14/2017 01:52 PM, Dou Liyang wrote:
> Linux uses acpi_early_init() to put the ACPI table management into
> the late stage from the early stage where the mapped ACPI tables is
> temporary and should be unmapped.
>
> But, now initializing interrupt delivery mode should map and parse the
> DMAR table earlier in the early stage. This causes an ACPI error when
> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
> the DMAR table after using in the early stage.
>
> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
> be mapped and parsed in late stage like before.
>
> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Zheng, Lv <lv.zheng@intel.com>
> Cc: Julian Wollrath <jwollrath@web.de>
> ---
> Test in my own PC(Lenovo M4340).
> Ask help for doing regression testing for the bug said in commit c4e1acbb35e4
> ("ACPI / init: Invoke early ACPI initialization later").
>

Now, I can prove this patch doesn't result in the bug[1] which made the
fast TSC calibration using PIT failed in a Thinkpad x121e (AMD E-450
APU).

The true reason of the bug is enabling ACPI subsystem earlier than
using PIT, not the SCI setup. invoking acpi_enable_subsystem() later
could fix this bug as Julian tested and said[2].

And, I found that Commit b064a8fa77df (" ACPI / init: Switch over
platform to the ACPI mode later") split the ACPI early initialization
code into acpi_early_init() and acpi_subsystem_init(). executing
acpi_enable_subsystem() at the original early ACPI initialization spot.

The sequence of them shows below:

  start_kernel
+---------------+
|
+--> .......
|
|    late_time_init()
+--> +-------+
|
+--> .......
|
|    acpi_early_init()
+--> +-------+
|
+--> .......
|
|   acpi_subsystem_init()
+-> +--------+

We make sure the acpi_subsystem_init() is called later than
late_time_init(), the bug will be avoided.

This patch changes the sequence of late_time_init() and
acpi_early_init(), doesn't effect acpi_subsystem_init().

So, this patch is OK.

Btw, Thanks very much for Borislav Petkov, he will have access to
Thinkpad x121e from Mid-August and will test this series.

[1] https://lkml.org/lkml/2014/3/10/123
[2] https://lkml.org/lkml/2014/3/12/311


Thanks
	dou.

>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/main.c b/init/main.c
> index df58a41..7a09467 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
>  	kmemleak_init();
>  	setup_per_cpu_pageset();
>  	numa_policy_init();
> +	acpi_early_init();
>  	if (late_time_init)
>  		late_time_init();
>  	calibrate_delay();
>  	pidmap_init();
>  	anon_vma_init();
> -	acpi_early_init();
>  #ifdef CONFIG_X86
>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>  		efi_enter_virtual_mode();
>


