From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: PNPACPI: add support for HP vendor-specific CCSR descriptors
Date: Mon, 25 Jan 2016 21:31:44 +0300
Message-ID: <20160125183144.GA25673@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42526 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488AbcAYSbw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 13:31:52 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bjorn.helgaas@hp.com
Cc: linux-acpi@vger.kernel.org

Hello Bjorn Helgaas,

The patch 40ab4f4c1d84: "PNPACPI: add support for HP vendor-specific
CCSR descriptors" from Jun 27, 2008, leads to the following static
checker warning:

	drivers/pnp/pnpacpi/rsparser.c:170 pnpacpi_parse_allocated_vendor()
	error: __memcpy() 'vendor->byte_data' too small (1 vs 8)

drivers/pnp/pnpacpi/rsparser.c
   164  static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
   165                                      struct acpi_resource_vendor_typed *vendor)
   166  {
   167          if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
   168                  u64 start, length;
   169  
   170                  memcpy(&start, vendor->byte_data, sizeof(start));
                                       ^^^^^^^^^^^^^^^^^
This is only 1 byte follow by 7 bytes of data we didn't want.

   171                  memcpy(&length, vendor->byte_data + 8, sizeof(length));
   172  
   173                  pnp_add_mem_resource(dev, start, start + length - 1, 0);
   174          }
   175  }

regards,
dan carpenter
