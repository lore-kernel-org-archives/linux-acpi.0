From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / PMIC: Add code reviewers to MAINTAINERS
Date: Mon, 18 Sep 2017 11:07:30 +0300
Message-ID: <1505722050.25945.276.camel@linux.intel.com>
References: <3133187.xxVeAdigRk@aspire.rjw.lan>
         <1526791.JLKQz4fugV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5772 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbdIRIHe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Sep 2017 04:07:34 -0400
In-Reply-To: <1526791.JLKQz4fugV@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Joe Perches <joe@perches.com>

On Fri, 2017-09-08 at 01:20 +0200, Rafael J. Wysocki wrote:
> rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Andy and Mika review code changes under drivers/acpi/pmic/ on
> a regular basis and I rely on their help with that, so add them
> as code reviwewers for that part of the kernel.
> 

Fine by me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> 
> -> v2: Reorder fields as per the Joe's comment.
>        Add tags from Mika and Lee.
> 
> ---
>  MAINTAINERS |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-pm/MAINTAINERS
> ===================================================================
> --- linux-pm.orig/MAINTAINERS
> +++ linux-pm/MAINTAINERS
> @@ -352,6 +352,18 @@ L:	linux-acpi@vger.kernel.org
>  S:	Maintained
>  F:	drivers/acpi/arm64
>  
> +ACPI PMIC DRIVERS
> +M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> +M:	Len Brown <lenb@kernel.org>
> +R:	Andy Shevchenko <andy@infradead.org>
> +R:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +L:	linux-acpi@vger.kernel.org
> +Q:	https://patchwork.kernel.org/project/linux-acpi/list/
> +T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +B:	https://bugzilla.kernel.org
> +S:	Supported
> +F:	drivers/acpi/pmic/
> +
>  ACPI THERMAL DRIVER
>  M:	Zhang Rui <rui.zhang@intel.com>
>  L:	linux-acpi@vger.kernel.org
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
