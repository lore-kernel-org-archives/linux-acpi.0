From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] ACPI / PMIC: Update to SPDX license identifier
Date: Wed, 14 Mar 2018 12:39:31 +0100
Message-ID: <29263549.3mTuWCYWkj@aspire.rjw.lan>
References: <1519170849-28802-1-git-send-email-rajmohan.mani@intel.com> <1519170849-28802-4-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519170849-28802-4-git-send-email-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 21, 2018 12:54:09 AM CET Rajmohan Mani wrote:
> Remove the GPL v2 license boilerplate and update with
> the SPDX license identifier.
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---
>  drivers/acpi/pmic/tps68470_pmic.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
> index 7f3c567..a083de5 100644
> --- a/drivers/acpi/pmic/tps68470_pmic.c
> +++ b/drivers/acpi/pmic/tps68470_pmic.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * TI TPS68470 PMIC operation region driver
>   *
> @@ -5,15 +6,6 @@
>   *
>   * Author: Rajmohan Mani <rajmohan.mani@intel.com>
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License version
> - * 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Based on drivers/acpi/pmic/intel_pmic* drivers
>   */
>  
> 

Applied, thanks!
