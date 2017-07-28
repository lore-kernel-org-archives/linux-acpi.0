From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Fri, 28 Jul 2017 01:53:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEE8365@SHSMSX101.ccr.corp.intel.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <1AE640813FDE7649BE1B193DEA596E886CEE2130@SHSMSX101.ccr.corp.intel.com>
 <d0ce9178-4b06-081b-6b12-a8cd1c5352b7@cn.fujitsu.com>
 <20170718084521.GC2344@x1>
 <0c13e0de-9a37-2992-ef00-20b6ad67dbc5@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14890 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbdG1Bxb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 21:53:31 -0400
In-Reply-To: <0c13e0de-9a37-2992-ef00-20b6ad67dbc5@cn.fujitsu.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "peterz@infradead.org" <peterz@infradead.org>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "tokunaga.keiich@jp.fujitsu.com" <tokunaga.keiich@jp.fujitsu.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Julian Wollrath <jwollrath@web.de>

Hi,

> From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
> Sent: Tuesday, July 18, 2017 5:44 PM
> Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
> 
> Hi Baoquan,
> 
> At 07/18/2017 04:45 PM, bhe@redhat.com wrote:
> > On 07/18/17 at 02:08pm, Dou Liyang wrote:
> >> Hi, Zheng
> >>
> >> At 07/18/2017 01:18 PM, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>> Can the problem be fixed by invoking acpi_put_table() for mapped DMAR table?
> >>
> >> Invoking acpi_put_table() is my first choice. But it made the kernel
> >> *panic* when we try to get the table again in intel_iommu_init() in
> >> late stage.
> >>
> >> I am also confused that:
> >>
> >> There are two places where we used DMAR table in Linux:
> >>
> >> 1) In detect_intel_iommu() in ACPI early stage:
> >>
> >> ...
> >> status = acpi_get_table(ACPI_SIG_DMAR, 0, &dmar_tbl);
> >> ....
> >> if (dmar_tbl) {
> >> 	acpi_put_table(dmar_tbl);
> >> 	dmar_tbl = NULL;
> >> }
> >>
> >> 2) In dmar_table_init() in ACPI late stage:
> >>
> >> ...
> >> status = acpi_get_table(ACPI_SIG_DMAR, 0, &dmar_tbl);
> >> ...
> >>
> >> As we know, dmar_table_init() is called by intel_iommu_init() and
> >> intel_prepare_irq_remapping().
> >>
> >> When I invoked acpi_put_table() in the intel_prepare_irq_remapping() in
> >> early stage like 1) shows, kernel will panic.
> >
> > That's because acpi_put_table() will make the table pointer be NULL,
> > while dmar_table_init() will skip parse_dmar_table() calling if
> > dmar_table_initialized is set to 1 in intel_prepare_irq_remapping().
> >
> 
> Correctly.
> 
> I have considered and removed the *dmar_table_initialized* in this
> situation. So, dmar_table_init() didn't skip parse_dmar_table()
> calling.
> 
> I didn't dig into the cause, I think it is interesting, I will do it
> right now and share with you later.
> 
> > Dmar hardware support interrupt remapping and io remapping separately. But
> > intel_iommu_init() is called later than intel_prepare_irq_remapping().
> > So what if make dmar_table_init() a reentrant function? You can just
> > have a try, but maybe not a good idea, the dmar table will be parsed
> > twice.
> 
> Yes, It is precisely one reason that I gave up invoking
> acpi_put_table().

Parsing a table twice is not a problem on x86.
If you check the code, there are many examples.
It's actually required if you want to use a table both in early stage and late stage.

Thanks

> 
> Thanks,
> 
> 	dou.
> 
> >
> >>
> >>
> >> Thanks,
> >>
> >> 	dou.
> >>>
> >>> Thanks
> >>> Lv
> >>>
> >>>> From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
> >>>> Sent: Friday, July 14, 2017 1:53 PM
> >>>> To: x86@kernel.org; linux-kernel@vger.kernel.org
> >>>> Cc: tglx@linutronix.de; mingo@kernel.org; hpa@zytor.com; ebiederm@xmission.com; bhe@redhat.com;
> >>>> peterz@infradead.org; izumi.taku@jp.fujitsu.com; tokunaga.keiich@jp.fujitsu.com; Dou Liyang
> >>>> <douly.fnst@cn.fujitsu.com>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Zheng,
> >>>> Lv <lv.zheng@intel.com>; Julian Wollrath <jwollrath@web.de>
> >>>> Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
> >>>>
> >>>> Linux uses acpi_early_init() to put the ACPI table management into
> >>>> the late stage from the early stage where the mapped ACPI tables is
> >>>> temporary and should be unmapped.
> >>>>
> >>>> But, now initializing interrupt delivery mode should map and parse the
> >>>> DMAR table earlier in the early stage. This causes an ACPI error when
> >>>> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
> >>>> the DMAR table after using in the early stage.
> >>>>
> >>>> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
> >>>> be mapped and parsed in late stage like before.
> >>>>
> >>>> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
> >>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> >>>> Cc: linux-acpi@vger.kernel.org
> >>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >>>> Cc: Zheng, Lv <lv.zheng@intel.com>
> >>>> Cc: Julian Wollrath <jwollrath@web.de>
> >>>> ---
> >>>> Test in my own PC(Lenovo M4340).
> >>>> Ask help for doing regression testing for the bug said in commit c4e1acbb35e4
> >>>> ("ACPI / init: Invoke early ACPI initialization later").
> >>>>
> >>>>  init/main.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/init/main.c b/init/main.c
> >>>> index df58a41..7a09467 100644
> >>>> --- a/init/main.c
> >>>> +++ b/init/main.c
> >>>> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
> >>>>  	kmemleak_init();
> >>>>  	setup_per_cpu_pageset();
> >>>>  	numa_policy_init();
> >>>> +	acpi_early_init();
> >>>>  	if (late_time_init)
> >>>>  		late_time_init();
> >>>>  	calibrate_delay();
> >>>>  	pidmap_init();
> >>>>  	anon_vma_init();
> >>>> -	acpi_early_init();
> >>>>  #ifdef CONFIG_X86
> >>>>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
> >>>>  		efi_enter_virtual_mode();
> >>>> --
> >>>> 2.5.5
> >>>>
> >>>>
> >>>
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
> 

