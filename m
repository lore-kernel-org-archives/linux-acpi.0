From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 0/8] Add self-probe infrastructure and
 stacked irqdomain support for ACPI based GICv2/3 init
Date: Mon, 20 Jul 2015 17:06:08 +0800
Message-ID: <55ACBA00.4080101@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org> <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

Hi Timur,

On 07/18/2015 07:09 AM, Timur Tabi wrote:
> On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> This patch set introduce self-probe infrastructure to init IRQ
>> controllers and stacked irqdomain support for ACPI based GICv2/3
>> init.
>>
>> This patch set add its support for GIC verion which is introduced
>> in ACPI 6.0, based on that, we introduce the self-probe infrastructure,
>> the self-probe infrastructure for ACPI GIC init is similar as
>> IRQCHIP_DECLARE() and based on the GIC version support in ACPI
>> MADT table. we match the GIC version and GIC driver and load
>> it.
>>
>> After the self-probe infrastructure is ready, I cleanuped the GICv2
>> code to use the framework.
>>
>> Patch 4 implement the stacked irqdomain support for GICv2 based on
>> the model of mapping interrupt and device in ACPI.
>>
>> Patch 5~8 are ACPI based GICv3 init.
>
> All eight patches:
>
> Tested-by: Timur Tabi <timur@codeaurora.org>

Wonderful, Thanks a lot!

I got a question, do you test GICv3 in this patch set too?
if yes, that will be really great!

Just let you know, I'm still working on this patch set to try
to address Marc's comments (unify DT and ACPI to match the domain),
I'm not sure if any obstacles ahead, I will let you know the progress.

Regards
Hanjun
