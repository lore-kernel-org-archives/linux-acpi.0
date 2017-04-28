From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 1/2] ACPICA: Tables: Fix regression introduced by a
 too early mechanism enabling
Date: Fri, 28 Apr 2017 03:57:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE9A0BC@SHSMSX101.ccr.corp.intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <1841048.oWuTkq5WIo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62546 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033635AbdD1D5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 23:57:34 -0400
In-Reply-To: <1841048.oWuTkq5WIo@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

Hi, Rafael

I reconsidered your comments.
Seems there are several problems you might not be aware of.
Let me reply again.

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

OK. This comment is addressable.

> 
> And in this particular case validation_count should be dropped from the data
> type definition too.

I don't think this comment is addressable.

===========================================================================
The validation_count is not only used for the late stage, it's also used
for the early boot stage. And during the early boot stage, I'm sure the
validation count is used by us now to correctly unmap early maps. If it is
dropped, the early maps will be leaked to the late stage, leading to some
kernel crashes.

The use case has already been validated to be working in previous Linux
release cycles, also with you, Dan and the other driver maintainers' help.
All crashing early cases are identified and the validation counts are
ensured to be balanced during the early stage.
===========================================================================
Then I thought again if you did have some special concerns for using this
mechanism in the late stage without making the validation count balanced.
The only case we need to worry about is when acpi_get_table() is invoked
more than 65535 times, then more than 65535 acpi_put_table() could
potentially release the table mapping while there are still users using
the mapped table, this could cause kernel crashes.

What does this problem mean to us? It mean: For all frequently invoked
acpi_get_table(), without fixing them altogether, we SHOULD NOT add
acpi_put_table() for them.

As far as I can see, the followings are frequent acpi_get_table() invoking
cases, they need to be fixed altogether:
1. sysfs table access
2. load/unload tables, could potentially be invoked in a
   per-cpu-hotplugging frequent style.
3. get/put in some loadable kernel modules (this actually is not such
   frequent)
4. tables used across suspend/resume (I checked, FACS used in this case is
   safe)

I began to doubt the correctness of fixing only the sysfs case without
fixing all the other "frequent acpi_get_table() cases". It seems fixing it
only adds unwanted acpi_put_table() during the special period, and this
actually breaks the planned way, and can potentially break the end users.
===========================================================================
Then I checked how we could make Load/Unload invocations balanced inside of
ACPICA. It looks we have the following things that must be done to achieve
the balanced validation count inside of ACPICA:
1. There are many "table handler" invocations, we need a single place to
   invoke get/put before/after invoking the handler.
2. There is an acpi_tb_set_table_loaded_flag() API, we need to invoke
   get/put inside of it when the flag is set/unset.
3. For all other acpi_get_table() clone invocations, we need to add
   balanced put(s) to the get(s) except those pinned as global maps.

Then we'll soon figure out that we need to do the following prerequisites:
1. Collect table handlers into 1 function;
2. Should stop invoking acpi_ns_load_table() from other places, but only
   invoke it from acpi_tb_load_table();
3. After changing due to 1 and 2, we need to make sure the table mutex is
   still correctly used;
4. After changing due to 2 and 3, we actually extends some sanity checks
   to the processes originally not covered, and we need to make sure the
   changed sanity checks is still working.
So you'll see the entire work must be based on what Hans De Geode is
asking for: "https://github.com/acpica/acpica/pull/121". This pull request
is still pending for further Windows behavior validation for how signature
is checked by Windows. And on top of that, several changes are still
required for achieving the balanced validation count in ACPICA.

So I really don't think upstreaming all the required changes is a short
period.
===========================================================================

My conclusion is:
We should go back to our planned way, and the only safe regression fix for
the reported issue is to remove the error logs and the failure returning
code from acpi_tb_get_table(). While the error in acpi_tb_put_table()
should be kept, it alerts us that there are too many unexpected
acpi_tb_put_table() invocations.
If we don't stick to the planned way, we possibly should add code in
acpi_tb_put_table() that when the get side is about to expre, stop do any
put side decrement to prevent unwanted unmaps.

Thanks and best regards
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
