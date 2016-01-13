From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
Date: Wed, 13 Jan 2016 09:52:37 +0800
Message-ID: <5695ADE5.7010501@linaro.org>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com> <56952DA1.4030401@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56952DA1.4030401@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, Marc Zyngier <marc.zyngier@arm.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com
List-Id: linux-acpi@vger.kernel.org



On 2016/1/13 0:45, Tomasz Nowicki wrote:
> On 12.01.2016 13:03, Marc Zyngier wrote:
>
>  > +    typer = readq_relaxed(redist_base + GICR_TYPER);
>  > +    /* don't map reserved page as it's buggy to access it */
>  > +    size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;
>
> [...]
>
>> Also, please map the whole region for the
>> redistributor as we have on the DT side (4 64kB pages for VLPIS capable
>> redistributors).
>
> Hanjun, is it something you had problem with?

Yes, for D02, it use 3 64kB pages for GICv4, it removed the reserved
page. In DT case, it has "stride" binding so it can support no standard
cases, seems that we can introduce "stride" for ACPI too.

Thanks
Hanjun
