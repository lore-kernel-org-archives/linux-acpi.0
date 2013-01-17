From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: fix obsolete comments
Date: Thu, 17 Jan 2013 14:35:58 +0100
Message-ID: <2165732.ArCGEtvVHK@vostro.rjw.lan>
References: <1358390867.20319.0.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43339 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab3AQNaE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2013 08:30:04 -0500
In-Reply-To: <1358390867.20319.0.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, January 17, 2013 10:47:47 AM Zhang Rui wrote:
> From 60d772572f78d78fbf4430a77599532826b55a12 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 16 Jan 2013 20:01:01 +0800
> Subject: [PATCH] ACPI: fix obsolete comments

I'm going to apply this (with a slightly different subject and changelog).

Thanks,
Rafael


> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/custom_method.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index 5d42c24..6adfc70 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -1,5 +1,5 @@
>  /*
> - * debugfs.c - ACPI debugfs interface to userspace.
> + * custom_method.c - debugfs interface for customizing ACPI control method
>   */
>  
>  #include <linux/init.h>
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
