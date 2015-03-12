From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] ACPI / EC: Cleanup logging/debugging splitter
 support.
Date: Thu, 12 Mar 2015 15:33:09 -0700
Message-ID: <1426199589.2742.16.camel@perches.com>
References: <alpine.LNX.2.11.1502151932250.630@localhost>
	 <cover.1425019470.git.lv.zheng@intel.com>
	 <79307c846d7ca93d0423829b84cb0354e276fb73.1425019470.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:33044 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751091AbbCLWdO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2015 18:33:14 -0400
In-Reply-To: <79307c846d7ca93d0423829b84cb0354e276fb73.1425019470.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2015-02-27 at 14:48 +0800, Lv Zheng wrote:
> This patch refines logging/debugging splitter support so that when DEBUG is
> disabled, splitters won't be visible in the kernel logs while they are
> still available for developers when DEBUG is enabled.
> 
> This patch also refines the splitters to mark the following handling
> process boundaries:
>   +++++: boundary of driver starting/stopping
>          boundary of IRQ storming
>   =====: boundary of transaction advancement
>   *****: boundary of EC command
>          boundary of EC query
>   #####: boundary of EC _Qxx evaluation

trivia:

> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
[]
>  /* --------------------------------------------------------------------------
> + *                           Logging/Debugging
> + * -------------------------------------------------------------------------- */
> +
> +/*
> + * Splitters used by the developers to track the boundary of the EC
> + * handling processes.
> + */

It'd be nice to comment/document these 3 letter descriptions
a bit better here in the source code.

> +#ifdef DEBUG
> +#define EC_DBG_SEP	" "
> +#define EC_DBG_DRV	"+++++"
> +#define EC_DBG_STM	"====="
> +#define EC_DBG_REQ	"*****"
> +#define EC_DBG_EVT	"#####"

Maybe:

#define EC_DBG_SEP	" "
#define EC_DBG_DRV	"+++++"		/* drivers start/stop */
#define EC_DBG_STM	"====="		/* irq storm */
#define EC_DBG_REQ	"*****"		/* ec command boundary */
#define EC_DBG_EVT	"#####"		/* EC _Qxx evaluation */
> 

