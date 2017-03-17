From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v21 03/13] clocksource: arm_arch_timer: remove
 arch_timer_detect_rate
Date: Fri, 17 Mar 2017 18:07:26 +0000
Message-ID: <20170317180725.GC15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-4-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-4-fu.wei@linaro.org>
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

On Tue, Feb 07, 2017 at 02:50:05AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The original counter frequency detection call(arch_timer_detect_rate)
> include getting the frequency from the per-cpu arch-timer and the
> memory-mapped (MMIO) timer interfaces. But they will be needed only when
> the system initializes the relevant timer.
> 
> This patch remove arch_timer_detect_rate founction, and use the
> arch_timer_get_sysreg_freq and arch_timer_get_mmio_freq directly.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Could you please fold this with the prior patch?

> @@ -1087,7 +1072,12 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  	 */
>  	if (!arch_timer_rate &&
>  	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> -		arch_timer_detect_rate(base);
> +		arch_timer_rate = arch_timer_get_mmio_freq(base);
> +	if (!arch_timer_rate) {
> +		pr_err(FW_BUG "frequency not available for MMIO timer.\n");

It would be better to say "MMIO frequency not available.\n" here.

Thanks,
Mark.
