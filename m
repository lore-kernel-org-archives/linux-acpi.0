From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 64-bit access width firmware
 bug
Date: Thu, 17 Jan 2013 14:27:54 -0800
Message-ID: <20130117222754.GA32229@us.ibm.com>
References: <1358327009-14625-1-git-send-email-jia.zhang@windriver.com>
 <2313122.XO7091fHrU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:55585 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab3AQW2D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2013 17:28:03 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Thu, 17 Jan 2013 17:28:02 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E5CEE6E803A
	for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2013 17:27:56 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r0HMRwm7299042
	for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2013 17:27:58 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r0HMRvgX022702
	for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2013 20:27:57 -0200
Content-Disposition: inline
In-Reply-To: <2313122.XO7091fHrU@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lans Zhang <jia.zhang@windriver.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, Myron Stowe <mstowe@redhat.com>, Huang Ying <ying.huang@intel.com>, Gary Hade <garyhade@us.ibm.com>, Jean Delvare <jdelvare@suse.de>

On Wed, Jan 16, 2013 at 11:54:54PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, January 16, 2013 05:03:29 PM Lans Zhang wrote:
> > The bit width check was introduced by 15afae60 (ACPI, APEI: Fix
> > incorrect APEI register bit width check and usage), and a fixup
> > for incorrect 32-bit width memory address was given by f712c71
> > (ACPI, APEI: Fixup common access width firmware bug). Now there
> > is a similar symptom:
> > 
> > [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x12345000/64/0/3/0]
> > 
> > Another bogus BIOS reports an incorrect 64-bit width in trigger table.
> > Thus, apply to a similar workaround for 64-bit width memory address.
> 
> This makes sense to me, but I'd like more people to have a look at it (Myron,
> Ying, Gary CCed).
> 
> Thanks,
> Rafael
> 
> 
> > Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
> > ---
> >  drivers/acpi/apei/apei-base.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> > index 00a7836..46f80e2 100644
> > --- a/drivers/acpi/apei/apei-base.c
> > +++ b/drivers/acpi/apei/apei-base.c
> > @@ -590,6 +590,9 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
> >  	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
> >  	    *access_bit_width < 32)
> >  		*access_bit_width = 32;
> > +	else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
> > +	    *access_bit_width < 64)
> > +		*access_bit_width = 64;
> >  
> >  	if ((bit_width + bit_offset) > *access_bit_width) {
> >  		pr_warning(FW_BUG APEI_PFX
> > 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> 

This looks reasonable to me.
Acked-by: Gary Hade <garyhade@us.ibm.com>

Copying Jean Delvare who authored the 32-bit fixup.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

