From: Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm patch] ACPI_SONY shouldn't default m
Date: Wed, 6 Sep 2006 20:30:03 -0700
Message-ID: <20060906203003.95ad130a.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060906230700.GE12157@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:56006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422688AbWIGDdt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 23:33:49 -0400
In-Reply-To: <20060906230700.GE12157@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 7 Sep 2006 01:07:00 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> Drivers should default to n.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig.old	2006-09-07 00:49:37.000000000 +0200
> +++ linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig	2006-09-07 00:50:01.000000000 +0200
> @@ -251,7 +251,6 @@
>  config ACPI_SONY
>  	tristate "Sony Laptop Extras"
>  	depends on X86 && ACPI
> -	default m

Not this one - I need it on my Vaio and I get sick of the option vanishing.
Make it depend on CONFIG_AKPM?
