From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 21/98] ACPICA: Check for non-zero address before being
 converted to GAS
Date: Fri, 03 Apr 2009 09:09:32 +0800
Message-ID: <1238720972.25165.2.camel@minggr.sh.intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
	 <5e053e77f233342b56fda419d347fd2c958b9849.1238214618.git.len.brown@intel.com>
	 <200904021359.01408.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38311 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbZDCBYI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 21:24:08 -0400
In-Reply-To: <200904021359.01408.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Thu, 2009-04-02 at 19:59 +0800, Thomas Renninger wrote:
> On Saturday 28 March 2009 05:30:56 Len Brown wrote:
> > From: Lin Ming <ming.m.lin@intel.com>
> > 
> > Reported-by: FreeBSD community
> > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> Does this fix something for real?

It's a regression fix.
see "linux-next acpi changes make vmware server unusable"
http://marc.info/?l=linux-acpi&m=123620365021296&w=2

Lin Ming

> If yes, please add:
> CC: stable@kernel.org
> not sure if not.
> > ---
> >  drivers/acpi/acpica/tbfadt.c |   16 +++++++++-------
> >  1 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/tbfadt.c 
> b/drivers/acpi/acpica/tbfadt.c
> > index a8191ef..43fe886 100644
> > --- a/drivers/acpi/acpica/tbfadt.c
> > +++ b/drivers/acpi/acpica/tbfadt.c
> > @@ -618,12 +618,14 @@ static void acpi_tb_setup_fadt_registers(void)
> >  		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
> >  				 fadt_pm_info_table[i].source);
> >  
> > -		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
> > -					     source64->space_id,
> > -					     pm1_register_byte_width,
> > -					     source64->address +
> > -					     (fadt_pm_info_table[i].
> > -					      register_num *
> > -					      pm1_register_byte_width));
> > +		if (source64->address) {
> > +			acpi_tb_init_generic_address(fadt_pm_info_table[i].
> > +						     target, source64->space_id,
> > +						     pm1_register_byte_width,
> > +						     source64->address +
> > +						     (fadt_pm_info_table[i].
> > +						      register_num *
> > +						      pm1_register_byte_width));
> > +		}
> >  	}
> >  }
> > -- 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

