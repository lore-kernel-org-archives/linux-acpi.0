From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency
 on struct device_node
Date: Tue, 15 Sep 2015 14:04:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509151401340.3971@nanos>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com> <1442249047-21182-3-git-send-email-marc.zyngier@arm.com> <55F7F9E2.3070105@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43083 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbIOMFa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2015 08:05:30 -0400
In-Reply-To: <55F7F9E2.3070105@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

On Tue, 15 Sep 2015, Tomasz Nowicki wrote:

Can you folks please do proper quoting on reply? It's annoying to
scroll down 250+ lines to find TWO lines of reply and then have
another 250+ lines for nothing.

Here is the real gist of your reply:

> On 14.09.2015 18:44, Marc Zyngier wrote:
> > -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
> > +struct irq_domain *__irq_domain_add(void *domain_token, int size,
> >   				    irq_hw_number_t hwirq_max, int direct_max,
> >   				    const struct irq_domain_ops *ops,
> >   				    void *host_data)
> >   {
> > +	struct device_node *of_node;
> >   	struct irq_domain *domain;
> > 
> > +	of_node = irq_domain_token_to_of_node(domain_token);
> >   	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
> >   			      GFP_KERNEL, of_node_to_nid(of_node));
> 
> While we are here, do you think it makes sense to abstract of_node_to_nid as
> well? Then we would really remove device_node dependency for irqdomain.

15 lines of useful content versus 500+ lines of useless noise.

Thanks,

	tglx
