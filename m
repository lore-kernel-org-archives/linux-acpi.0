From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] acpi: add utility to test for device dma coherency
Date: Tue, 09 Sep 2014 17:41:46 -0400
Message-ID: <1410298906.27715.62.camel@deneb.redhat.com>
References: <1410296278-1244-1-git-send-email-msalter@redhat.com>
	 <2333063.oAgzS6NIuV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbaIIVlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 17:41:52 -0400
In-Reply-To: <2333063.oAgzS6NIuV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2014-09-09 at 23:49 +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 09, 2014 04:57:58 PM Mark Salter wrote:
> > ACPI 5.1 adds a _CCA object to indicate memory coherency
> > of a bus master device. It is an integer with zero meaning
> > non-coherent and one meaning coherent. This attribute may
> > be inherited from a parent device. It may also be missing
> > entirely, in which case, an architecture-specific default
> > is assumed.
> > 
> > This patch adds a utility function to parse a device handle
> > (and its parents) for a _CCA object and return the coherency
> > attribute if found.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >  drivers/acpi/utils.c    | 26 ++++++++++++++++++++++++++
> >  include/acpi/acpi_bus.h |  2 ++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 07c8c5a..aec9656 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -698,3 +698,29 @@ bool acpi_check_dsm(acpi_handle handle, const u8 *uuid, int rev, u64 funcs)
> >  	return false;
> >  }
> >  EXPORT_SYMBOL(acpi_check_dsm);
> > +
> > +/**
> > + * acpi_check_coherency - check for memory coherency of a device
> > + * @handle: ACPI device handle
> > + * @val:    Pointer to returned value
> > + *
> > + * Search a device and its parents for a _CCA method and return
> > + * its value.
> > + */
> > +acpi_status acpi_check_coherency(acpi_handle handle, int *val)
> > +{
> > +	unsigned long long data;
> > +	acpi_status status;
> > +
> > +	do {
> > +		status = acpi_evaluate_integer(handle, "_CCA", NULL, &data);
> > +		if (!ACPI_FAILURE(status)) {
> 
> We have an ACPI_SUCCESS() macro for that.

ah, okay

> 
> > +			*val = data;
> > +			break;
> > +		}
> > +		status = acpi_get_parent(handle, &handle);
> > +	} while (!ACPI_FAILURE(status));
> > +
> 
> And here.
> 
> Anyway, how do you think this routine will be used?  Do you have any
> particular use cases in mind?
> 

An arm64 kernel defaults to non-coherent dma ops. There is a platform
and amba bus notifier in arm64/mm/dma-mapping.c which looks for a
device-tree dma-coherent property. If found, the device is switched
to using coherent dma ops. I'm thinking of doing something similar
for ACPI in that same bus notifier:

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4164c5a..f26dd78 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 #include <linux/amba/bus.h>
+#include <linux/acpi.h>
 
 #include <asm/cacheflush.h>
 
@@ -319,6 +320,21 @@ static int dma_bus_notifier(struct notifier_block *nb,
 	if (of_property_read_bool(dev->of_node, "dma-coherent"))
 		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
 
+#ifdef CONFIG_ACPI
+	if (ACPI_HANDLE(dev)) {
+		acpi_status status;
+		int coherent;
+
+		/*
+		 * Kernel defaults to noncoherent ops but ACPI 5.1 spec says arm64
+		 * defaults to coherent. Set coherent ops if _CCA not found or _CCA
+		 * found and non-zero.
+		 */
+		status =  acpi_check_coherency(ACPI_HANDLE(dev), &coherent);
+		if (ACPI_FAILURE(status) || coherent)
+			set_dma_ops(dev, &coherent_swiotlb_dma_ops);
+	}
+#endif
 	return NOTIFY_OK;
 }


