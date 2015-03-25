From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 16/23] irqchip: Add GICv2 specific ACPI boot support
Date: Wed, 25 Mar 2015 17:27:28 +0000
Message-ID: <20150325172728.GL14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-17-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-17-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
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
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixo>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:49PM +0800, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> 
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> While now simple GICv2 init call is used, any further GIC features
> require generic infrastructure for proper ACPI irqchip initialization.
> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
> extension, GICv3/4 and its ITS are considered as next steps.
> 
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
