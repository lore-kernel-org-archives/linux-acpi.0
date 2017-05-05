From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage acpi_get_table() independently
Date: Fri, 05 May 2017 22:43:12 +0200
Message-ID: <2006722.863OfZUBRq@aspire.rjw.lan>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com> <3915288.8qJPC28FTg@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CE9D136@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65086 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbdEEUtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2017 16:49:35 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE9D136@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On Thursday, May 04, 2017 07:18:28 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> > Wysocki
> > Subject: Re: [PATCH v3 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage
> > acpi_get_table() independently
> > 
> > On Friday, April 28, 2017 01:30:20 PM Lv Zheng wrote:
> > > For all frequent late stage acpi_get_table() clone invocations, we should
> > > only fix them altogether, otherwise, excessive acpi_put_table() could
> > > unexpectedly unmap the table used by the other users. Thus the current plan
> > > is to fix all acpi_get_table() clones together or to fix none of them.
> > 
> > I honestly don't think that fixing none of them is a valid option here.
> 
> That's just exactly the old behavior, maybe shouldn't be called as "fix".
> Should say "change to use the new behavior together" all stay unchanged.
> 
> I actually want to make the change from ACPICA side.
> But it's costly to persuade ACPICA upstream to take both the "acpi_get_table_with_size()/early_acpi_os_unmap_memory() divergence reduction" change and the "table map on-demand" change.
> 
> So we just made 2 things separated, and did 1 thing once.
> 
> > 
> > > This prevents kernel developers from improving the late stage code quality
> > > without waiting for the ACPICA upstream to improve first.
> > >
> > > This patch adds a mechanism to stop decrementing validation count to
> > > prevent the table unmapping operations so that acpi_put_table() balance
> > > fixes can be done independently to each others.
> > >
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > ---
> > >  drivers/acpi/acpica/tbutils.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> > > index 7abe665..b517bd0 100644
> > > --- a/drivers/acpi/acpica/tbutils.c
> > > +++ b/drivers/acpi/acpica/tbutils.c
> > > @@ -445,12 +445,18 @@ void acpi_tb_put_table(struct acpi_table_desc *table_desc)
> > >
> > >  	ACPI_FUNCTION_TRACE(acpi_tb_put_table);
> > >
> > > -	if (table_desc->validation_count == 0) {
> > > +	if ((table_desc->validation_count + 1) == 0) {
> > 
> > This means that validation_count has reached the maximum value, right?
> > 
> > >  		ACPI_WARNING((AE_INFO,
> > > -			      "Table %p, Validation count is zero before decrement\n",
> > > +			      "Table %p, Validation count is about to expire, decrement is unsafe\n",
> > >  			      table_desc));
> > 
> > So why is it unsafe to decrement it?
> 
> Considering this case:
> A program opens a sysfs table file 65535 times: validation_count = 65535.
> Load opcode is invoked by the AML interpreter, but it cannot increase the validation count, see acpi_tb_get_table(): validation_count = 65535.
> Now the program closes the sysfs table file: validation_count = 0, which triggers table unmap.
> But it is likely that the AML code is still accessing the namespace objects provided by this table.
> A kernel crash then can be seen.
> 
> So after applying this patch, 65535 now is the threshold.

OK, so this is overflow detection in disguise. :-)

It is quite confusing, IMO.  It would be better to define a limit symbol like
ACPI_TABLE_VCOUNT_MAX below the natural maximum of the data type
(say, make it equal to 65534 if the data type is unsigned short int) and then
make *both* acpi_tb_get_table() and acpi_tb_put_table() refuse to update
validation_count *and* print a "validation count overflow" message once it
has become greater than ACPI_TABLE_VCOUNT_MAX (in which case it will
natrually stay at ACPI_TABLE_VCOUNT_MAX+1).

Thanks,
Rafael

