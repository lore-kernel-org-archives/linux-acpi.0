From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / LPSS: set an error code
Date: Fri, 3 Jul 2015 11:56:53 +0300
Message-ID: <20150703085653.GC11901@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We should return -ENOMEM if ioremap() fails.

Fixes: 4483d59e29fe ('ACPI / LPSS: check the result of ioremap()')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 569ee09..10bf5c7 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -352,8 +352,10 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 				pdata->mmio_size = resource_size(rentry->res);
 			pdata->mmio_base = ioremap(rentry->res->start,
 						   pdata->mmio_size);
-			if (!pdata->mmio_base)
+			if (!pdata->mmio_base) {
+				ret = -ENOMEM;
 				goto err_out;
+			}
 			break;
 		}
 
