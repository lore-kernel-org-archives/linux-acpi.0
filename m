From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 19 Jan 2017 17:20:07 +0800
Message-ID: <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, wim@iguana.be, wei@redhat.com, al.stone@linaro.org, tn@semihalf.com, timur@codeaurora.org, linux-acpi@vger.kernel.org, linux@roeck-us.net, harba@codeaurora.org, julien.grall@arm.com, linux-watchdog@vger.kernel.org, arnd@arndb.de, jcm@redhat.com, cov@codeaurora.org, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, rruigrok@codeaurora.org, leo.duran@amd.com, Suravee.Suthikulpanit@amd.com, christoffer.dall@linaro.org
List-Id: linux-acpi@vger.kernel.org

Hi Fuwei,

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Clean up printk() usage
>         2. Rename the type macros
>         3. Rename the PPI enum & enum values
>         4. Move the type macro and PPI enum into the header file
>         5. Add new enum for SPIs
>         6. Rework PPI determination;
>         7. Rework counter frequency detection;
>         8. Refactor arch_timer_needs_probing, move it into DT init call
>         9. Introduce some new structs and refactor the MMIO timer init code
>         for reusing some common code.
>
>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (3)Simplify ACPI code for arm_arch_timer
>
>     (4)Add GTDT support for ARM memory-mapped timer.
>
> This patchset has been tested on the following platforms with ACPI enabled:
>     (1)ARM Foundation v8 model
>
> Changelog:
> v20: https://lkml.org/lkml/2017/1/18/
>      Reorder the first 4 patches and split the 4th patches.
>      Leave CNTHCTL_* as they originally were.
>      Fix the bug in arch_timer_select_ppi.
>      Split "Rework counter frequency detection" patch.
>      Rework the arch_timer_detect_rate function.
>      Improve the commit message of "Refactor MMIO timer probing".
>      Rebase to 4.10.0-rc4

Other than some minor comments I raised, the patch set
looks fine to me, and I tested this patch set on D03,
the percpu arch timer works fine as before.

With the comments fixed,
Reviewed-by: Hanjun Guo <hanjun.gu@linaro.org>
Tested-by: Hanjun Guo <hanjun.gu@linaro.org>

Thanks
Hanjun
