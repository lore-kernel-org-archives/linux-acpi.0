From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v21 04/13] clocksource: arm_arch_timer: split
 arch_timer_rate for different types of timer
Date: Mon, 20 Mar 2017 21:35:12 +0800
Message-ID: <CADyBb7utYy=VQ=hZnuecnCo1o=bXLg19ONHESUYfhBUdahoprw@mail.gmail.com>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-5-fu.wei@linaro.org>
 <20170317190539.GD15909@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170317190539.GD15909@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gre>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 18 March 2017 at 03:05, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 07, 2017 at 02:50:06AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Currently, arch_timer_rate is used to store the frequency got from per-cpu
>> arch-timer or the memory-mapped (MMIO) timers. But those values come from
>> different registers which should all be initialized by firmware.
>>
>> This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
>> arch_timer_mmio_freq instead.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>
> Thanks for attacking this. Generally, I do think this is the right thing
> to do.
>
> However...
>
>> @@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
>>        * Try to determine the frequency from the device tree,
>>        * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>>        */
>> -     if (!arch_timer_rate &&
>> -         of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
>> -             arch_timer_rate = arch_timer_get_mmio_freq(base);
>> -     if (!arch_timer_rate) {
>> +     if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
>> +             arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
>> +     if (!arch_timer_mmio_freq) {
>>               pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>>               ret = -EINVAL;
>>               goto out;
>
> ... unfortunately, I believe that this will break some DT platforms that
> have been (unintentionally) relying on the way currently allow the
> frequency to be probed from either the MMIO timer or the sysreg timer.
>

Ah, I 'm really not aware of this. Thanks for pointing it out.

> So while the above was my suggestion, it was not my best.
>
> For the timebeing, let's leave the single arch_timer_rate, but ensure
> that it doesn't get in the way fo the ACPI code, by making the ACPI
> probe path:
>
> * Probe the sysreg timers first, using the sysreg cntfrq().
>
> * Probe the MMIO timers second, verifying that each MMIO cntfrq matches
>   the already-probed sysreg cntfrq.
>
> ... which is what I believe you suggested previously.

OK, NP, will do this way.

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
