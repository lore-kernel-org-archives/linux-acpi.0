From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Wed, 26 Jul 2017 20:19:22 +0800
Message-ID: <2855c940-9e57-f06f-d9f0-dc5eb4408b37@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <1AE640813FDE7649BE1B193DEA596E886CEE2130@SHSMSX101.ccr.corp.intel.com>
 <d0ce9178-4b06-081b-6b12-a8cd1c5352b7@cn.fujitsu.com>
 <20170718084521.GC2344@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:43770 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751452AbdGZMTa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 08:19:30 -0400
In-Reply-To: <20170718084521.GC2344@x1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "peterz@infradead.org" <peterz@infradead.org>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "tokunaga.keiich@jp.fujitsu.com" <tokunaga.keiich@jp.fujitsu.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Julian Wollrath <jwollrath@web.de>

Hi Baoquan,

At 07/18/2017 04:45 PM, bhe@redhat.com wrote:
> On 07/18/17 at 02:08pm, Dou Liyang wrote:
>> Hi, Zheng
>>
>> At 07/18/2017 01:18 PM, Zheng, Lv wrote:
>>> Hi,
>>>
>>> Can the problem be fixed by invoking acpi_put_table() for mapped DMAR table?
>>
>> Invoking acpi_put_table() is my first choice. But it made the kernel
>> *panic* when we try to get the table again in intel_iommu_init() in
>> late stage.
>>
>> I am also confused that:
>>
>> There are two places where we used DMAR table in Linux:
>>
>> 1) In detect_intel_iommu() in ACPI early stage:
>>
>> ...
>> status = acpi_get_table(ACPI_SIG_DMAR, 0, &dmar_tbl);
>> ....
>> if (dmar_tbl) {
>> 	acpi_put_table(dmar_tbl);
>> 	dmar_tbl = NULL;
>> }
>>
>> 2) In dmar_table_init() in ACPI late stage:
>>
>> ...
>> status = acpi_get_table(ACPI_SIG_DMAR, 0, &dmar_tbl);
>> ...
>>
>> As we know, dmar_table_init() is called by intel_iommu_init() and
>> intel_prepare_irq_remapping().
>>
>> When I invoked acpi_put_table() in the intel_prepare_irq_remapping() in
>> early stage like 1) shows, kernel will panic.
>
> That's because acpi_put_table() will make the table pointer be NULL,
> while dmar_table_init() will skip parse_dmar_table() calling if
> dmar_table_initialized is set to 1 in intel_prepare_irq_remapping().
>
> Dmar hardware support interrupt remapping and io remapping separately. But
> intel_iommu_init() is called later than intel_prepare_irq_remapping().
> So what if make dmar_table_init() a reentrant function? You can just
> have a try, but maybe not a good idea, the dmar table will be parsed
> twice.

The true reason why the kernel panic is that acpi_put_table() only
released DMAR table structure, but not released the remapping
structures in DMAR table, such as DRHD, RMRR. So the address of
RMRR parsed in early ACPI stage will be used in late ACPI stage in
intel_iommu_init(), which make the kernel panic.

The solution is invoking the intel_iommu_free_dmars() before
dmar_table_init() in intel_iommu_init() to release the RMRR.
Demo code will show at the bottom.

I prefer to invoke acpi_early_init() earlier. But it needs a regression
test[1].

I am looking for Thinkpad x121e (AMD E-450 APU) to test. I have tested
it in Thinkpad s430, It's OK.

BTY, I am confused how does the ACPI subsystem affect PIT which
will be used to fast calibrate CPU frequency[2].

Do you have any idea?

[1] https://lkml.org/lkml/2014/3/10/123
[2] https://lkml.org/lkml/2014/3/12/3


  drivers/iommu/dmar.c                | 27 +++++++++++----------------
  drivers/iommu/intel-iommu.c         |  2 ++
  drivers/iommu/intel_irq_remapping.c | 17 ++++++++++++++++-
  include/linux/dmar.h                |  2 ++
  init/main.c                         |  2 +-
  5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c8b0329..e6261b7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -68,6 +68,8 @@ DECLARE_RWSEM(dmar_global_lock);
  LIST_HEAD(dmar_drhd_units);

  struct acpi_table_header * __initdata dmar_tbl;
+struct acpi_table_header * __initdata dmar_tbl_original;
+
  static int dmar_dev_scope_status = 1;
  static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];

@@ -627,6 +629,7 @@ parse_dmar_table(void)
  	 * fixed map.
  	 */
  	dmar_table_detect();
+	dmar_tbl_original = dmar_tbl;

  	/*
  	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
@@ -811,26 +814,18 @@ int __init dmar_dev_scope_init(void)

  int __init dmar_table_init(void)
  {
-	static int dmar_table_initialized;
  	int ret;

-	if (dmar_table_initialized == 0) {
-		ret = parse_dmar_table();
-		if (ret < 0) {
-			if (ret != -ENODEV)
-				pr_info("Parse DMAR table failure.\n");
-		} else  if (list_empty(&dmar_drhd_units)) {
-			pr_info("No DMAR devices found\n");
-			ret = -ENODEV;
-		}
-
-		if (ret < 0)
-			dmar_table_initialized = ret;
-		else
-			dmar_table_initialized = 1;
+	ret = parse_dmar_table();
+	if (ret < 0) {
+		if (ret != -ENODEV)
+			pr_info("Parse DMAR table failure.\n");
+	} else  if (list_empty(&dmar_drhd_units)) {
+		pr_info("No DMAR devices found\n");
+		ret = -ENODEV;
  	}

-	return dmar_table_initialized < 0 ? dmar_table_initialized : 0;
+	return ret;
  }

  static void warn_invalid_dmar(u64 addr, const char *message)
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 687f18f..90f74f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4832,6 +4832,8 @@ int __init intel_iommu_init(void)
  	}

  	down_write(&dmar_global_lock);
+
+	intel_iommu_free_dmars();
  	if (dmar_table_init()) {
  		if (force_on)
  			panic("tboot: Failed to initialize DMAR table\n");
diff --git a/drivers/iommu/intel_irq_remapping.c 
b/drivers/iommu/intel_irq_remapping.c
index a5b89f6..ccaacda 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -675,7 +675,7 @@ static void __init intel_cleanup_irq_remapping(void)
  		pr_warn("Failed to enable irq remapping. You are vulnerable to 
irq-injection attacks.\n");
  }

-static int __init intel_prepare_irq_remapping(void)
+static int __init __intel_prepare_irq_remapping(void)
  {
  	struct dmar_drhd_unit *drhd;
  	struct intel_iommu *iommu;
@@ -743,6 +743,21 @@ static int __init intel_prepare_irq_remapping(void)
  	return -ENODEV;
  }

+static int __init intel_prepare_irq_remapping(void)
+{
+	int ret;
+
+	ret = __intel_prepare_irq_remapping();
+
+	if (dmar_tbl_original) {
+		acpi_put_table(dmar_tbl_original);
+		dmar_tbl_original = NULL;
+		dmar_tbl = NULL;
+	}
+
+	return ret;
+}
+
  /*
   * Set Posted-Interrupts capability.
   */
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e8ffba1..987b076 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -50,6 +50,8 @@ struct dmar_dev_scope {

  #ifdef CONFIG_DMAR_TABLE
  extern struct acpi_table_header *dmar_tbl;
+extern struct acpi_table_header *dmar_tbl_original;
+
  struct dmar_drhd_unit {
  	struct list_head list;		/* list of drhd units	*/
  	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
diff --git a/init/main.c b/init/main.c
index 52dee20..052481f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -655,12 +655,12 @@ asmlinkage __visible void __init start_kernel(void)
  	kmemleak_init();
  	setup_per_cpu_pageset();
  	numa_policy_init();
-	acpi_early_init();
  	if (late_time_init)
  		late_time_init();
  	calibrate_delay();
  	pidmap_init();
  	anon_vma_init();
+	acpi_early_init();
  #ifdef CONFIG_X86
  	if (efi_enabled(EFI_RUNTIME_SERVICES))
  		efi_enter_virtual_mode();

Thanks,
	dou.
>
>>
>>
>> Thanks,
>>
>> 	dou.
>>>
>>> Thanks
>>> Lv
>>>
>>>> From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
>>>> Sent: Friday, July 14, 2017 1:53 PM
>>>> To: x86@kernel.org; linux-kernel@vger.kernel.org
>>>> Cc: tglx@linutronix.de; mingo@kernel.org; hpa@zytor.com; ebiederm@xmission.com; bhe@redhat.com;
>>>> peterz@infradead.org; izumi.taku@jp.fujitsu.com; tokunaga.keiich@jp.fujitsu.com; Dou Liyang
>>>> <douly.fnst@cn.fujitsu.com>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Zheng,
>>>> Lv <lv.zheng@intel.com>; Julian Wollrath <jwollrath@web.de>
>>>> Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
>>>>
>>>> Linux uses acpi_early_init() to put the ACPI table management into
>>>> the late stage from the early stage where the mapped ACPI tables is
>>>> temporary and should be unmapped.
>>>>
>>>> But, now initializing interrupt delivery mode should map and parse the
>>>> DMAR table earlier in the early stage. This causes an ACPI error when
>>>> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
>>>> the DMAR table after using in the early stage.
>>>>
>>>> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
>>>> be mapped and parsed in late stage like before.
>>>>
>>>> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>> Cc: linux-acpi@vger.kernel.org
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Zheng, Lv <lv.zheng@intel.com>
>>>> Cc: Julian Wollrath <jwollrath@web.de>
>>>> ---
>>>> Test in my own PC(Lenovo M4340).
>>>> Ask help for doing regression testing for the bug said in commit c4e1acbb35e4
>>>> ("ACPI / init: Invoke early ACPI initialization later").
>>>>
>>>>  init/main.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/init/main.c b/init/main.c
>>>> index df58a41..7a09467 100644
>>>> --- a/init/main.c
>>>> +++ b/init/main.c
>>>> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
>>>>  	kmemleak_init();
>>>>  	setup_per_cpu_pageset();
>>>>  	numa_policy_init();
>>>> +	acpi_early_init();
>>>>  	if (late_time_init)
>>>>  		late_time_init();
>>>>  	calibrate_delay();
>>>>  	pidmap_init();
>>>>  	anon_vma_init();
>>>> -	acpi_early_init();
>>>>  #ifdef CONFIG_X86
>>>>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>>>>  		efi_enter_virtual_mode();
>>>> --
>>>> 2.5.5
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
>
>


