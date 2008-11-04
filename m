From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI Cleanup :Initialize EC global lock based on the
	return status
Date: Tue, 04 Nov 2008 17:37:24 +0800
Message-ID: <1225791444.26020.84.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
	 <1225784509.26020.73.camel@yakui_zhao.sh.intel.com>
	 <49100241.2030205@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10520 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbYKDJa0 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 4 Nov 2008 04:30:26 -0500
In-Reply-To: <49100241.2030205@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>

On Tue, 2008-11-04 at 16:05 +0800, Alexey Starikovskiy wrote:
> NAK
Will you please describe the detailed reason?

In the bug 11917 the regression is related with the following commit:
    >commit 27663c5855b10af9ec67bc7dfba001426ba21222
    >Author: Matthew Wilcox <willy@linux.intel.com>
    >Date:   Fri Oct 10 02:22:59 2008 -0400
    >ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit
kernels

    But IMO the main reason is that EC driver misuses the Linux-ACPI
utility interface.(acpi_evaluate_integer).  
    It will be better to determine whether the return value of ACPI
object is effective according to the return status. In such case the
code still can work well even after the Linux-ACPI utility interface is
changed again.
     
    
> Zhao Yakui wrote:
> > Subject: ACPI: Cleanup :Initialize EC global lock based on the return status
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > Initialize the EC global lock based on the returned value of _GLK object.
> > Only when AE_OK is returned by the acpi_evaluate_integer, the EC global lock
> > will be assigned based on the return value of _GLK object.Otherwise it means
> > that there is no _GLK object and the global lock won't be required when EC
> > is accessed.
> > If the return value of _GLK object is not zero, it means that GLobal lock
> > will be required when EC is accessed.
> > If the return value of _GLK object is zero, it means that GLobal lock
> > won't be required when EC is accessed.
> > 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > cc: Alexey Starikovskiy <astarikovskiy@suse.de>
> > cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> > 
> > ---
> >  drivers/acpi/ec.c |   24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/ec.c
> > +++ linux-2.6/drivers/acpi/ec.c
> > @@ -752,8 +752,28 @@ ec_parse_device(acpi_handle handle, u32 
> >  	ec->gpe = tmp;
> >  	/* Use the global lock for all EC transactions? */
> >  	tmp = 0;
> > -	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
> > -	ec->global_lock = tmp;
> > +	/*
> > +	 * Only when AE_OK is returned by acpi_evaluate_interger,
> > +	 * the ec->global_lock will be assigned based on the returned
> > +	 * value by _GLK. Otherwise it means that there is no _GLK object
> > +	 * and global lock won't be required when EC is accessed.
> > +	 * If the return value of _GLK object is not zero, it means that
> > +	 * global lock will be required when EC is accessed.
> > +	 * If the return value of _GLK object is zero, it means that
> > +	 * global lock won't be required when EC is accessed.
> > +	 */
> > +	status = acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
> > +	if (ACPI_SUCCESS(status)) {
> > +		/*
> > +		 * If the return value is not zero, it means that global lock
> > +		 * is required when EC is accessed
> > +		 */
> > +		if (tmp)
> > +			ec->global_lock = 1;
> > +		else
> > +			ec->global_lock = 0;
> > +	} else
> > +		ec->global_lock = 0;
> >  	ec->handle = handle;
> >  	return AE_CTRL_TERMINATE;
> >  }
> > 
> > 
> 

