From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [patch 2/2] ACPI / debugger: copy_to_user doesn't return errors
Date: Fri, 25 Dec 2015 03:25:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB0A8E8@SHSMSX101.ccr.corp.intel.com>
References: <20151224072437.GB29642@mwanda>
 <alpine.DEB.2.02.1512240838170.2053@localhost6.localdomain6>
 <20151224191548.GB5284@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15044 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbbLYDZX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2015 22:25:23 -0500
In-Reply-To: <20151224191548.GB5284@mwanda>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

Hi,

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Friday, December 25, 2015 3:16 AM
> Subject: Re: [patch 2/2] ACPI / debugger: copy_to_user doesn't return errors
> 
> On Thu, Dec 24, 2015 at 08:39:06AM +0100, Julia Lawall wrote:
> > On Thu, 24 Dec 2015, Dan Carpenter wrote:
> >
> > > The copy_to/from_user() functions don't return error codes, they return
> > > the number of bytes remaining.  We had intended to return -EFUALT here.
> > > We actually have already checked access_ok() in an earlier function so
> > > I don't think these functions will fail but let's fix it anyway.
> > >
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> > > index f2c92ab..2a1777b 100644
> > > --- a/drivers/acpi/acpi_dbg.c
> > > +++ b/drivers/acpi/acpi_dbg.c
> > > @@ -592,9 +592,10 @@ static int acpi_aml_read_user(char __user *buf,
> int len)
> > >  	smp_rmb();
> > >  	p = &crc->buf[crc->tail];
> > >  	n = min(len, circ_count_to_end(crc));
> > > -	ret = copy_to_user(buf, p, n);
> > > -	if (IS_ERR_VALUE(ret))
> >
> > I'm not familiar with IS_ERR_VALUE.  Is it to allow functions that
> > return unsigned values to also return negative error codes?
> 
> Yes, but here it is used as a substitue for checking if (ret < 0) or if
> (ret >= 0).  I would have prefered to open code it.  Also I prefer
> if (ret) for when the value is either zero or negative error codes but
> here we have standardized on IS_ERR_VALUE(ret) for everything.
[Lv Zheng] 
This patch looks correct.
It's good for me to know the rule for copy_to/from_user().
Thanks for pointing out.

Thanks and best regards
-Lv

> 
> regards,
> dan carpenter

