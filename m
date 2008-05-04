From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch 02/10] acpi: fix FADT parsing
Date: Sun, 04 May 2008 17:16:33 +0800
Message-ID: <1209892594.28197.19.camel@yakui_zhao.sh.intel.com>
References: <200805010952.m419q29R031800@imap1.linux-foundation.org>
	 <1209663539.1131.25.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52755 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbYEDBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 May 2008 21:25:25 -0400
In-Reply-To: <1209663539.1131.25.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: akpm@linux-foundation.org, "Moore, Robert" <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, jbeulich@novell.com

On Thu, 2008-05-01 at 19:38 +0200, Thomas Renninger wrote:
> I wonder whether this could be the real fix for the ThinkPads where it
> helped to read FADT entries through RSDT instead of XSDT?
> Could this be related?
> http://bugzilla.kernel.org/show_bug.cgi?id=8246
> 
> Hmm, I'll post the patch there, they should give it a try...
> 
Although this patch can't fix the issue on the Thinkpads laptop of bug
8246, it fixes the error about the bit_width of generic_address.

> Bob, do you mind giving this a review and push it into your acpica tree
> if it looks ok to you?
> This looks like a pretty important fix.
> 
> Thanks,
> 
>    Thomas
> 
> On Thu, 2008-05-01 at 02:52 -0700, akpm@linux-foundation.org wrote:
> > From: "Jan Beulich" <jbeulich@novell.com>
> > 
> > The (1.0 inherited) separate length fields in the FADT are byte granular. 
> > Further, PM1a/b may have distinct lengths and live in distinct address spaces.
> >  acpi_tb_convert_fadt() should account for all of these conditions.
> > 
> > Apart from these changes I'm puzzled by the fact that, not just for
> > acpi_gbl_xpm1{a,b}_enable, acpi_hw_low_level_{read,write}() get an explicit
> > size passed rather than using the size found in the passed GAS.  What happens
> > on a platform that defines PM1{a,b} wider than 16 bits?  Of course,
> > acpi_hw_low_level_{read,write}() at present are entirely un-prepared to deal
> > with sizes other than 8, 16, or 32, not to speak of a non-zero bit_offset or
> > access_width...
> > 
> > Signed-off-by: Jan Beulich <jbeulich@novell.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/acpi/tables/tbfadt.c |   16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff -puN drivers/acpi/tables/tbfadt.c~acpi-fix-fadt-parsing drivers/acpi/tables/tbfadt.c
> > --- a/drivers/acpi/tables/tbfadt.c~acpi-fix-fadt-parsing
> > +++ a/drivers/acpi/tables/tbfadt.c
> > @@ -124,7 +124,7 @@ static struct acpi_fadt_info fadt_info_t
> >  
> >  static void inline
> >  acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
> > -			     u8 bit_width, u64 address)
> > +			     u8 byte_width, u64 address)
> >  {
> >  
> >  	/*
> > @@ -136,7 +136,7 @@ acpi_tb_init_generic_address(struct acpi
> >  	/* All other fields are byte-wide */
> >  
> >  	generic_address->space_id = ACPI_ADR_SPACE_SYSTEM_IO;
> > -	generic_address->bit_width = bit_width;
> > +	generic_address->bit_width = byte_width << 3;
> >  	generic_address->bit_offset = 0;
> >  	generic_address->access_width = 0;
> >  }
> > @@ -343,9 +343,11 @@ static void acpi_tb_convert_fadt(void)
> >  	 *
> >  	 * The PM event blocks are split into two register blocks, first is the
> >  	 * PM Status Register block, followed immediately by the PM Enable Register
> > -	 * block. Each is of length (pm1_event_length/2)
> > +	 * block. Each is of length (xpm1x_event_block.bit_width/2)
> >  	 */
> > -	pm1_register_length = (u8) ACPI_DIV_2(acpi_gbl_FADT.pm1_event_length);
> > +	WARN_ON(ACPI_MOD_16(acpi_gbl_FADT.xpm1a_event_block.bit_width));
> > +	pm1_register_length = (u8) ACPI_DIV_16(acpi_gbl_FADT
> > +					       .xpm1a_event_block.bit_width);
> >  
> >  	/* The PM1A register block is required */
> >  
> > @@ -360,13 +362,17 @@ static void acpi_tb_convert_fadt(void)
> >  	/* The PM1B register block is optional, ignore if not present */
> >  
> >  	if (acpi_gbl_FADT.xpm1b_event_block.address) {
> > +		WARN_ON(ACPI_MOD_16(acpi_gbl_FADT.xpm1b_event_block.bit_width));
> > +		pm1_register_length = (u8) ACPI_DIV_16(acpi_gbl_FADT
> > +						       .xpm1b_event_block
> > +						       .bit_width);
> >  		acpi_tb_init_generic_address(&acpi_gbl_xpm1b_enable,
> >  					     pm1_register_length,
> >  					     (acpi_gbl_FADT.xpm1b_event_block.
> >  					      address + pm1_register_length));
> >  		/* Don't forget to copy space_id of the GAS */
> >  		acpi_gbl_xpm1b_enable.space_id =
> > -		    acpi_gbl_FADT.xpm1a_event_block.space_id;
> > +		    acpi_gbl_FADT.xpm1b_event_block.space_id;
> >  
> >  	}
> >  }
> > _
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

