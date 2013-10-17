From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ACPICA: Tables: Cleanup RSDP signature codes.
Date: Thu, 17 Oct 2013 15:39:42 +0300
Message-ID: <20131017123942.GG5550@mwanda>
References: <20130926223520.GA25642@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25574 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab3JQMjz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2013 08:39:55 -0400
Content-Disposition: inline
In-Reply-To: <20130926223520.GA25642@elgon.mountain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: linux-acpi@vger.kernel.org

Does anyone have an idea about this?  The code is obviously wrong but
the fix is unclear.  Perhaps we should just note the bug in a comment?

regards,
dan carpenter

On Fri, Sep 27, 2013 at 01:35:20AM +0300, Dan Carpenter wrote:
> Hello Lv Zheng,
> 
> I'm sorry to bother you about this.  This code has been this way for
> years, but your recent formatting cleanups made it into something Smatch
> could understand and complain about.  Hopefully, you could take a look?
> 
> The patch cacba8657351: "ACPICA: Tables: Cleanup RSDP signature
> codes." from Sep 23, 2013, leads to the following
> static checker warning: "drivers/acpi/acpica/tbprint.c:141
> acpi_tb_print_table_header()
> 	 error: strncmp() '((((header->signature))))' too small (4 vs 8)"
> 
> drivers/acpi/acpica/tbprint.c
>    138                  ACPI_INFO((AE_INFO, "%4.4s %p %05X",
>    139                             header->signature, ACPI_CAST_PTR(void, address),
>    140                             header->length));
>    141          } else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
>                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The RSDP_SIG is an 8 character signature but the header->signature
> buffer only has 4 characters so the signatures never match.  What's the
> deal with that?
> 
>    142  
>    143                  /* RSDP has no common fields */
>    144  
>    145                  ACPI_MEMCPY(local_header.oem_id,
>    146                              ACPI_CAST_PTR(struct acpi_table_rsdp,
>    147                                            header)->oem_id, ACPI_OEM_ID_SIZE);
> 
> regards,
> dan carpenter
