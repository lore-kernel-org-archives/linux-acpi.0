From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPI / PMIC: Add code reviewers to MAINTAINERS
Date: Thu, 07 Sep 2017 04:51:46 -0700
Message-ID: <1504785106.7546.22.camel@perches.com>
References: <3133187.xxVeAdigRk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:57558 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754219AbdIGLvu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 07:51:50 -0400
In-Reply-To: <3133187.xxVeAdigRk@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Thu, 2017-09-07 at 13:18 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Andy and Mika review code changes under drivers/acpi/pmic/ on
> a regular basis and I rely on their help with that, so add them
> as code reviwewers for that part of the kernel.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> +L:	linux-acpi@vger.kernel.org
> +R:	Andy Shevchenko <andy@infradead.org>
> +R:	Mika Westerberg <mika.westerberg@linux.intel.com>

Please put reviewers before lists

