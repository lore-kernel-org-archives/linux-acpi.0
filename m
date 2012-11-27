From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 04/15] ACPICA: Fixes code maintenance divergences.
Date: Tue, 27 Nov 2012 05:33:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD37DB@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <b09f6d938fbc8f6b3b6904d770c17e8f797913b4.1353491653.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CEA0@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4059 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2K0FeD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Nov 2012 00:34:03 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D4CEA0@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > This patch will not affect the generated vmlinux binary.
> 
> If this is the goal, then please VERIFY that the goal was met by building both
> ways and comparing the kernel.

It's not the goal of this patch, it should be better stated as no function changes.

> due to the hunk below, we know that this patch DOES change the kernel, and
> not in a correct way:
> 
> > diff --git a/drivers/acpi/acpica/tbutils.c
> > b/drivers/acpi/acpica/tbutils.c index 285e24b..b4469a6
> > 100644
> > --- a/drivers/acpi/acpica/tbutils.c
> > +++ b/drivers/acpi/acpica/tbutils.c
> > @@ -384,10 +384,6 @@ void acpi_tb_check_dsdt_header(void)
> >  		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
> >  		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
> >
> > -		ACPI_ERROR((AE_INFO,
> > -			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
> > -			    "If system does not work as expected, please boot with
> acpi=copy_dsdt"));
> > -
> >  		/* Disable further error messages */
> 
> Please retain this difference between Linux and ACPICA -- it is there for a
> reason.

Agreed.
I shouldn't make this vanished.
I will add this back to Linux during the next release if this is needed.

Best regards/Lv Zheng


> thanks,
> -Len
> 
> 

