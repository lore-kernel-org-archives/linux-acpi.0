From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
Date: Fri, 17 Mar 2017 18:05:13 +0000
Message-ID: <20170317180513.GB15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170206185015.12296-2-fu.wei@linaro.org>
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

On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei@linaro.org wrote:
> +static u32 arch_timer_get_sysreg_freq(void)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of sysreg.
> +	 */
> +	return arch_timer_get_cntfrq();
> +}

We already have arch_timer_get_cntfrq(), so I don't see the point in
this wrapper.

> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
> +{
> +	/*
> +	 * Try to get the frequency from the CNTFRQ of timer frame registers.
> +	 * Note: please verify cntbase in caller.
> +	 */
> +	return readl_relaxed(cntbase + CNTFRQ);
> +}

Wrapping the MMIO read makes sense if we're going to do this in more
than one place, so I'm happy with this wrapper.

If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
the comments, then this looks fine to me.

Thanks,
Mark.
