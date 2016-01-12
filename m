From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
Date: Tue, 12 Jan 2016 17:45:21 +0100
Message-ID: <56952DA1.4030401@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5694EB92.9030109@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 12.01.2016 13:03, Marc Zyngier wrote:

 > +	typer = readq_relaxed(redist_base + GICR_TYPER);
 > +	/* don't map reserved page as it's buggy to access it */
 > +	size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;

[...]

> Also, please map the whole region for the
> redistributor as we have on the DT side (4 64kB pages for VLPIS capable
> redistributors).

Hanjun, is it something you had problem with?

Tomasz
