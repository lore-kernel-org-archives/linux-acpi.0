From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v4 2/4] ACPICA: Tables: Add mechanism to allow to
 balance late stage acpi_get_table() independently
Date: Mon, 15 May 2017 06:32:48 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEA3A13@SHSMSX101.ccr.corp.intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <86628bf775497ed03931e30361bb6115d78876be.1494309338.git.lv.zheng@intel.com>
 <1660120.KNfsmTX9Wg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:32676 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759323AbdEOGcw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 May 2017 02:32:52 -0400
In-Reply-To: <1660120.KNfsmTX9Wg@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: Re: [PATCH v4 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage
> acpi_get_table() independently
> 
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

This is just a no-op change equivalent to
 "
  if (validation_count == 0) { warn and return }
  decrement
 "
It expands "decrement" to "validation_count == 0" case so that it can implement warn_once for the warning message.

See:
A. validation_count == 0:
   A.1. "if (validation_count < ACPI_MAX_TABLE_VALIDATIONS)" matches, and
        After decrementing validation_count, it will be "0xFFFF";
        Then "if (validation_count >= ACPI_MAX_TABLE_VALIDATIONS)" matches as "validation_count == 0xFFFF(ACPI_MAX_TABLE_VALIDATIONS)" now;
        The warning message is printed;
   A.2. "if (validation_count == ACPI_MAX_TABLE_VALIDATIONS)" doesn't match as "validation_count == 0xFFFF(ACPI_MAX_TABLE_VALIDATIONS)" now
        the rest of this function will be skipped just like return_VOID.
B. validation_count == 0xFFFF:
   A.1. Both acpi_tb_get_table() and acpi_tb_put_table() won't be able to change validation_count as
        validation_count increment/decrement code fragments are only executed "if (validation_count < ACPI_MAX_TABLE_VALIDATIONS)"
        Thus validation_count is kept as 0xFFFF (in this case, overflowed/underflowed values are same).
   A.2. "if (validation_count == ACPI_MAX_TABLE_VALIDATIONS)" doesn't match as "validation_count == 0xFFFF" now
        the rest of this function will be skipped just like return_VOID.
C. otherwise, validation_count will be decremented like old code

Benefits of using the new algorithm are:
1. ACPI_MAX_TABLE_VALIDATIONS can be something other than 0xFFFF.
   It can be anything now, and the expected behavior can always be ensured.
   IOW, the new algorithm actually supports cases where overflowed/underflowed values are not same.
   You can check this by defining ACPI_MAX_TABLE_VALIDATIONS to 8.
   And you'll see that the 2 functions are still working.
   1.1. If something is broken in acpi_tb_get_table(), validation_count will be kept as 0x0008.
   1.2. If something is broken in acpi_tb_put_table(), validation_count will be kept as 0xFFFF.
        Both 0x0008 and 0xFFFF cannot make
         "if (validation_count < ACPI_MAX_TABLE_VALIDATIONS)" and
         "if (validation_count == 0)" to return true, and
        Thus validation_count is kept unchanged after overflow/underflow.
2. The key benefit of this change is to make the old warning in acpi_tb_put_table() as warn_once.
   For example:
     acpi_get_table();
     for (i = 0; i < 100; i++)
       acpi_put_table()
   Using the old algorithm, the acpi_tb_put_table() warning message will be seen 99 times.
   Using the new algorithm, the acpi_tb_put_table() warning message will be seen only once.
3. logics in acpi_tb_put_table() will be exactly the reversal of the logics in acpi_tb_get_table().
   It'll be easier to maintain both of them with the new overflow/underflow algorithm.
Hope you'll like such a change.

Thanks and best regards
Lv

> 
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
> 
> Thanks,
> Rafael

