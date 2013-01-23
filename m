From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC PATCH] ACPI: Add boot option to disable auto return object
 repair
Date: Wed, 23 Jan 2013 12:59:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E357E552EE@ORSMSX101.amr.corp.intel.com>
References: <59ec303219ed43c247fd5afc75de35553b9a52d5.1358954645.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6559 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716Ab3AWM7G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2013 07:59:06 -0500
In-Reply-To: <59ec303219ed43c247fd5afc75de35553b9a52d5.1358954645.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Rafael J Wysocki <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

We continually make progress in this area, and we already can fix a huge number of potential issues. I would rather not allow an option to disable this unless it is absolutely necessary; I don't want this ACPICA feature to become disabled permanently in Linux.

It is rather surprising how many predefined names in any given BIOS return incorrect values. What started out as ad-hoc code littered throughout ACPICA and the ACPI-related device drivers is now encapsulated in a repair module that handles hundreds of possible cases. The repair module is table-driven and causes only a very small overhead.

The final goal of the detect/repair mechanism is that if a driver receives an AE_OK back from the evaluation of a predefined name (anything that starts with an underscore), it is guaranteed that the return value is something that is expected -- thus saving all of the ACPI-related device drivers from performing typechecks on the returned object.

Note: The ACPICA validation/repair code was originally released in 2009.

Bob


> -----Original Message-----
> From: Zheng, Lv
> Sent: Tuesday, January 22, 2013 11:29 PM
> To: Brown, Len; Wysocki, Rafael J; Rafael J Wysocki; Moore, Robert
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; Zheng, Lv
> Subject: [RFC PATCH] ACPI: Add boot option to disable auto return object
> repair
> 
> There is automatic return object repair mechanism implemented in ACPICA
> which can not handle all of the issues exposed by BIOS currently. This
> patch allow a kernel boots up without such workarounds enabled. A better
> choice should refine the repair mechanism to allow more robust evaluation
> result.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/bus.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index
> 01708a1..e33577f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -805,6 +805,18 @@ static int __init acpi_bus_init(void)  struct kobject
> *acpi_kobj;  EXPORT_SYMBOL_GPL(acpi_kobj);
> 
> +static int __init acpi_disable_repair(char *s) {
> +        printk(KERN_NOTICE PREFIX
> +	       "ACPI: Predefined names repair disabled\n");
> +
> +        acpi_gbl_disable_auto_repair = TRUE;
> +
> +        return 1;
> +}
> +
> +__setup("acpi_no_repair", acpi_disable_repair);
> +
>  static int __init acpi_init(void)
>  {
>  	int result;
> --
> 1.7.10.4

