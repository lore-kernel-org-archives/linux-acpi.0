From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch v2] acpi_pad: "processor_aggregator" name too long
Date: Thu, 25 Mar 2010 19:38:54 +0100
Message-ID: <20100325183853.GB22902@elf.ucw.cz>
References: <20100319114806.GN5331@bicker>
 <20100325142738.GD1602@ucw.cz>
 <20100325144122.GF5069@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:43663 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753674Ab0CYSjD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Mar 2010 14:39:03 -0400
Content-Disposition: inline
In-Reply-To: <20100325144122.GF5069@bicker>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chen Gong <gong.chen@linux.intel.com>, P

On Thu 2010-03-25 17:41:22, Dan Carpenter wrote:
> cpi_device_class can only be 19 characters and a NULL terminator.
> 
> With the current name we get a buffer overflow in acpi_pad_add()
> 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

ACK.

> ---
> V2: Thanks to Pavel Machek for coming up with the right name for this.
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7e52295..790aaa1 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -30,7 +30,7 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> -#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"processor_aggregator"
> +#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"cpu_aggregator"
>  #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
>  #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
>  static DEFINE_MUTEX(isolated_cpus_lock);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
