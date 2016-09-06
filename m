From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
Date: Tue, 6 Sep 2016 16:36:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609061635000.5647@nanos>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org>
 <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fu Wei <fu.wei@linaro.org>
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, rruigrok@codeaurora.org, wim@iguana.be, wei@redhat.com, lorenzo.pieralisi@arm.com, al.stone@linaro.org, timur@codeaurora.org, daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org, linux@roeck-us.net, lenb@kernel.org, harba@codeaurora.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, marc.zyngier@arm.com, jcm@redhat.com, cov@codeaurora.org, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, leo.duran@amd.com, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, sudeep.holla@arm.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 6 Sep 2016, fu.wei@linaro.org wrote:
> +	if (timer_count < 0)
> +		pr_err("Failed to get platform timer info, skipping.\n");

So this prints something about skipping. But then it continues as if
nothing went wrong. That's either wrong or confusing or both.

> -	arch_timer_init();
> -	return 0;
> +	return arch_timer_init();

Thanks,

	tglx
