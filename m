From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage acpi_get_table() independently
Date: Fri, 12 May 2017 23:41:26 +0200
Message-ID: <2101425.aQhWfuyaHJ@aspire.rjw.lan>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com> <86628bf775497ed03931e30361bb6115d78876be.1494309338.git.lv.zheng@intel.com> <1660120.KNfsmTX9Wg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48221 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755256AbdELVr6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 17:47:58 -0400
In-Reply-To: <1660120.KNfsmTX9Wg@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Friday, May 12, 2017 11:03:52 PM Rafael J. Wysocki wrote:
> On Tuesday, May 09, 2017 01:57:41 PM Lv Zheng wrote:
> > For all frequent late stage acpi_get_table() clone invocations, we should
> > only change them altogether, otherwise, excessive acpi_put_table() could
> > unexpectedly unmap the table used by the other users. Thus the current plan
> > is to change all acpi_get_table() clones together or to change none of
> > them. However in practical, this is not convenient as this can prevent
> > kernel developers' efforts of improving the late stage code quality before
> > waiting for the ACPICA upstream to improve first.
> > 
> > This patch adds a validation count threashold, when it is reached, the
> > validation count can no longer be incremented/decremented to invalidate the
> > table descriptor (means preventing table unmappings) so that acpi_put_table()
> > balance changes can be done independently to each others. Lv Zheng.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/acpica/tbutils.c | 24 +++++++++++++++---------
> >  include/acpi/actbl.h          |  9 +++++++++
> >  2 files changed, 24 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> > index 7abe665..04beafc 100644
> > --- a/drivers/acpi/acpica/tbutils.c
> > +++ b/drivers/acpi/acpica/tbutils.c
> > @@ -416,9 +416,13 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
> >  		}
> >  	}
> >  
> > -	table_desc->validation_count++;
> > -	if (table_desc->validation_count == 0) {
> > -		table_desc->validation_count--;
> > +	if (table_desc->validation_count < ACPI_MAX_TABLE_VALIDATIONS) {
> > +		table_desc->validation_count++;
> > +		if (table_desc->validation_count >= ACPI_MAX_TABLE_VALIDATIONS) {
> > +			ACPI_WARNING((AE_INFO,
> > +				      "Table %p, Validation count overflows\n",
> > +				      table_desc));
> > +		}
> >  	}
> >  
> >  	*out_table = table_desc->pointer;
> > @@ -445,13 +449,15 @@ void acpi_tb_put_table(struct acpi_table_desc *table_desc)
> >  
> >  	ACPI_FUNCTION_TRACE(acpi_tb_put_table);
> >  
> > -	if (table_desc->validation_count == 0) {
> > -		ACPI_WARNING((AE_INFO,
> > -			      "Table %p, Validation count is zero before decrement\n",
> > -			      table_desc));
> > -		return_VOID;
> > +	if (table_desc->validation_count < ACPI_MAX_TABLE_VALIDATIONS) {
> > +		table_desc->validation_count--;
> > +		if (table_desc->validation_count >= ACPI_MAX_TABLE_VALIDATIONS) {
> 
> Is this going to ever trigger?
> 
> We've already verified that validation_count is not 0 and that it is less than
> ACPI_MAX_TABLE_VALIDATIONS and we have decremented it, so how can it be
> greater than or equal to ACPI_MAX_TABLE_VALIDATIONS here?

Wrong question, sorry.

I think that the check is in case validation_count was 0 before the decrementation,
right?

So then, I'd still check if validation_count == 0 and if so, set it to
ACPI_MAX_TABLE_VALIDATIONS.

Next, if validation_count => ACPI_MAX_TABLE_VALIDATIONS, I'd print the warning
message and return.

Then, the decrementation would not underflow, so it would be safe to do it.

Wouldn't that be somewhat easier to follow?

> > +			ACPI_WARNING((AE_INFO,
> > +				      "Table %p, Validation count underflows\n",
> > +				      table_desc));
> > +			return_VOID;
> > +		}
> >  	}
> > -	table_desc->validation_count--;
> >  
> >  	if (table_desc->validation_count == 0) {
> >

Thanks,
Rafael

