From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ACPI / debugger: Add IO interface to access debugger
 functionalities
Date: Fri, 25 Dec 2015 00:21:42 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB0A839@SHSMSX101.ccr.corp.intel.com>
References: <20151222194840.GA13871@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9023 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbbLYAVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2015 19:21:51 -0500
In-Reply-To: <20151222194840.GA13871@mwanda>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Dan Carpenter
> Subject: re: ACPI / debugger: Add IO interface to access debugger
> functionalities
> 
> Hello Lv Zheng,
> 
> The patch 8cfb0cdf07e2: "ACPI / debugger: Add IO interface to access
> debugger functionalities" from Dec 3, 2015, leads to the following
> static checker warning:
> 
> 	drivers/acpi/acpi_dbg.c:533 acpi_aml_open()
> 	error: double unlock 'mutex:&acpi_aml_io.lock'
> 
> drivers/acpi/acpi_dbg.c
>    498          } else {
>    499                  /*
>    500                   * No writer is allowed unless the debugger thread is
>    501                   * ready.
>    502                   */
>    503                  if (!(acpi_aml_io.flags & ACPI_AML_OPENED)) {
>    504                          ret = -ENODEV;
>    505                          goto err_lock;
> 
> Holding lock.
> 
>    506                  }
>    507          }
>    508          if (acpi_aml_active_reader == file) {
>    509                  pr_debug("Opening debugger interface.\n");
>    510                  mutex_unlock(&acpi_aml_io.lock);
>    511
>    512                  pr_debug("Initializing debugger thread.\n");
>    513                  status = acpi_initialize_debugger();
>    514                  if (ACPI_FAILURE(status)) {
>    515                          pr_err("Failed to initialize debugger.\n");
>    516                          ret = -EINVAL;
>    517                          goto err_lock;
> 
> Not holding lock.
[Lv Zheng] 
Oops.
This is indeed a problem.
I'll send another fix for this.

Thanks and best regards
-Lv

> 
>    518                  }
>    519                  acpi_aml_io.flags |= ACPI_AML_OPENED;
>    520                  pr_debug("Debugger thread initialized.\n");
>    521
>    522                  mutex_lock(&acpi_aml_io.lock);
>    523                  acpi_aml_io.out_crc.head = acpi_aml_io.out_crc.tail = 0;
>    524                  acpi_aml_io.in_crc.head = acpi_aml_io.in_crc.tail = 0;
>    525                  pr_debug("Debugger interface opened.\n");
>    526          }
>    527          acpi_aml_io.users++;
>    528  err_lock:
>    529          if (IS_ERR_VALUE(ret)) {
>    530                  if (acpi_aml_active_reader == file)
>    531                          acpi_aml_active_reader = NULL;
>    532          }
>    533          mutex_unlock(&acpi_aml_io.lock);
> 
> Double onlock.
> 
>    534          return ret;
>    535  }
> 
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
