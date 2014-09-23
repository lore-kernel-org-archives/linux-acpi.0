From: Joe.C <srv_yingjoe.chen@mediatek.com>
Subject: Re: [Patch] irqdomain: Introduce new interfaces to support
 hierarchy irqdomains
Date: Tue, 23 Sep 2014 17:43:22 +0800
Message-ID: <1411465402.8922.126.camel@mtksdaap41>
References: <alpine.DEB.2.10.1409160859080.4247@nanos>
 <1411373856-9669-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411373856-9669-1-git-send-email-jiang.liu@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joerg Roedel <joro@8bytes.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2014-09-22 at 16:17 +0800, Jiang Liu wrote:
> @@ -388,7 +389,6 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
>  unsigned int irq_create_mapping(struct irq_domain *domain,
>  				irq_hw_number_t hwirq)
>  {
> -	unsigned int hint;
>  	int virq;
>  
>  	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
> @@ -410,12 +410,8 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>  	}
>  
>  	/* Allocate a virtual interrupt number */
> -	hint = hwirq % nr_irqs;
> -	if (hint == 0)
> -		hint++;
> -	virq = irq_alloc_desc_from(hint, of_node_to_nid(domain->of_node));
> -	if (virq <= 0)
> -		virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +	virq = irq_domain_alloc_descs(-1, 1, hwirq,
> +				      of_node_to_nid(domain->of_node));

If I read this correct, the resulting virq is different after your
change.

>  	if (virq <= 0) {
>  		pr_debug("-> virq allocation failed\n");
>  		return 0;
> @@ -490,7 +486,10 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>  	}
>  
>  	/* Create mapping */
> -	virq = irq_create_mapping(domain, hwirq);
> +	if (irq_domain_is_hierarchy(domain))
> +		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
> +	else
> +		virq = irq_create_mapping(domain, hwirq);
>  	if (!virq)
>  		return virq;

hwirq returned from xlat above is lost. Without hwirq or virq, how do we
know which irq are we working for?
Also, if the irq_desc/irq_data was already created, this will create
another one. Should we do irq_find_mapping just like irq_create_mapping?

> +int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
> +			    unsigned int nr_irqs, int node, void *arg,
> +			    bool realloc)
> +{
> +	int i, ret, virq;
> +
> +	if (domain == NULL) {
> +		domain = irq_default_domain;
> +		if (WARN(!domain, "domain is NULL; cannot allocate IRQ\n"))
> +			return -EINVAL;
> +	}
> +
> +	if (!domain->ops->alloc) {
> +		pr_debug("domain->ops->alloc() is NULL\n");
> +		return -ENOSYS;
> +	}
> +
> +	if (realloc && irq_base >= 0) {
> +		virq =  irq_base;
                         ^
extra space here.

Joe.C
