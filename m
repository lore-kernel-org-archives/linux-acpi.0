From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 1/2] ACPICA: Tables: Fix regression introduced by a
 too early mechanism enabling
Date: Fri, 28 Apr 2017 01:24:01 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE9A031@SHSMSX101.ccr.corp.intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <1841048.oWuTkq5WIo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938346AbdD1BYG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 21:24:06 -0400
In-Reply-To: <1841048.oWuTkq5WIo@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

Hi, Rafael

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> Wysocki
> Subject: Re: [PATCH v2 1/2] ACPICA: Tables: Fix regression introduced by a too early mechanism
> enabling
> 
> On Thursday, April 27, 2017 04:22:44 PM Lv Zheng wrote:
> > In the Linux kernel side, acpi_get_table() clones haven't been fully
> > balanced by acpi_put_table() invocations. In ACPICA side, due to the design
> > change, there are also unbalanced acpi_get_table_by_index() invocations
> > requiring special care to be cleaned up.
> >
> > So it is not a good timing to report acpi_get_table() counting errors for
> > this period. The strict balanced validation count check should only be
> > enabled after confirming that all invocations are safe and compliant to
> > their designed purposes.
> >
> > Thus this patch removes the fatal error along with lthe error report to
> > fix this issue. Reported by Dan Williams, fixed by Lv Zheng.
> >
> > Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and
> early_acpi_os_unmap_memory() from Linux kernel")
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> 
> Please do not add #if 0 anywhere to the kernel code base.
> 
> If you need to drop some piece of code, just drop it.
> 
> And in this particular case validation_count should be dropped from the data
> type definition too.

Then I would prefer to fix all acpi_get_table() clones in ACPICA.
That could avoid removing the useful code.

Without fixing sysfs/Load/table_handler ones, there will always cases frequently increasing/decreasing the count.
Others seem to be not urgent.

I'll post the fix as an urgent fix here with the ACPICA upstream process bypassed and back port it to ACPICA later.
If there are changes during the back port, I'll take care of making the differences eliminated in the corresponding ACPICA release cycle.

Thanks
Lv


> 
> > ---
> >  drivers/acpi/acpica/tbutils.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> > index 5a968a7..8175c70 100644
> > --- a/drivers/acpi/acpica/tbutils.c
> > +++ b/drivers/acpi/acpica/tbutils.c
> > @@ -418,11 +418,13 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
> >
> >  	table_desc->validation_count++;
> >  	if (table_desc->validation_count == 0) {
> > +		table_desc->validation_count--;
> > +#if 0
> >  		ACPI_ERROR((AE_INFO,
> >  			    "Table %p, Validation count is zero after increment\n",
> >  			    table_desc));
> > -		table_desc->validation_count--;
> >  		return_ACPI_STATUS(AE_LIMIT);
> > +#endif
> >  	}
> >
> >  	*out_table = table_desc->pointer;
> >
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
