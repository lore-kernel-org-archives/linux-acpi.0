From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/RFT][PATCH -mm 3/4] PM: Rename struct pm_ops and related things
Date: Sun, 24 Jun 2007 21:12:49 -0700
Message-ID: <200706242112.50814.david-b@pacbell.net>
References: <200706242239.05678.rjw@sisk.pl> <200706242242.47573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:31156 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751607AbXFYEMt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2007 00:12:49 -0400
In-Reply-To: <200706242242.47573.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Sunday 24 June 2007, Rafael J. Wysocki wrote:

>  arch/arm/common/sharpsl_pm.c             |    8 +++----
>  arch/arm/mach-at91/pm.c                  |    4 +--
>  arch/arm/mach-omap1/pm.c                 |    6 ++---
>  arch/arm/mach-omap2/pm.c                 |    6 ++---
>  arch/arm/mach-pnx4008/pm.c               |    4 +--
>  arch/arm/mach-pxa/pm.c                   |    6 ++---
>  arch/arm/mach-sa1100/pm.c                |    6 ++---
>  arch/arm/plat-s3c24xx/pm.c               |    6 ++---
>  arch/blackfin/mach-common/pm.c           |    4 +--
>  arch/powerpc/platforms/52xx/mpc52xx_pm.c |    4 +--
>  arch/sh/boards/hp6xx/pm.c                |    6 ++---
>  drivers/acpi/sleep/main.c                |    6 ++---

It's interesting that so few systems support suspend states,
and thus need to change for this patch ... 


- Dave
