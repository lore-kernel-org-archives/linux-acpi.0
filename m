From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: ACPICA: Tables: Cleanup RSDP signature codes.
Date: Fri, 25 Oct 2013 13:49:14 +0800
Message-ID: <20131025054913.GA20961@aaronlu.linux.com>
References: <20130926223520.GA25642@elgon.mountain>
 <20131017123942.GG5550@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:47574 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3JYFsr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2013 01:48:47 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so3507912pde.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Oct 2013 22:48:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131017123942.GG5550@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: lv.zheng@intel.com, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>

On Thu, Oct 17, 2013 at 03:39:42PM +0300, Dan Carpenter wrote:
> Does anyone have an idea about this?  The code is obviously wrong but
> the fix is unclear.  Perhaps we should just note the bug in a comment?

The code is confusing but did things right.
The RSDP table header is different with other tables, its signature is
actually 8 bytes. We passed the table address to this print function
using the common table header pointer that caused the warning.

Perhaps we should change the prototype of acpi_tb_print_table_header to:
void
acpi_tb_print_table_header(acpi_physical_address address, void *header)
and then cast it to appropriate type after we found which type of table
it is really is. I suppose this will eliminate the warning?

Thanks,
Aaron

> 
> regards,
> dan carpenter
> 
> On Fri, Sep 27, 2013 at 01:35:20AM +0300, Dan Carpenter wrote:
> > Hello Lv Zheng,
> > 
> > I'm sorry to bother you about this.  This code has been this way for
> > years, but your recent formatting cleanups made it into something Smatch
> > could understand and complain about.  Hopefully, you could take a look?
> > 
> > The patch cacba8657351: "ACPICA: Tables: Cleanup RSDP signature
> > codes." from Sep 23, 2013, leads to the following
> > static checker warning: "drivers/acpi/acpica/tbprint.c:141
> > acpi_tb_print_table_header()
> > 	 error: strncmp() '((((header->signature))))' too small (4 vs 8)"
> > 
> > drivers/acpi/acpica/tbprint.c
> >    138                  ACPI_INFO((AE_INFO, "%4.4s %p %05X",
> >    139                             header->signature, ACPI_CAST_PTR(void, address),
> >    140                             header->length));
> >    141          } else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
> >                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > The RSDP_SIG is an 8 character signature but the header->signature
> > buffer only has 4 characters so the signatures never match.  What's the
> > deal with that?
> > 
> >    142  
> >    143                  /* RSDP has no common fields */
> >    144  
> >    145                  ACPI_MEMCPY(local_header.oem_id,
> >    146                              ACPI_CAST_PTR(struct acpi_table_rsdp,
> >    147                                            header)->oem_id, ACPI_OEM_ID_SIZE);
> > 
> > regards,
> > dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
