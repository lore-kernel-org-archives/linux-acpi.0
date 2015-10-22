From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPI: Introduce CPU performance controls using CPPC
Date: Thu, 22 Oct 2015 22:49:28 +0300
Message-ID: <20151022194928.GA24403@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41274 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbJVTtf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2015 15:49:35 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ashwin.chaugule@linaro.org
Cc: linux-acpi@vger.kernel.org

Hello Ashwin Chaugule,

The patch 337aadff8e45: "ACPI: Introduce CPU performance controls
using CPPC" from Oct 2, 2015, leads to the following static checker
warning:

	drivers/acpi/cppc_acpi.c:527 acpi_cppc_processor_probe()
	warn: overwrite may leak 'cpc_ptr'

drivers/acpi/cppc_acpi.c
   426          cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
   427          if (!cpc_ptr) {
   428                  ret = -ENOMEM;
   429                  goto out_buf_free;
   430          }
   431  
   432          /* First entry is NumEntries. */
   433          cpc_obj = &out_obj->package.elements[0];
   434          if (cpc_obj->type == ACPI_TYPE_INTEGER) {
   435                  num_ent = cpc_obj->integer.value;
   436          } else {
   437                  pr_debug("Unexpected entry type(%d) for NumEntries\n",
   438                                  cpc_obj->type);
   439                  goto out_free;
   440          }

[ snip ]

   523          kfree(output.pointer);
   524          return 0;
   525  
   526  out_free:
   527          cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);

Why do we have this line?  Maybe it is left over and should be deleted?

   528          kfree(cpc_ptr);
   529  
   530  out_buf_free:
   531          kfree(output.pointer);
   532          return ret;
   533  }

regards,
dan carpenter
