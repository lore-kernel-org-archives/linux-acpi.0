From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 2/7] irqchip/alpine-msi: Update driver license to use SPDX
Date: Sun, 31 Mar 2019 18:16:46 +0530
Message-ID: <c99273a0-f85a-9fd1-84d4-d5062385a94f@codeaurora.org>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
 <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hanna Hawa <hhhawa@amazon.com>, tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-arm-kernel@lists.infradead.org, barakw@amazon.com, vaerov@amazon.com, linux-kernel@vger.kernel.org, hanochu@amazon.com, linux-acpi@vger.kernel.org, zeev@amazon.com, dwmw@amazon.co.uk, jonnyc@amazon.com, ronenk@amazon.com, talel@amazon.com, alisaidi@amazon.com
List-Id: linux-acpi@vger.kernel.org


On 3/31/2019 6:04 PM, Hanna Hawa wrote:
> Update driver license to be in-line with Linux conventions.
>
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>

> ---
>   drivers/irqchip/irq-alpine-msi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
> index ae2fca7..ec6a606 100644
> --- a/drivers/irqchip/irq-alpine-msi.c
> +++ b/drivers/irqchip/irq-alpine-msi.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0


Please fix this as per.
https://lkml.org/lkml/2019/2/13/570


cheers,
Mukesh

>   /*
>    * Annapurna Labs MSIX support services
>    *
>    * Copyright (C) 2016, Amazon.com, Inc. or its affiliates. All Rights Reserved.
>    *
>    * Antoine Tenart <antoine.tenart@free-electrons.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>    */
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
