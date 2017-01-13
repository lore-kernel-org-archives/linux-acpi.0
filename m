From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Fri, 13 Jan 2017 19:29:21 +0000
Message-ID: <20170113192920.GF2472@leverpostej>
References: <20161208173319.6618-1-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161208173319.6618-1-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: fu.wei@linaro.org
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, rruigrok@codeaurora.org, wim@iguana.be, wei@redhat.com, lorenzo.pieralisi@arm.com, al.stone@linaro.org, tn@semihalf.com, timur@codeaurora.org, daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org, linux@roeck-us.net, lenb@kernel.org, harba@codeaurora.org, julien.grall@arm.com, linux-watchdog@vger.kernel.org, arnd@arndb.de, marc.zyngier@arm.com, jcm@redhat.com, cov@codeaurora.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, leo.duran@amd.com, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, sudeep.holla@arm.com, christoffer.dall@linaro.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, Dec 09, 2016 at 01:33:04AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Move some enums and marcos to header file;
>         2. Add a new enum for spi type;
>         3. Improve printk relevant code;
>         4. Rename some enums and defines;
>         5. Rework PPI determination;
>         6. Rework counter frequency detection;
>         7. Refactor arch_timer_needs_probing, move it into DT init call
>         8. Introduce some new structs and refactor the MMIO timer init code
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

Once v4.10-rc4 comes out this weekend, could you please rebase and
repost this?

Marc and I will be happy to take a look then.

Thanks,
Mark.
