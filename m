From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v5] acpi, apei: add Boot Error Record Table (BERT) support
Date: Tue, 19 Jan 2016 18:49:55 +0800
Message-ID: <CADyBb7uF=0WJVaZzfhKNLMw+f+9b2CEWw0MDfkn_s6k7LyhbEw@mail.gmail.com>
References: <1453196042-12273-1-git-send-email-fu.wei@linaro.org>
	<20160119101258.GB15503@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160119101258.GB15503@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, "Chen, Gong" <gong.chen@intel.com>, Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, tbaicar@codeaurora.org, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Borislav,

On 19 January 2016 at 18:12, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Jan 19, 2016 at 05:34:02PM +0800, fu.wei@linaro.org wrote:
>> From: Huang Ying <ying.huang@intel.com>
>>
>> ACPI/APEI is designed to verifiy/report H/W errors, like Corrected
>> Error(CE) and Uncorrected Error(UC). It contains four tables: HEST,
>> ERST, EINJ and BERT. The first three tables have been merged for
>> a long time, but because of lacking BIOS support for BERT, the
>> support for BERT is pending until now. Recently on ARM 64 platform
>> it is has been supported. So here we come.
>>
>> Under normal circumstances, when a hardware error occurs, kernel will
>> be notified via NMI, MCE or some other method, then kernel will
>> process the error condition, report it, and recover it if possible.
>> But sometime, the situation is so bad, so that firmware may choose to
>> reset directly without notifying Linux kernel.
>>
>> Linux kernel can use the Boot Error Record Table (BERT) to get the
>> un-notified hardware errors that occurred in a previous boot. In this
>> patch, the error information is reported via printk.
>>
>> For more information about BERT, please refer to ACPI Specification
>> version 6.0, section 18.3.1:
>>   http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
>>
>> The following log is a BERT record after system reboot because of hitting
>> a fatal memory error:
>> BERT: Error records from previous boot:
>> [Hardware Error]: It has been corrected by h/w and requires no further action
>> [Hardware Error]: event severity: corrected
>> [Hardware Error]:  Error 0, type: recoverable
>> [Hardware Error]:   section_type: memory error
>> [Hardware Error]:   error_status: 0x0000000000000400
>> [Hardware Error]:   physical_address: 0xffffffffffffffff
>> [Hardware Error]:   card: 1 module: 2 bank: 3 row: 1 column: 2 bit_position: 5
>> [Hardware Error]:   error_type: 2, single-bit ECC
>>
>> [Tomasz Nowicki: Clear error status at the end of error handling]
>> [Tony: Applied some cleanups suggested by Fu Wei]
>> [Fu Wei: delete EXPORT_SYMBOL_GPL(bert_disable), improve the code]
>>
>> Signed-off-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
>> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>> Changelog:
>> v5: Drop some superfluous comments.
>>     Use the introduce of BERT in ACPI Specification instead of original one
>>     at the head of bert.c.
>>     Fix typo in apei-internal.h
>>     Simplify the introduce of bert_disable.
>>
>> v4: https://lkml.org/lkml/2016/1/8/382
>>     Fix the "#undef" bug
>>     Improve the instruction of "bert_disable",
>>     Delete the useless declaration in include/acpi/apei.h.
>>
>> v3: https://lkml.org/lkml/2016/1/7/214
>>     Merge the two patches
>>     Do some improvements according to Borislav's suggestion.
>>
>> v2: https://lkml.org/lkml/2015/8/18/336
>>     Delete EXPORT_SYMBOL_GPL(bert_disable), because "bert_disable" is only
>>     used in bert.c for now.
>>     Do some code-style cleanups.
>>
>> v1: The first upstream version submitted in linux-acpi mailing list:
>>     http://www.spinics.net/lists/linux-acpi/msg57384.html
>>
>>  Documentation/kernel-parameters.txt |   3 +
>>  drivers/acpi/apei/Makefile          |   2 +-
>>  drivers/acpi/apei/apei-internal.h   |   2 +-
>>  drivers/acpi/apei/bert.c            | 150 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 155 insertions(+), 2 deletions(-)
>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Great thanks for your help :-)

>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
