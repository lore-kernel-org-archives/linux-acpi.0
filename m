From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 07/10] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
Date: Thu, 17 Dec 2015 14:24:03 +0100
Message-ID: <5672B773.7060409@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-8-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450353133-15992-8-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com
List-Id: linux-acpi@vger.kernel.org

On 17.12.2015 12:52, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS.
>
> Initial support allows to:
> - register ITS MSI chip along with ITS translation ID and domain token
> - find registered domain token based on ITS translation ID
> - find registered domain token corresponding to given PCI device
> - find PCI device DeviceID based on its RequesterID
>
> Additional features like:
> - devices to SMMU binding
> - finding platform device DeviceID based on its RequesterID
> will be added in next series.
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>
> Conflicts:
> 	drivers/acpi/Kconfig

Sorry for ^^^^ git rebase leftover.

> ---
>   drivers/acpi/Kconfig    |   3 +
>   drivers/acpi/Makefile   |   1 +
>   drivers/acpi/iort.c     | 326 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/irqchip/Kconfig |   1 +
>   include/linux/iort.h    |  38 ++++++
>   5 files changed, 369 insertions(+)
>   create mode 100644 drivers/acpi/iort.c
>   create mode 100644 include/linux/iort.h
>

[...]

> diff --git a/include/linux/iort.h b/include/linux/iort.h
> new file mode 100644
> index 0000000..783e8d6
> --- /dev/null
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
> +

As per kbuild test report, this has to be:
#ifdef CONFIG_IORT_TABLE

Will be fixed in the next version.

Regards,
Tomasz
