From: Joe.C <yingjoe.chen@mediatek.com>
Subject: Re: [RFT v2 01/24] irqdomain: Introduce new interfaces to support
 hierarchy irqdomains
Date: Wed, 1 Oct 2014 22:23:38 +0800
Message-ID: <1412173418.24931.3514.camel@mtksdaap41>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
 <1411740145-30626-2-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411740145-30626-2-git-send-email-jiang.liu@linux.intel.com>
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

On Fri, 2014-09-26 at 22:02 +0800, Jiang Liu wrote:
> @@ -480,6 +478,11 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>  		return 0;
>  	}
>  
> +	if (irq_domain_is_hierarchy(domain)) {
> +		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
> +		return virq <= 0 ? 0 : virq;
> +	}
> +
>  	/* If domain has no translation, then we assume interrupt line */
>  	if (domain->ops->xlate == NULL)
>  		hwirq = irq_data->args[0];

Hi Jiang,

You'll need this change, otherwise <0 part of the check will always be
false.

@@ -467,7 +467,7 @@ unsigned int irq_create_of_mapping(struct
of_phandle_args *irq_data)
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	unsigned int virq;
+	int virq;
 
 	domain = irq_data->np ? irq_find_host(irq_data->np) :
irq_default_domain;
 	if (!domain) {

Joe.C
