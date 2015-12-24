From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 2/2] ACPI / debugger: copy_to_user doesn't return errors
Date: Thu, 24 Dec 2015 22:15:48 +0300
Message-ID: <20151224191548.GB5284@mwanda>
References: <20151224072437.GB29642@mwanda>
 <alpine.DEB.2.02.1512240838170.2053@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21601 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbbLXTPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2015 14:15:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1512240838170.2053@localhost6.localdomain6>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Dec 24, 2015 at 08:39:06AM +0100, Julia Lawall wrote:
> On Thu, 24 Dec 2015, Dan Carpenter wrote:
> 
> > The copy_to/from_user() functions don't return error codes, they return
> > the number of bytes remaining.  We had intended to return -EFUALT here.
> > We actually have already checked access_ok() in an earlier function so
> > I don't think these functions will fail but let's fix it anyway.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> > index f2c92ab..2a1777b 100644
> > --- a/drivers/acpi/acpi_dbg.c
> > +++ b/drivers/acpi/acpi_dbg.c
> > @@ -592,9 +592,10 @@ static int acpi_aml_read_user(char __user *buf, int len)
> >  	smp_rmb();
> >  	p = &crc->buf[crc->tail];
> >  	n = min(len, circ_count_to_end(crc));
> > -	ret = copy_to_user(buf, p, n);
> > -	if (IS_ERR_VALUE(ret))
> 
> I'm not familiar with IS_ERR_VALUE.  Is it to allow functions that
> return unsigned values to also return negative error codes?

Yes, but here it is used as a substitue for checking if (ret < 0) or if
(ret >= 0).  I would have prefered to open code it.  Also I prefer
if (ret) for when the value is either zero or negative error codes but
here we have standardized on IS_ERR_VALUE(ret) for everything.

regards,
dan carpenter

