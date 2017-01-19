From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 19 Jan 2017 19:06:10 +0800
Message-ID: <CADyBb7sA_sMmTcBtXDSNNFzZ_BjVAUL+c-FXWmHaEnH_SXyCUg@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun,

On 19 January 2017 at 17:20, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Fuwei,
>
>
> On 2017/1/18 21:25, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Clean up printk() usage
>>         2. Rename the type macros
>>         3. Rename the PPI enum & enum values
>>         4. Move the type macro and PPI enum into the header file
>>         5. Add new enum for SPIs
>>         6. Rework PPI determination;
>>         7. Rework counter frequency detection;
>>         8. Refactor arch_timer_needs_probing, move it into DT init call
>>         9. Introduce some new structs and refactor the MMIO timer init
>> code
>>         for reusing some common code.
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer.
>>
>> This patchset has been tested on the following platforms with ACPI
>> enabled:
>>     (1)ARM Foundation v8 model
>>
>> Changelog:
>> v20: https://lkml.org/lkml/2017/1/18/
>>      Reorder the first 4 patches and split the 4th patches.
>>      Leave CNTHCTL_* as they originally were.
>>      Fix the bug in arch_timer_select_ppi.
>>      Split "Rework counter frequency detection" patch.
>>      Rework the arch_timer_detect_rate function.
>>      Improve the commit message of "Refactor MMIO timer probing".
>>      Rebase to 4.10.0-rc4
>
>
> Other than some minor comments I raised, the patch set
> looks fine to me, and I tested this patch set on D03,
> the percpu arch timer works fine as before.
>
> With the comments fixed,
> Reviewed-by: Hanjun Guo <hanjun.gu@linaro.org>
> Tested-by: Hanjun Guo <hanjun.gu@linaro.org>

Great thanks for your testing. :-)

will apply Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org> on all patches,
and Tested-by: Hanjun Guo <hanjun.guo@linaro.org> on arch_timer patches.

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
