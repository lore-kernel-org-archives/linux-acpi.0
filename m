From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/2] ACPI : remove CONFIG_ACPI_PROCFS_POWER and
 AC/Battery procfs I/F
Date: Wed, 23 Mar 2011 13:34:52 +0800
Message-ID: <CF2F38D4AE21BB4CB845318E4C5ECB67548DCF4B@shsmsx501.ccr.corp.intel.com>
References: <1300844063.31379.4.camel@rui>
 <alpine.LFD.2.02.1103222322011.10549@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44810 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab1CWFfk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 01:35:40 -0400
In-Reply-To: <alpine.LFD.2.02.1103222322011.10549@x980>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Len Brown
> Sent: Wednesday, March 23, 2011 11:24 AM
> To: Zhang, Rui
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 1/2] ACPI : remove CONFIG_ACPI_PROCFS_POWER and
> AC/Battery procfs I/F
> Importance: High
> 
> > Documentation/feature-removal-schedule.txt |   11
> > drivers/acpi/Kconfig                       |   17 -
> > drivers/acpi/Makefile                      |    1
> > drivers/acpi/ac.c                          |  128
> > drivers/acpi/battery.c                     |  326
> > drivers/acpi/cm_sbs.c                      |  105 ---------
> > drivers/acpi/sbs.c                         |  331
> >
> > 7 files changed, 5 insertions(+), 914 deletions(-)
> 
> Do the popular battery applets know how to use sysfs?
> We can't delete this code until they do.
> 
[Rui] I'm not quite sure.
But CONFIG_ACPI_PROCFS_POWER has been set to n by default for some days.
And we announced to remove this interface in 2.6.39.

Thanks,
Rui

> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
