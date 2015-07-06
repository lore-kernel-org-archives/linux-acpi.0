From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] ACPI / LPSS: set an error code
Date: Tue, 07 Jul 2015 00:56:21 +0200
Message-ID: <1480350.L34Aud6LIR@vostro.rjw.lan>
References: <20150703085653.GC11901@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57967 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751729AbbGFW3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2015 18:29:55 -0400
In-Reply-To: <20150703085653.GC11901@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On Friday, July 03, 2015 11:56:53 AM Dan Carpenter wrote:
> We should return -ENOMEM if ioremap() fails.
> 
> Fixes: 4483d59e29fe ('ACPI / LPSS: check the result of ioremap()')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 569ee09..10bf5c7 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -352,8 +352,10 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>  				pdata->mmio_size = resource_size(rentry->res);
>  			pdata->mmio_base = ioremap(rentry->res->start,
>  						   pdata->mmio_size);
> -			if (!pdata->mmio_base)
> +			if (!pdata->mmio_base) {
> +				ret = -ENOMEM;
>  				goto err_out;
> +			}
>  			break;
>  		}

This looks insufficient to my eyes, as we leak memory here too.

What about the following instead?

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / LPSS: Fix up acpi_lpss_create_device()

Fix a return value (which should be a negative error code) and a
memory leak (the list allocated by acpi_dev_get_resources() needs
to be freed on ioremap() errors too) in acpi_lpss_create_device()
introduced by commit 4483d59e29fe 'ACPI / LPSS: check the result
of ioremap()'.

Fixes: 4483d59e29fe 'ACPI / LPSS: check the result of ioremap()'
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: 4.0+ <stable@vger.kernel.org> # 4.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -352,13 +352,16 @@ static int acpi_lpss_create_device(struc
 				pdata->mmio_size = resource_size(rentry->res);
 			pdata->mmio_base = ioremap(rentry->res->start,
 						   pdata->mmio_size);
-			if (!pdata->mmio_base)
-				goto err_out;
 			break;
 		}
 
 	acpi_dev_free_resource_list(&resource_list);
 
+	if (!pdata->mmio_base) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
 	pdata->dev_desc = dev_desc;
 
 	if (dev_desc->setup)

