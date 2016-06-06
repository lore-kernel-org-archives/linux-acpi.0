From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to
 new TermList grammar for table loading
Date: Mon, 6 Jun 2016 10:05:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBB9B78@SHSMSX101.ccr.corp.intel.com>
References: <20160604140415.GA3344@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61527 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbcFFKFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jun 2016 06:05:19 -0400
In-Reply-To: <20160604140415.GA3344@mwanda>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Dan

Thanks for the report.
I'll double check it with C=2 enabled build.

Best regards
-Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Dan Carpenter
> Subject: re: ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to
> new TermList grammar for table loading
> 
> Hello Lv Zheng,
> 
> The patch 0bfd2f1ec274: "ACPICA: ACPI 2.0, Interpreter: Fix MLC
> issues by switching to new TermList grammar for table loading" from
> May 13, 2016, leads to the following static checker warning:
> 
> 	drivers/acpi/acpica/nsparse.c:139 acpi_ns_execute_table()
> 	error: we previously assumed 'info' could be null (see line 110)
> 
> drivers/acpi/acpica/nsparse.c
>    135          (void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
>    136
>    137  cleanup:
>    138          acpi_ut_remove_reference(method_obj);
>    139          ACPI_FREE(info->full_pathname);
>                           ^^^^^^^^^^^^^^^^^^^
> Archetypal one err bug.  It's better to unwind in reverse order from how
> you allacted things and only free things you have allocated.  Use more
> than one label.  Also you can use more descriptive label names.
> 
> 	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> 
> free_pathname:
> 	ACPI_FREE(info->full_pathname);
> free_info:
> 	ACPI_FREE(info);
> remove_method:
> 	acpi_ut_remove_reference(method_obj);
> 
> 	return_ACPI_STATUS(status);
> 
> 
>    140          info->full_pathname = NULL;
>    141          ACPI_FREE(info);
>    142          return_ACPI_STATUS(status);
>    143  }
> 
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
