From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 00/17] Divorcing irqdomain and device_node
Date: Tue, 13 Oct 2015 16:38:03 +0100
Message-ID: <561D255B.4010007@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com> <561D0BFB.4040000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561D0BFB.4040000@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

On 13/10/15 14:49, Hanjun Guo wrote:
> On 10/13/2015 07:51 PM, Marc Zyngier wrote:

[...]

>> Marc Zyngier (17):
>>    irqdomain: Use irq_domain_get_of_node() instead of direct field access
>>    irqdomain: Convert irqdomain->of_node to fwnode
>>    irqdomain: Allow irq domain lookup by fwnode
>>    irqdomain: Introduce a firmware-specific IRQ specifier structure
>>    irqchip: Convert all alloc/xlate users from of_node to fwnode
>>    irqdomain: Introduce irq_create_fwspec_mapping
>>    irqdomain: Introduce irq_domain_create_{linear,tree}
>>    irqdomain: Add a fwnode_handle allocator
>>    acpi/gsi: Always perform an irq domain lookup
>>    acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
>>    irqchip/gic: Get rid of gic_init_bases()
>>    irqchip/gic: Switch ACPI support to stacked domains
>>    irqchip/gic: Kill the xlate method
>>    acpi/gsi: Cleanup acpi_register_gsi
>>    irqdomain: Introduce irq_domain_create_hierarchy
>>    irqdomain/msi: Use fwnode instead of of_node
>>    irqdomain: Documentation updates
> 
> For this patch series,
> 
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> For patch 1 to patch14,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks for reviewing/testing.

	M.
-- 
Jazz is not dead. It just smells funny...
