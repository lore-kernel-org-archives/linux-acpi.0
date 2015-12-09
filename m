From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Date: Wed, 9 Dec 2015 11:25:46 +0800
Message-ID: <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
	<20151208123433.GB404@red-moon>
	<5666D28C.4090305@linaro.org>
	<CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
	<20151208140720.GA2395@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151208140720.GA2395@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, rrichter@cavium.com, jarkko.nikula@linux.intel.com, Jonathan Zhang <jon.zhixiong.zhang@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Lorenzo,

On 8 December 2015 at 22:07, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Dec 08, 2015 at 09:08:24PM +0800, Fu Wei wrote:
>> Hi Lorenzo,
>>
>>
>>
>> On 8 December 2015 at 20:52, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> > Hi Lorenzo,
>> >
>> > On 12/08/2015 08:34 PM, Lorenzo Pieralisi wrote:
>> >>
>> >> On Tue, Dec 08, 2015 at 03:03:03PM +0800, fu.wei@linaro.org wrote:
>> >>>
>> >>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> >>
>> >>
>> >> [...]
>> >>
>> >>> +#if defined(__i386__) || defined(__x86_64__)
>> >>>   /*
>> >>>    * Check if firmware advertises firmware first mode. We need FF bit to
>> >>> be set
>> >>>    * along with a set of MC banks which work in FF mode.
>> >>>    */
>> >>>   static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr,
>> >>> void *data)
>> >>>   {
>> >>> -       return arch_apei_enable_cmcff(hest_hdr, data);
>> >>> +       if (!acpi_disable_cmcff)
>> >>
>> >>
>> >> Why do not you define the flag above in this file (move it out of x86 -
>> >> that's what I was aiming at in my previous reply) and remove this
>> >> ifdeffery
>> >> altogether (First firmware handling could apply to arm64 too according to
>> >> specs and ACPI on arm64 guidelines) ?
>> >
>> >
>> > If I understand it correctly, CMC (Corrected Machine Check) is for IA32
>> > only, see section 18.3.2.1 IA-32 Architecture Machine Check Exception
>> > in ACPI 6.0. for ARM64, we can use other type of error source for
>> > firmware first handling, such as Generic Hardware Error Source, did
>> > I miss something?
>>
>> yes, that is why I try to use "#if defined(__i386__) ||
>> defined(__x86_64__)" instead of moving acpi_disable_cmcff out of x86
>> code to here.
>>
>> And I thinks we also can do "arch_apei_enable_cmcff" -->
>> "apei_enable_ia_cmcff" because that is IA32 only.
>>
>> Please correct me if I misunderstand something.  Thanks :-)
>
> No you are right, I was confused by the arch_apei_enable_cmcff __weak
> function declaration, I am not sure that makes much sense, as you say.
>

Thanks :-)


> Side note: I wonder if there is a way to make the TLB flushing API common
> across architectures therefore avoiding this arch_apei_flush_tlb* churn.

yes, make sense, I will think about this today , thanks for your suggestion.

>
> Thanks,
> Lorenzo
>
>> Great thanks for your feedback :-)
>>
>> >
>> > Thanks
>> > Hanjun
>>
>>
>>
>> --
>> Best regards,
>>
>> Fu Wei
>> Software Engineer
>> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
>> Ph: +86 21 61221326(direct)
>> Ph: +86 186 2020 4684 (mobile)
>> Room 1512, Regus One Corporate Avenue,Level 15,
>> One Corporate Avenue,222 Hubin Road,Huangpu District,
>> Shanghai,China 200021
>>



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
