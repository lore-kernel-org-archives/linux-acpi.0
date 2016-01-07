From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v3] acpi, apei: add Boot Error Record Table (BERT) support
Date: Thu, 7 Jan 2016 16:22:59 +0000
Message-ID: <CAGCh1+k3CmSyFoJ1-V7GZfrECO0Sz=rHw_LAPhpt-WySBKVURA@mail.gmail.com>
References: <1452166023-14501-1-git-send-email-fu.wei@linaro.org>
	<201601072016.CEtra5NR%fengguang.wu@intel.com>
	<CADyBb7vJUhoMRhx8Fsn-3exPCF0KxPWqNKrBf47HpYJ7iOqvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADyBb7vJUhoMRhx8Fsn-3exPCF0KxPWqNKrBf47HpYJ7iOqvoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, "Chen, Gong" <gong.chen@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, tbaicar@codeaurora.org, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, bp <bp@alien8.de>, "matt.fleming" <matt.fleming@intel.com>, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On 7 January 2016 at 16:21, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Huang,
>
> On 7 January 2016 at 20:00, kbuild test robot <lkp@intel.com> wrote:
>> Hi Huang,
>>
>> [auto build test WARNING on pm/linux-next]
>> [also build test WARNING on v4.4-rc8 next-20160106]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-add-Boot-Error-Record-Table-BERT-support/20160107-193040
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> config: x86_64-lkp (attached as .config)
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/acpi/apei/bert.c:31:14: warning: extra tokens at end of #undef directive
>>     #undef pr_fmt(fmt)
>>                  ^
>>
>> vim +31 drivers/acpi/apei/bert.c
>>
>>     15   *
>>     16   * For more information about BERT, please refer to ACPI Specification
>>     17   * version 4.0, section 17.3.1
>>     18   *
>>     19   * This file is licensed under GPLv2.
>>     20   *
>>     21   */
>>     22
>>     23  #include <linux/kernel.h>
>>     24  #include <linux/module.h>
>>     25  #include <linux/init.h>
>>     26  #include <linux/acpi.h>
>>     27  #include <linux/io.h>
>>     28
>>     29  #include "apei-internal.h"
>>     30
>>   > 31  #undef pr_fmt(fmt)
>
> Do you have any idea?
> I did not get warnings when I compiled this for arm64.
> But without it, I got "redefined" warning.
>
Shouldn't it be just

#undef pr_fmt

No arguments!

Graeme

>>     32  #define pr_fmt(fmt) "BERT: " fmt
>>     33
>>     34  static int bert_disable;
>>     35
>>     36  static void __init bert_print_all(struct acpi_bert_region *region,
>>     37                                    unsigned int region_len)
>>     38  {
>>     39          /*
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021
