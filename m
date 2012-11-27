From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 04/15] ACPICA: Fixes code maintenance divergences.
Date: Tue, 27 Nov 2012 03:46:30 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828D4CEA0@FMSMSX108.amr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <b09f6d938fbc8f6b3b6904d770c17e8f797913b4.1353491653.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16724 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933179Ab2K0Dqc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 22:46:32 -0500
In-Reply-To: <b09f6d938fbc8f6b3b6904d770c17e8f797913b4.1353491653.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> This patch will not affect the generated vmlinux binary.

If this is the goal, then please VERIFY that the goal was met
by building both ways and comparing the kernel.

due to the hunk below, we know that this patch DOES change
the kernel, and not in a correct way:

> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c index 285e24b..b4469a6
> 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -384,10 +384,6 @@ void acpi_tb_check_dsdt_header(void)
>  		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
>  		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
> 
> -		ACPI_ERROR((AE_INFO,
> -			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
> -			    "If system does not work as expected, please boot with acpi=copy_dsdt"));
> -
>  		/* Disable further error messages */

Please retain this difference between Linux and ACPICA --
it is there for a reason.

thanks,
-Len



