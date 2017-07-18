From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Tue, 18 Jul 2017 05:18:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEE2130@SHSMSX101.ccr.corp.intel.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:12500 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdGRFS4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 01:18:56 -0400
In-Reply-To: <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "bhe@redhat.com" <bhe@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "tokunaga.keiich@jp.fujitsu.com" <tokunaga.keiich@jp.fujitsu.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Julian Wollrath <jwollrath@web.de>

Hi,

Can the problem be fixed by invoking acpi_put_table() for mapped DMAR table?

Thanks
Lv

> From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
> Sent: Friday, July 14, 2017 1:53 PM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: tglx@linutronix.de; mingo@kernel.org; hpa@zytor.com; ebiederm@xmission.com; bhe@redhat.com;
> peterz@infradead.org; izumi.taku@jp.fujitsu.com; tokunaga.keiich@jp.fujitsu.com; Dou Liyang
> <douly.fnst@cn.fujitsu.com>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Zheng,
> Lv <lv.zheng@intel.com>; Julian Wollrath <jwollrath@web.de>
> Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
> 
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
> --
> 2.5.5
> 
> 

