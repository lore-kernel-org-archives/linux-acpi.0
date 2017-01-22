From: DonMartio <donmartio@larkos.de>
Subject: Re: Only one core of four since kernel 4.9
Date: Sun, 22 Jan 2017 15:48:27 +0100
Message-ID: <85e6af97-5a3a-9952-2a35-3aa91e28fef8@larkos.de>
References: <df38fa50-ccb3-0377-f71c-50ac08cfc749@larkos.de>
 <c0395283-31d8-5043-a601-4587d55fe7da@larkos.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E860BE4EFE84FEFEB824F3DD"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from larkos.de ([188.68.52.65]:46140 "EHLO mylarkos.supersrv.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750925AbdAVPT3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Jan 2017 10:19:29 -0500
In-Reply-To: <c0395283-31d8-5043-a601-4587d55fe7da@larkos.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, donmartio@larkos.de

This is a multi-part message in MIME format.
--------------E860BE4EFE84FEFEB824F3DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Got a kernel 4.9.5 running now with all my four cores.
I created a small patch which work but may be not the correct way to 
solve this issue.

kind regards
Martin

On 21.01.2017 19:06, Martin Regner wrote:
> Hi again,
>
> I fiddled around a little bit and added some logging.
>
> This shows a strange thing:
>
> [ 0.000000] DONMARTIO apicid 5
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 1
> [ 0.000000] DONMARTIO disabled cpus 1
> [ 0.000000] DONMARTIO cpu 1
> [ 0.000000] DONMARTIO apicid 6
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 2
> [ 0.000000] DONMARTIO disabled cpus 2
> [ 0.000000] DONMARTIO cpu 2
> [ 0.000000] DONMARTIO apicid 7
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 3
> [ 0.000000] DONMARTIO disabled cpus 3
> [ 0.000000] DONMARTIO cpu 3
> [ 0.000000] DONMARTIO apicid 8
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 4
> [ 0.000000] DONMARTIO disabled cpus 4
> [ 0.000000] DONMARTIO cpu 4
> [ 0.000000] DONMARTIO apicid 16
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO disabled cpus 4
> [ 0.000000] DONMARTIO cpu 0
> [ 0.000000] DONMARTIO apicid 17
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 5
> [ 0.000000] DONMARTIO disabled cpus 4
> [ 0.000000] DONMARTIO cpu 5
> [ 0.000000] DONMARTIO apicid 18
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 6
> [ 0.000000] DONMARTIO disabled cpus 4
> [ 0.000000] DONMARTIO cpu 6
> [ 0.000000] DONMARTIO apicid 19
> [ 0.000000] DONMARTIO physical_apicid 16
> [ 0.000000] DONMARTIO logical cpuids 7
> [ 0.000000] DONMARTIO disabled cpus 4
> [ 0.000000] DONMARTIO cpu 7
>
>
> The system checks eight cpu's on my quadcore. The first four are 
> disabled.
>
> If i add this line
>
> if(apicid < 16) return -ENODEV;
>
> at the beginning of the function __generic_processor_info, i get all 4 
> cores.
> (I took the 16, because i know the lowest apicid from the kernel 
> 4.8.17 output).
>
> I'm really curious what's going wrong here.
>
> Kind regards
> Martin
>
>
> On 20.01.2017 07:33, DonMartio wrote:
>> Hi,
>>
>> since kernel 4.9 only one core is recognized of my AMD FX(tm)-4100 
>> Quad-Core Processor.
>> I discussed this here 
>> <https://forums.gentoo.org/viewtopic-t-1056638-start-25-postdays-0-postorder-asc-highlight-.html> 
>> first and tried a lot of thinks without any luck.
>>
>> One tip of another user was to do a bisect first and then file a 
>> possible bug.
>> I did that with kernel 4.8.17 (which works) and 4.9 and came finally 
>> to the following commit:
>>
>> [8f54969dc8d6704632b42cbb5e47730cd75cc713] x86/acpi: Introduce 
>> persistent storage for cpuid <-> apicid mapping
>> 8f54969dc8d6704632b42cbb5e47730cd75cc713 is the first bad commit
>> commit 8f54969dc8d6704632b42cbb5e47730cd75cc713
>> Author: Gu Zheng<guz.fnst@cn.fujitsu.com>
>> Date:   Thu Aug 25 16:35:16 2016 +0800
>>
>>     x86/acpi: Introduce persistent storage for cpuid <-> apicid mapping
>>
>>     The whole patch-set aims at making cpuid <-> nodeid mapping 
>> persistent. So that,
>>     when node online/offline happens, cache based on cpuid <-> nodeid 
>> mapping such as
>>     wq_numa_possible_cpumask will not cause any problem.
>>     It contains 4 steps:
>>     1. Enable apic registeration flow to handle both enabled and 
>> disabled cpus.
>>     2. Introduce a new array storing all possible cpuid <-> apicid 
>> mapping.
>>     3. Enable _MAT and MADT relative apis to return non-present or 
>> disabled cpus' apicid.
>>     4. Establish all possible cpuid <-> nodeid mapping.
>>
>>     This patch finishes step 2.
>>
>>     In this patch, we introduce a new static array named 
>> cpuid_to_apicid[],
>>     which is large enough to store info for all possible cpus.
>>
>>     And then, we modify the cpuid calculation. In 
>> generic_processor_info(),
>>     it simply finds the next unused cpuid. And it is also why the 
>> cpuid <-> nodeid
>>     mapping changes with node hotplug.
>>
>>     After this patch, we find the next unused cpuid, map it to an 
>> apicid,
>>     and store the mapping in cpuid_to_apicid[], so that cpuid <-> apicid
>>     mapping will be persistent.
>>
>>     And finally we will use this array to make cpuid <-> nodeid 
>> persistent.
>>
>>     cpuid <-> apicid mapping is established at local apic 
>> registeration time.
>>     But non-present or disabled cpus are ignored.
>>
>>     In this patch, we establish all possible cpuid <-> apicid mapping 
>> when
>>     registering local apic.
>>
>>     Signed-off-by: Gu Zheng<guz.fnst@cn.fujitsu.com>
>>     Signed-off-by: Tang Chen<tangchen@cn.fujitsu.com>
>>     Signed-off-by: Zhu Guihua<zhugh.fnst@cn.fujitsu.com>
>>     Signed-off-by: Dou Liyang<douly.fnst@cn.fujitsu.com>
>>     Acked-by: Ingo Molnar<mingo@kernel.org>
>>     Cc:mika.j.penttila@gmail.com
>>     Cc:len.brown@intel.com
>>     Cc:rafael@kernel.org
>>     Cc:rjw@rjwysocki.net
>>     Cc:yasu.isimatu@gmail.com
>>     Cc:linux-mm@kvack.org
>>     Cc:linux-acpi@vger.kernel.org
>>     Cc:isimatu.yasuaki@jp.fujitsu.com
>>     Cc:gongzhaogang@inspur.com
>>     Cc:tj@kernel.org
>>     Cc:izumi.taku@jp.fujitsu.com
>>     Cc:cl@linux.com
>>     Cc:chen.tang@easystack.cn
>>     Cc:akpm@linux-foundation.org
>>     Cc:kamezawa.hiroyu@jp.fujitsu.com
>>     Cc:lenb@kernel.org
>> Link:http://lkml.kernel.org/r/1472114120-3281-4-git-send-email-douly.fnst@cn.fujitsu.com 
>>
>>     Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
>>
>> Is my cpuid missing in the mapping mentioned above?
>>
>> ~ # lscpu
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit, 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                4
>> On-line CPU(s) list:   0-3
>> Thread(s) per core:    2
>> Core(s) per socket:    2
>> Socket(s):             1
>> Vendor ID:             AuthenticAMD
>> CPU family:            21
>> Model:                 1
>> Model name:            AMD FX(tm)-4100 Quad-Core Processor
>> Stepping:              2
>> CPU MHz:               3600.000
>> CPU max MHz:           3600,0000
>> CPU min MHz:           1400,0000
>> BogoMIPS:              7183.66
>> Virtualization:        AMD-V
>> L1d cache:             16K
>> L1i cache:             64K
>> L2 cache:              2048K
>> L3 cache:              8192K
>> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep 
>> mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx 
>> mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl 
>> nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor 
>> ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy svm 
>> extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop 
>> skinit wdt lwp fma4 nodeid_msr topoext perfctr_core perfctr_nb cpb 
>> hw_pstate vmmcall arat npt lbrv svm_lock nrip_save tsc_scale 
>> vmcb_clean flushbyasid decodeassists pausefilter pfthreshold
>>
>>
>> Or do i miss some new kernel config option?
>> Do you need more information?
>>
>> Thanks in advance
>> Martin
>>
>


--------------E860BE4EFE84FEFEB824F3DD
Content-Type: text/x-patch;
 name="apic-cpu-detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="apic-cpu-detection.patch"

diff -urN a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c	2017-01-20 21:12:10.000000000 +0100
+++ b/arch/x86/kernel/apic/apic.c	2017-01-22 15:06:45.058115715 +0100
@@ -2150,6 +2150,10 @@
 
 		/* Logical cpuid 0 is reserved for BSP. */
 		cpuid_to_apicid[0] = apicid;
+	} else if(!boot_cpu_detected) {
+		pr_warning("APIC: physical cpu not yet deteced. apicid is %d, physical apicid is %d.\n", 
+			apicid, boot_cpu_physical_apicid);
+		return -EINVAL;
 	} else {
 		cpu = allocate_logical_cpuid(apicid);
 		if (cpu < 0) {

--------------E860BE4EFE84FEFEB824F3DD--
