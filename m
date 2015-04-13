From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI / scan: Simplify acpi_match_device()
Date: Mon, 13 Apr 2015 21:59:48 +0200
Message-ID: <1668402.ZSbgXyXmVa@vostro.rjw.lan>
References: <20150413192159.GA10774@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58106 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751691AbbDMTfS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2015 15:35:18 -0400
In-Reply-To: <20150413192159.GA10774@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Monday, April 13, 2015 10:21:59 PM Dan Carpenter wrote:
> Hello Rafael J. Wysocki,
> 
> The patch e1acdeb0e770: "ACPI / scan: Simplify acpi_match_device()"
> from Apr 10, 2015, leads to the following static checker warning:
> 
> 	drivers/acpi/scan.c:269 acpi_companion_match()
> 	error: potential NULL dereference 'adev'.
> 
> drivers/acpi/scan.c
>    247  static struct acpi_device *acpi_companion_match(const struct device *dev)
>    248  {
>    249          struct acpi_device *adev;
>    250  
>    251          adev = ACPI_COMPANION(dev);
>    252          if (!adev)
>    253                  return NULL;
>    254  
>    255          if (list_empty(&adev->pnp.ids))
>    256                  return NULL;
>    257  
>    258          mutex_lock(&adev->physical_node_lock);
>    259          if (list_empty(&adev->physical_node_list)) {
>    260                  adev = NULL;
>                         ^^^^^^^^^^^
>    261          } else {
>    262                  const struct acpi_device_physical_node *node;
>    263  
>    264                  node = list_first_entry(&adev->physical_node_list,
>    265                                          struct acpi_device_physical_node, node);
>    266                  if (node->dev != dev)
>    267                          adev = NULL;
>                                 ^^^^^^^^^^^^
>    268          }
>    269          mutex_unlock(&adev->physical_node_lock);
>                               ^^^^^^
> Dereference.
> 
>    270  
>    271          return adev;
>    272  }

Right, thanks.

The patch below should fix it.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / scan: Fix NULL pointer dereference in acpi_companion_match()

Commit e1acdeb0e770 "ACPI / scan: Simplify acpi_match_device()"
introduced code that may lead to a NULL pointer dereference when
trying to unlock a mutex.  Fix that.

Fixes: e1acdeb0e770 "ACPI / scan: Simplify acpi_match_device()"
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -247,6 +247,7 @@ static int create_of_modalias(struct acp
 static struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
+	struct mutex *physical_node_lock;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
@@ -255,7 +256,8 @@ static struct acpi_device *acpi_companio
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
-	mutex_lock(&adev->physical_node_lock);
+	physical_node_lock = &adev->physical_node_lock;
+	mutex_lock(physical_node_lock);
 	if (list_empty(&adev->physical_node_list)) {
 		adev = NULL;
 	} else {
@@ -266,7 +268,7 @@ static struct acpi_device *acpi_companio
 		if (node->dev != dev)
 			adev = NULL;
 	}
-	mutex_unlock(&adev->physical_node_lock);
+	mutex_unlock(physical_node_lock);
 
 	return adev;
 }

