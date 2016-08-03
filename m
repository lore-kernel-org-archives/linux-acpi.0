From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] drivers: net: xgene: Add backward compatibility
Date: Wed, 3 Aug 2016 13:39:34 +0300
Message-ID: <20160803103934.GA22073@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47005 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381AbcHCKkY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2016 06:40:24 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: isubramanian@apm.com
Cc: linux-acpi@vger.kernel.org

Hello Iyappan Subramanian,

The patch 8089a96f601b: "drivers: net: xgene: Add backward
compatibility" from Jul 25, 2016, leads to the following static
checker warning:

	drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:744 acpi_phy_find_device()
	warn: passing negative value to 'ACPI_FAILURE((-71))'

drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
   735  static struct acpi_device *acpi_phy_find_device(struct device *dev)
   736  {
   737          struct acpi_reference_args args;
   738          struct fwnode_handle *fw_node;
   739          int status;
   740  
   741          fw_node = acpi_fwnode_handle(ACPI_COMPANION(dev));
   742          status = acpi_node_get_property_reference(fw_node, "phy-handle", 0,
   743                                                    &args);

acpi_node_get_property_reference() returns normal kernel error codes,
not ACPI error codes.  It doesn't cause a runtime problem but it's
probably should just be "if (status) {".

   744          if (ACPI_FAILURE(status)) {
   745                  dev_dbg(dev, "No matching phy in ACPI table\n");
   746                  return NULL;
   747          }
   748  
   749          return args.adev;
   750  }

regards,
dan carpenter
