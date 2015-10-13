From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 00/17] Divorcing irqdomain and device_node
Date: Tue, 13 Oct 2015 21:49:47 +0800
Message-ID: <561D0BFB.4040000@linaro.org>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36734 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbbJMNt6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2015 09:49:58 -0400
Received: by pacex6 with SMTP id ex6so22140954pac.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2015 06:49:58 -0700 (PDT)
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

On 10/13/2015 07:51 PM, Marc Zyngier wrote:
> [This patch series used to be called "Making the generic ACPI GSI
> layer irqdomain aware", but as I've radically changed my approach to
> this problem, I've decided to reset the counters...]
>
> The irqdomain code is not entierely ACPI friendly, as it has some
> built-in knowledge of the device-tree. Nothing too harmful, but enough
> to scare the ARM ACPI developpers which end up with their own version
> of the square wheel. And some of the ramifications actually run deeper
> than initially expected.
>
> This series adapts the irqdomain code to use 'struct fwnode_handle'
> instead of 'struct device_node' as the identifier for a domain
> (compatibility interfaces are of course added). It also introduces a
> generic IRQ specifier that firmware interfaces (DT or ACPI) can
> directly use to configure interrupts, and allow the ACPI GSI code to
> be plugged into this.
>
> As examples, we convert the ARM GIC ACPI support to use irqdomains as
> originally intended, and rework the MSI code to also move away from
> using device nodes when using irqdomains.
>
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure.
>
> This has been test-booted on Juno, is based on 4.3-rc5 + tip/irq/core
> (in order to avoid potential conflicts), and available at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v2
>
> * From v1:
>    - Dropped irq_domain_get_of_node() from the first patch (merged into
>    4.3-rc5)
>    - Fixed a few missing accessors in the first patch
>    - Added EXPORT_SYMBOL_GPL for irq_find_matching_fwnode
>    - Added some documentation update
>    - Added Acks from Rafael
>    - Rebased on top of 4.3-rc5 + tip/irq/core
>
> Marc Zyngier (17):
>    irqdomain: Use irq_domain_get_of_node() instead of direct field access
>    irqdomain: Convert irqdomain->of_node to fwnode
>    irqdomain: Allow irq domain lookup by fwnode
>    irqdomain: Introduce a firmware-specific IRQ specifier structure
>    irqchip: Convert all alloc/xlate users from of_node to fwnode
>    irqdomain: Introduce irq_create_fwspec_mapping
>    irqdomain: Introduce irq_domain_create_{linear,tree}
>    irqdomain: Add a fwnode_handle allocator
>    acpi/gsi: Always perform an irq domain lookup
>    acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
>    irqchip/gic: Get rid of gic_init_bases()
>    irqchip/gic: Switch ACPI support to stacked domains
>    irqchip/gic: Kill the xlate method
>    acpi/gsi: Cleanup acpi_register_gsi
>    irqdomain: Introduce irq_domain_create_hierarchy
>    irqdomain/msi: Use fwnode instead of of_node
>    irqdomain: Documentation updates

For this patch series,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

For patch 1 to patch14,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks a lot!
Hanjun
