From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V2 07/10] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
Date: Fri, 18 Dec 2015 19:18:17 +0800
Message-ID: <5673EB79.9000105@huawei.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-8-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450353133-15992-8-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com
Cc: graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2015/12/17 19:52, Tomasz Nowicki wrote:
> +++ b/include/linux/iort.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright (C) 2015, Linaro Ltd.
> + *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> + * Place - Suite 330, Boston, MA 02111-1307 USA.
> + */
> +
> +#ifndef __IORT_H__
> +#define __IORT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI

I think we need use CONFIG_IORT_TABLE here, or the code will be compiled
error on no-ARM64 platform, and it will lead to undefined function, just as
the kbuild test robot pointed out:

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `pci_msi_domain_get_msi_rid':

>> (.text+0x3175d): undefined reference to `iort_find_pci_id'


Thanks
Hanjun
> +
> +struct fwnode_handle;
> +
> +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
> +struct fwnode_handle *iort_find_its_domain_token(int trans_id);
> +struct fwnode_handle *iort_find_pci_domain_token(struct device *dev);
> +int iort_find_pci_id(struct pci_dev *pdev, u32 req_id, u32 *dev_id);
> +#else /* CONFIG_ACPI */
> +static inline int
> +iort_find_pci_id(struct pci_dev *pdev, u32 req_id, u32 *dev_id)
> +{ return -ENXIO; }
> +#endif /* CONFIG_ACPI */
> +
> +#endif /* __IORT_H__ */
