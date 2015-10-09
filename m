From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/16] irqdomain: Use an accessor for the of_node field
Date: Fri, 9 Oct 2015 16:24:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510091623090.6097@nanos>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com> <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 6 Oct 2015, Marc Zyngier wrote:
> index d3ca792..f644fdb 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -161,6 +161,11 @@ enum {
>  	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
>  };
>  
> +static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
> +{
> +	return d->of_node;
> +}
> +

Can you please make that a seperate patch, which I can expedite to
Linus? That way we can fix stuff which shows up in next as well.

Thanks,

	tglx
