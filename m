From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v21 04/13] clocksource: arm_arch_timer: split
 arch_timer_rate for different types of timer
Date: Fri, 17 Mar 2017 19:05:42 +0000
Message-ID: <20170317190539.GD15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-5-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-5-fu.wei@linaro.org>
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

On Tue, Feb 07, 2017 at 02:50:06AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Currently, arch_timer_rate is used to store the frequency got from per-cpu
> arch-timer or the memory-mapped (MMIO) timers. But those values come from
> different registers which should all be initialized by firmware.
> 
> This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
> arch_timer_mmio_freq instead.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Thanks for attacking this. Generally, I do think this is the right thing
to do.

However...

> @@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  	 * Try to determine the frequency from the device tree,
>  	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>  	 */
> -	if (!arch_timer_rate &&
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> -		arch_timer_rate = arch_timer_get_mmio_freq(base);
> -	if (!arch_timer_rate) {
> +	if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
> +		arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
> +	if (!arch_timer_mmio_freq) {
>  		pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>  		ret = -EINVAL;
>  		goto out;

... unfortunately, I believe that this will break some DT platforms that
have been (unintentionally) relying on the way currently allow the
frequency to be probed from either the MMIO timer or the sysreg timer.

So while the above was my suggestion, it was not my best.

For the timebeing, let's leave the single arch_timer_rate, but ensure
that it doesn't get in the way fo the ACPI code, by making the ACPI
probe path:

* Probe the sysreg timers first, using the sysreg cntfrq().

* Probe the MMIO timers second, verifying that each MMIO cntfrq matches
  the already-probed sysreg cntfrq.

... which is what I believe you suggested previously. 

Thanks,
Mark.
