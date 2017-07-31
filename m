From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Mon, 31 Jul 2017 21:30:07 +0800
Message-ID: <20170731133007.GC29157@x1>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <1AE640813FDE7649BE1B193DEA596E886CEE2130@SHSMSX101.ccr.corp.intel.com>
 <d0ce9178-4b06-081b-6b12-a8cd1c5352b7@cn.fujitsu.com>
 <20170718084521.GC2344@x1>
 <2855c940-9e57-f06f-d9f0-dc5eb4408b37@cn.fujitsu.com>
 <20170727060859.GE24304@x1>
 <7f3a1d3a-6327-67de-ff0b-8132bc506e6e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdGaNaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 09:30:12 -0400
Content-Disposition: inline
In-Reply-To: <7f3a1d3a-6327-67de-ff0b-8132bc506e6e@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: joeyli.kernel@gmail.com, "Zheng, Lv" <lv.zheng@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "peterz@infradead.org" <peterz@infradead.org>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "tokunaga.keiich@jp.fujitsu.com" <tokunaga.keiich@jp.fujitsu.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Julian Wollrath <jwollrath@web.de>

On 07/31/17 at 07:20pm, Dou Liyang wrote:
> Hi Baoquan,
> 
> At 07/27/2017 02:08 PM, bhe@redhat.com wrote:
> > On 07/26/17 at 08:19pm, Dou Liyang wrote:
> > > Hi Baoquan,
> [...]
> > > 
> > > I am looking for Thinkpad x121e (AMD E-450 APU) to test. I have tested
> > > it in Thinkpad s430, It's OK.
> > > 
> > > BTY, I am confused how does the ACPI subsystem affect PIT which
> > > will be used to fast calibrate CPU frequency[2].
> 
> In combination with what Joey said[1] and the code, I guess,
> 
> The acpi_enable() called in acpi_enable_system() transfers the system
> into ACPI mode and write data to an I/O port. PIT works using the I/O
> port. In Thinkpad x121e with ACPI mode, the counter in PIT couldn't
> count right and might got an error value.
> 
> [1] https://lkml.org/lkml/2014/3/12/3

Awesome! I guess you are possibly correct. A MUST job for entering
into ACPI mode is to enable SCI and hook a handler. SCI will take over
all acpi interrupt events. I googled SCI and vaguely remember someone
said the I/O port r/w event also will be handled by SCI, but didn't find
a clear description in ACPI spec. If that cause failure, it might
happen inside pit_expect_msb() called by quick_pit_calibrate(), maybe
you can try to add debug message in this place, not very sure if it
be debugged.

Maybe tglx or Rafael can help have a look and confirm if it's correct
or not.

Thanks
Baoquan

> > 
> > I checked code, and have no any idea. Add Joey Lee to list, see if he
> > can help answer this.
> > 
> > > 
> > > Do you have any idea?
> > > 
> > > [1] https://lkml.org/lkml/2014/3/10/123
> > > [2] https://lkml.org/lkml/2014/3/12/3
> > > 
> > > 
> > >  drivers/iommu/dmar.c                | 27 +++++++++++----------------
> > >  drivers/iommu/intel-iommu.c         |  2 ++
> > >  drivers/iommu/intel_irq_remapping.c | 17 ++++++++++++++++-
> > >  include/linux/dmar.h                |  2 ++
> > >  init/main.c                         |  2 +-
> > >  5 files changed, 32 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > > index c8b0329..e6261b7 100644
> > > --- a/drivers/iommu/dmar.c
> > > +++ b/drivers/iommu/dmar.c
> > > @@ -68,6 +68,8 @@ DECLARE_RWSEM(dmar_global_lock);
> > >  LIST_HEAD(dmar_drhd_units);
> > > 
> > >  struct acpi_table_header * __initdata dmar_tbl;
> > > +struct acpi_table_header * __initdata dmar_tbl_original;
> > > +
> > >  static int dmar_dev_scope_status = 1;
> > >  static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
> > > 
> > > @@ -627,6 +629,7 @@ parse_dmar_table(void)
> > >  	 * fixed map.
> > >  	 */
> > >  	dmar_table_detect();
> > > +	dmar_tbl_original = dmar_tbl;
> > > 
> > >  	/*
> > >  	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
> > > @@ -811,26 +814,18 @@ int __init dmar_dev_scope_init(void)
> > > 
> > >  int __init dmar_table_init(void)
> > >  {
> > > -	static int dmar_table_initialized;
> > >  	int ret;
> > > 
> > > -	if (dmar_table_initialized == 0) {
> > > -		ret = parse_dmar_table();
> > > -		if (ret < 0) {
> > > -			if (ret != -ENODEV)
> > > -				pr_info("Parse DMAR table failure.\n");
> > > -		} else  if (list_empty(&dmar_drhd_units)) {
> > > -			pr_info("No DMAR devices found\n");
> > > -			ret = -ENODEV;
> > > -		}
> > > -
> > > -		if (ret < 0)
> > > -			dmar_table_initialized = ret;
> > > -		else
> > > -			dmar_table_initialized = 1;
> > > +	ret = parse_dmar_table();
> > > +	if (ret < 0) {
> > > +		if (ret != -ENODEV)
> > > +			pr_info("Parse DMAR table failure.\n");
> > > +	} else  if (list_empty(&dmar_drhd_units)) {
> > > +		pr_info("No DMAR devices found\n");
> > > +		ret = -ENODEV;
> > >  	}
> > > 
> > > -	return dmar_table_initialized < 0 ? dmar_table_initialized : 0;
> > > +	return ret;
> > >  }
> > > 
> > >  static void warn_invalid_dmar(u64 addr, const char *message)
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > index 687f18f..90f74f4 100644
> > > --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -4832,6 +4832,8 @@ int __init intel_iommu_init(void)
> > >  	}
> > > 
> > >  	down_write(&dmar_global_lock);
> > > +
> > > +	intel_iommu_free_dmars();
> > >  	if (dmar_table_init()) {
> > >  		if (force_on)
> > >  			panic("tboot: Failed to initialize DMAR table\n");
> > > diff --git a/drivers/iommu/intel_irq_remapping.c
> > > b/drivers/iommu/intel_irq_remapping.c
> > > index a5b89f6..ccaacda 100644
> > > --- a/drivers/iommu/intel_irq_remapping.c
> > > +++ b/drivers/iommu/intel_irq_remapping.c
> > > @@ -675,7 +675,7 @@ static void __init intel_cleanup_irq_remapping(void)
> > >  		pr_warn("Failed to enable irq remapping. You are vulnerable to
> > > irq-injection attacks.\n");
> > >  }
> > > 
> > > -static int __init intel_prepare_irq_remapping(void)
> > > +static int __init __intel_prepare_irq_remapping(void)
> > >  {
> > >  	struct dmar_drhd_unit *drhd;
> > >  	struct intel_iommu *iommu;
> > > @@ -743,6 +743,21 @@ static int __init intel_prepare_irq_remapping(void)
> > >  	return -ENODEV;
> > >  }
> > > 
> > > +static int __init intel_prepare_irq_remapping(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = __intel_prepare_irq_remapping();
> > > +
> > > +	if (dmar_tbl_original) {
> > > +		acpi_put_table(dmar_tbl_original);
> > > +		dmar_tbl_original = NULL;
> > > +		dmar_tbl = NULL;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /*
> > >   * Set Posted-Interrupts capability.
> > >   */
> > > diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> > > index e8ffba1..987b076 100644
> > > --- a/include/linux/dmar.h
> > > +++ b/include/linux/dmar.h
> > > @@ -50,6 +50,8 @@ struct dmar_dev_scope {
> > > 
> > >  #ifdef CONFIG_DMAR_TABLE
> > >  extern struct acpi_table_header *dmar_tbl;
> > > +extern struct acpi_table_header *dmar_tbl_original;
> > > +
> > >  struct dmar_drhd_unit {
> > >  	struct list_head list;		/* list of drhd units	*/
> > >  	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
> > > diff --git a/init/main.c b/init/main.c
> > > index 52dee20..052481f 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -655,12 +655,12 @@ asmlinkage __visible void __init start_kernel(void)
> > >  	kmemleak_init();
> > >  	setup_per_cpu_pageset();
> > >  	numa_policy_init();
> > > -	acpi_early_init();
> > >  	if (late_time_init)
> > >  		late_time_init();
> > >  	calibrate_delay();
> > >  	pidmap_init();
> > >  	anon_vma_init();
> > > +	acpi_early_init();
> > >  #ifdef CONFIG_X86
> > >  	if (efi_enabled(EFI_RUNTIME_SERVICES))
> > >  		efi_enter_virtual_mode();
> > > 
> > > Thanks,
> > > 	dou.
> > > > 
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > 	dou.
> > > > > > 
> > > > > > Thanks
> > > > > > Lv
> > > > > > 
> > > > > > > From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
> > > > > > > Sent: Friday, July 14, 2017 1:53 PM
> > > > > > > To: x86@kernel.org; linux-kernel@vger.kernel.org
> > > > > > > Cc: tglx@linutronix.de; mingo@kernel.org; hpa@zytor.com; ebiederm@xmission.com; bhe@redhat.com;
> > > > > > > peterz@infradead.org; izumi.taku@jp.fujitsu.com; tokunaga.keiich@jp.fujitsu.com; Dou Liyang
> > > > > > > <douly.fnst@cn.fujitsu.com>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Zheng,
> > > > > > > Lv <lv.zheng@intel.com>; Julian Wollrath <jwollrath@web.de>
> > > > > > > Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
> > > > > > > 
> > > > > > > Linux uses acpi_early_init() to put the ACPI table management into
> > > > > > > the late stage from the early stage where the mapped ACPI tables is
> > > > > > > temporary and should be unmapped.
> > > > > > > 
> > > > > > > But, now initializing interrupt delivery mode should map and parse the
> > > > > > > DMAR table earlier in the early stage. This causes an ACPI error when
> > > > > > > Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
> > > > > > > the DMAR table after using in the early stage.
> > > > > > > 
> > > > > > > Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
> > > > > > > be mapped and parsed in late stage like before.
> > > > > > > 
> > > > > > > Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
> > > > > > > Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > > > > > > Cc: linux-acpi@vger.kernel.org
> > > > > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > > > > Cc: Zheng, Lv <lv.zheng@intel.com>
> > > > > > > Cc: Julian Wollrath <jwollrath@web.de>
> > > > > > > ---
> > > > > > > Test in my own PC(Lenovo M4340).
> > > > > > > Ask help for doing regression testing for the bug said in commit c4e1acbb35e4
> > > > > > > ("ACPI / init: Invoke early ACPI initialization later").
> > > > > > > 
> > > > > > >  init/main.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > > index df58a41..7a09467 100644
> > > > > > > --- a/init/main.c
> > > > > > > +++ b/init/main.c
> > > > > > > @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
> > > > > > >  	kmemleak_init();
> > > > > > >  	setup_per_cpu_pageset();
> > > > > > >  	numa_policy_init();
> > > > > > > +	acpi_early_init();
> > > > > > >  	if (late_time_init)
> > > > > > >  		late_time_init();
> > > > > > >  	calibrate_delay();
> > > > > > >  	pidmap_init();
> > > > > > >  	anon_vma_init();
> > > > > > > -	acpi_early_init();
> > > > > > >  #ifdef CONFIG_X86
> > > > > > >  	if (efi_enabled(EFI_RUNTIME_SERVICES))
> > > > > > >  		efi_enter_virtual_mode();
> > > > > > > --
> > > > > > > 2.5.5
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> > 
> 
> 
