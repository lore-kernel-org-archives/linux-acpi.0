From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
Date: Wed, 20 May 2015 20:34:26 +0100
Message-ID: <20150520193426.GT2067@n2100.arm.linux.org.uk>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
 <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 20, 2015 at 05:40:39PM +0800, Jiang Liu wrote:
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 350f188c92d2..baf8edebe26f 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -140,7 +140,7 @@ int __init arch_probe_nr_irqs(void)
>  static bool migrate_one_irq(struct irq_desc *desc)
>  {
>  	struct irq_data *d = irq_desc_get_irq_data(desc);
> -	const struct cpumask *affinity = d->affinity;
> +	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
>  	struct irq_chip *c;
>  	bool ret = false;
>  
> @@ -160,7 +160,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	if (!c->irq_set_affinity)
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
>  	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
> -		cpumask_copy(d->affinity, affinity);
> +		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
>  
>  	return ret;
>  }

> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 43581e166298..2eb82257aaee 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -650,6 +650,18 @@ static inline int irq_data_get_node(struct irq_data *d)
>  	return irq_common_data_get_node(d->common);
>  }
>  
> +static inline struct cpumask *irq_get_affinity_mask(int irq)
> +{
> +	struct irq_data *d = irq_get_irq_data(irq);
> +
> +	return d ? d->affinity : NULL;
> +}
> +
> +static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
> +{
> +	return d->affinity;
> +}
> +
>  unsigned int arch_dynirq_lower_bound(unsigned int from);
>  
>  int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,

For the above only,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
