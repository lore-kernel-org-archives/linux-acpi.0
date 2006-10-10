From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [patch 02/12] ACPI: fix printk format warnings
Date: Tue, 10 Oct 2006 15:01:55 -0700
Message-ID: <20061010150155.4f5a03d7.rdunlap@xenotime.net>
References: <B28E9812BAF6E2498B7EC5C427F293A4011C5505@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:46996 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030574AbWJJWAb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 18:00:31 -0400
Received: from midway.site ([71.117.236.95]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 15:00:27 -0700
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4011C5505@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 10 Oct 2006 14:47:02 -0700 Moore, Robert wrote:

> A few things:
> 
> 1) is the "z" modifier ANSI C?

Yes.  C99 section 7.19.6.1, paragraph 7:

z  Specifies that a following d, i, o, u, x, or X conversion 
   specifier applies to a size_t or the corresponding signed integer 
   type argument; or that a following n conversion specifier 
   applies to a pointer to a signed integer type
   corresponding to size_t argument.

> 2) in attempting to make this code go both 32/64, and given that we know
> that the sizeof this struct is tiny (36 bytes), would it not make more
> sense to just cast the sizeof to unsigned int or u32? Same argument for
> any use of sizeof in a printf.

Using %zd should always work (unless you are using some $@#% compiler).

> 3) both of these messages are gone in the new table manager, but the
> basic problem remains, I would like to solve it once and for all.

%zd or %zX

> 
> Bob
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of akpm@osdl.org
> > Sent: Tuesday, October 10, 2006 2:21 PM
> > To: Brown, Len
> > Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; rdunlap@xenotime.net
> > Subject: [patch 02/12] ACPI: fix printk format warnings
> > 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Fix printk format warnings in drivers/acpi:
> > drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type
> > 'unsigned int', but argument 5 has type 'long unsigned int'
> > drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type
> > 'unsigned int', but argument 5 has type 'long unsigned int'
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > Cc: "Brown, Len" <len.brown@intel.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  drivers/acpi/tables/tbget.c  |    2 +-
> >  drivers/acpi/tables/tbrsdt.c |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff -puN drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
> > drivers/acpi/tables/tbget.c
> > --- a/drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
> > +++ a/drivers/acpi/tables/tbget.c
> > @@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
> > 
> >  	if (header->length < sizeof(struct acpi_table_header)) {
> >  		ACPI_ERROR((AE_INFO,
> > -			    "Table length (%X) is smaller than minimum
> (%X)",
> > +			    "Table length (%X) is smaller than minimum
> (%zX)",
> >  			    header->length, sizeof(struct
> acpi_table_header)));
> > 
> >  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
> > diff -puN drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
> > drivers/acpi/tables/tbrsdt.c
> > --- a/drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
> > +++ a/drivers/acpi/tables/tbrsdt.c
> > @@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
> > 
> >  	if (table_ptr->length < sizeof(struct acpi_table_header)) {
> >  		ACPI_ERROR((AE_INFO,
> > -			    "RSDT/XSDT length (%X) is smaller than
> minimum
> > (%X)",
> > +			    "RSDT/XSDT length (%X) is smaller than
> minimum
> > (%zX)",
> >  			    table_ptr->length,
> >  			    sizeof(struct acpi_table_header)));
> > 
> > _
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


---
~Randy
