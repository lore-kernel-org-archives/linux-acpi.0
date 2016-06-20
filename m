From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V6 1/7] ACPI: I/O Remapping Table (IORT) initial support
Date: Mon, 20 Jun 2016 11:34:29 +0200
Message-ID: <5767B8A5.7020706@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-2-git-send-email-tn@semihalf.com>
 <20160615110427.GD30560@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160615110427.GD30560@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: ddaney.cavm@gmail.com, jason@lakedaemon.net, al.stone@linaro.org, linux-acpi@vger.kernel.org, marc.zyngier@arm.com, Catalin.Marinas@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org, shijie.huang@arm.com, robert.richter@caviumnetworks.com, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, bhelgaas@google.com, graeme.gregory@linaro.org, tglx@linutronix.de, mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 06/15/2016 01:04 PM, Lorenzo Pieralisi wrote:
> On Mon, Jun 13, 2016 at 04:41:07PM +0200, Tomasz Nowicki wrote:
>> IORT shows representation of IO topology for ARM based systems.
>> It describes how various components are connected together on
>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>
>> Initial support allows to:
>> - register ITS MSI chip along with ITS translation ID and domain token
>> - deregister ITS MSI chip based on ITS translation ID
>> - find registered domain token based on ITS translation ID
>> - map MSI RID for a device
>> - find domain token for a device
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/acpi/Kconfig  |   3 +
>>   drivers/acpi/Makefile |   1 +
>>   drivers/acpi/iort.c   | 386 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iort.h  |  38 +++++
>>   4 files changed, 428 insertions(+)
>>   create mode 100644 drivers/acpi/iort.c
>>   create mode 100644 include/linux/iort.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index f98c328..111dd50 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
>>   config ACPI_CCA_REQUIRED
>>   	bool
>>   
>> +config IORT_TABLE
>> +	bool
>> +
>>   config ACPI_DEBUGGER
>>   	bool "AML debugger interface"
>>   	select ACPI_DEBUG
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 632e81f..0390f27 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>>   obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>> +obj-$(CONFIG_IORT_TABLE) 	+= iort.o
>>   
>>   # processor has its own "processor." module_param namespace
>>   processor-y			:= processor_driver.o
>> diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
>> new file mode 100644
>> index 0000000..5bccbc8
>> --- /dev/null
>> +++ b/drivers/acpi/iort.c
>> @@ -0,0 +1,386 @@
>> +/*
>> + * Copyright (C) 2016, Semihalf
>> + *	Author: Tomasz Nowicki <tn@semihalf.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * This file implements early detection/parsing of I/O mapping
>> + * reported to OS through firmware via I/O Remapping Table (IORT)
>> + * IORT document number: ARM DEN 0049A
>> + */
>> +
>> +#define pr_fmt(fmt)	"ACPI: IORT: " fmt
>> +
>> +#include <linux/export.h>
>> +#include <linux/iort.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +struct iort_its_msi_chip {
>> +	struct list_head	list;
>> +	struct fwnode_handle	*fw_node;
>> +	u32			translation_id;
>> +};
>> +
>> +typedef acpi_status (*iort_find_node_callback)
>> +	(struct acpi_iort_node *node, void *context);
>> +
>> +/* Root pointer to the mapped IORT table */
>> +static struct acpi_table_header *iort_table;
> A question to be sorted out:
>
> We assume we can rely on the iort_table pointer, obtained through
> acpi_get_table(), since we assume acpi_glb_permanent_mmap is set (?),
> correct ?

Correct.

>
> x86 DMAR code seems to rely on that (without even checking
> acpi_gbl_permanent_mmap) and this has consequences on when
> we can really start parsing IORT entries through this patch
> (because if acpi_gbl_permanent_mmap is not set while using
> IORT nodes we would dereference unmapped pointers).
>
> @Rafael: can you confirm that's the right approach ?

Thanks,
Tomasz
