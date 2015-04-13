From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPI / scan: Simplify acpi_match_device()
Date: Mon, 13 Apr 2015 22:21:59 +0300
Message-ID: <20150413192159.GA10774@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35209 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbDMTWL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2015 15:22:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Rafael J. Wysocki,

The patch e1acdeb0e770: "ACPI / scan: Simplify acpi_match_device()"
from Apr 10, 2015, leads to the following static checker warning:

	drivers/acpi/scan.c:269 acpi_companion_match()
	error: potential NULL dereference 'adev'.

drivers/acpi/scan.c
   247  static struct acpi_device *acpi_companion_match(const struct device *dev)
   248  {
   249          struct acpi_device *adev;
   250  
   251          adev = ACPI_COMPANION(dev);
   252          if (!adev)
   253                  return NULL;
   254  
   255          if (list_empty(&adev->pnp.ids))
   256                  return NULL;
   257  
   258          mutex_lock(&adev->physical_node_lock);
   259          if (list_empty(&adev->physical_node_list)) {
   260                  adev = NULL;
                        ^^^^^^^^^^^
   261          } else {
   262                  const struct acpi_device_physical_node *node;
   263  
   264                  node = list_first_entry(&adev->physical_node_list,
   265                                          struct acpi_device_physical_node, node);
   266                  if (node->dev != dev)
   267                          adev = NULL;
                                ^^^^^^^^^^^^
   268          }
   269          mutex_unlock(&adev->physical_node_lock);
                              ^^^^^^
Dereference.

   270  
   271          return adev;
   272  }

regards,
dan carpenter
