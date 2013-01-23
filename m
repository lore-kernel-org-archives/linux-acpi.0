From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Devel] [RFC PATCH] ACPI: Add boot option to disable auto return object repair
Date: Wed, 23 Jan 2013 13:18:52 +0100
Message-ID: <201301231318.52311.trenn@suse.de>
References: <59ec303219ed43c247fd5afc75de35553b9a52d5.1358954645.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41725 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723Ab3AWMTA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2013 07:19:00 -0500
In-Reply-To: <59ec303219ed43c247fd5afc75de35553b9a52d5.1358954645.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Rafael J Wysocki <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, January 23, 2013 08:29:02 AM Lv Zheng wrote:
> There is automatic return object repair mechanism implemented in
> ACPICA which can not handle all of the issues exposed by BIOS
> currently. This patch allow a kernel boots up without such
> workarounds enabled. A better choice should refine the repair
> mechanism to allow more robust evaluation result.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/bus.c |   12 ++++++++++++

drivers/acpi/osl.c would IMO make more sense to add this, there
is no __setup function in bus.c yet, but in osl.c there is:
__setup("acpi_serialize", acpi_serialize_setup);
doing more or less the same.

>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 01708a1..e33577f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -805,6 +805,18 @@ static int __init acpi_bus_init(void)
>  struct kobject *acpi_kobj;
>  EXPORT_SYMBOL_GPL(acpi_kobj);
>  
> +static int __init acpi_disable_repair(char *s)
> +{
> +        printk(KERN_NOTICE PREFIX
pr_notice()

No need to change other printk(KERN_NOTICE..., but new patches
should make use of pr_notice.

Are there known error messages that indicate when it makes sense
to try this out?
How would I know I should try this boot param?

If there are hints when to use this, it makes sense to mention them at 
least in the changelog (or a bug reference or similar).

kernel parameters are typically described in
Documentation/kernel-parameters.txt
Not sure whether it's worth for this one (if it's intended for low level 
ACPI debugging only and people making use of it know the drivers/acpi/*
code and therefore know about this option it may not).

   Thomas
