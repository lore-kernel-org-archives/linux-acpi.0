From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel
Date: Mon, 09 Jan 2017 23:41:15 +0100
Message-ID: <1607437.S0DYC9F2YO@aspire.rjw.lan>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic> <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com> <20170109105226.GR17255@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51503 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934014AbdAIWpc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 17:45:32 -0500
In-Reply-To: <20170109105226.GR17255@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Monday, January 09, 2017 11:52:26 AM Jörg Rödel wrote:
> Hi Rafael,
> 
> On Sun, Jan 08, 2017 at 03:20:20AM +0100, Rafael J. Wysocki wrote:
> > ---
> >  drivers/iommu/amd_iommu_init.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/iommu/amd_iommu_init.c
> > ===================================================================
> > --- linux-pm.orig/drivers/iommu/amd_iommu_init.c
> > +++ linux-pm/drivers/iommu/amd_iommu_init.c
> > @@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
> >  	 */
> >  	ret = check_ivrs_checksum(ivrs_base);
> >  	if (ret)
> > -		return ret;
> > +		goto out;
> >  
> >  	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
> >  	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
> 
> Yeah, good catch. Can you send me a patch for this and I am going to
> send the fix upstream asap.

Please find appended.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] IOMMU / AMD: Fix error code path in early_amd_iommu_init()

Prevent early_amd_iommu_init() from leaking memory mapped via
acpi_get_table() if check_ivrs_checksum() returns an error.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iommu/amd_iommu_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/iommu/amd_iommu_init.c
===================================================================
--- linux-pm.orig/drivers/iommu/amd_iommu_init.c
+++ linux-pm/drivers/iommu/amd_iommu_init.c
@@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
 	 */
 	ret = check_ivrs_checksum(ivrs_base);
 	if (ret)
-		return ret;
+		goto out;
 
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);

