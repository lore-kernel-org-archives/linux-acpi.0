From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: libnvdimm, nfit, nd_blk: driver for BLK-mode access persistent
 memory
Date: Tue, 30 Jun 2015 20:42:22 +0300
Message-ID: <20150630174222.GA30796@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27322 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbF3RlU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2015 13:41:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ross.zwisler@linux.intel.com
Cc: linux-nvdimm@ml01.01.org, linux-acpi@vger.kernel.org

Hello Ross Zwisler,

This is a semi-automatic email about new static checker warnings.

The patch 047fc8a1f9a6: "libnvdimm, nfit, nd_blk: driver for BLK-mode 
access persistent memory" from Jun 25, 2015, leads to the following 
Smatch complaint:

drivers/acpi/nfit.c:1224 acpi_nfit_blk_region_enable()
	 error: we previously assumed 'nfit_mem' could be null (see line 1223)

drivers/acpi/nfit.c
  1222		nfit_mem = nvdimm_provider_data(nvdimm);
  1223		if (!nfit_mem || !nfit_mem->dcr || !nfit_mem->bdw) {
                     ^^^^^^^^
Check.

  1224			dev_dbg(dev, "%s: missing%s%s%s\n", __func__,
  1225					nfit_mem ? "" : " nfit_mem",
  1226					nfit_mem->dcr ? "" : " dcr",
                                        ^^^^^^^^^^^^^
Unchecked dereference.

regards,
dan carpenter
