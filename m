From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: fix a regression of ACPI device driver autoloading
Date: Tue, 25 Mar 2008 22:49:01 -0400
Message-ID: <200803252249.01693.lenb@kernel.org>
References: <1206002432.3171.90.camel@acpi-hp-zz.sh.intel.com> <1206008865.21619.319.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41332 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495AbYCZEgM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 00:36:12 -0400
In-Reply-To: <1206008865.21619.319.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, kasievers@novell.com, fseidel@suse.de, "Brown, Len" <len.brown@intel.com>

applied

thanks,
-Len

On Thursday 20 March 2008, Thomas Renninger wrote:
> On Thu, 2008-03-20 at 16:40 +0800, Zhang, Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Fix a regression of ACPI driver autoloading.
> Good catch.
> Patch looks correct.
> This should still be 2.6.25 material?
> 
> > commit 3620f2f2f39e7870cf1a4fb2e34063a142f28716 sets the cid of
> > ACPI video/dock/bay device and leaves the hid empty.
> > As a result, "modalias" should export the cid for
> > devices which don't have a hid.
> > 
> > ACPI Video driver is not autoloaded with
> > commit 3620f2f2f39e7870cf1a4fb2e34063a142f28716 applied.
> > "cat /sys/.../device:03(acpi video bus)/modalias" shows nothing.
> > 
> > ACPI Video driver is autoloaded after revert that commit.
> > "cat /sys/.../LNXVIDEO:0x/modalias" shows "acpi:LNXVIDEO:"
> > 
> > ACPI Video driver is autoloaded with commit
> > 3620f2f2f39e7870cf1a4fb2e34063a142f28716 and this patch applied.
> > "cat /sys/.../device:03(acpi video bus)/modalias"
> > shows "acpi:LNXVIDEO:"
> > 
> > CC: Thomas Renninger <trenn@novell.com>
> > CC: Kay Sievers <kasievers@novell.com>
> > CC: Frank Seidel <fseidel@suse.de>
> > CC: Len Brown: <len.brown@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> Thanks,
> 
>     Thomas
> > 
> > ---
> >  drivers/acpi/scan.c |   18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/scan.c
> > +++ linux-2.6/drivers/acpi/scan.c
> > @@ -39,20 +39,26 @@ static int create_modalias(struct acpi_d
> >  			   int size)
> >  {
> >  	int len;
> > +	int count;
> >  
> > -	if (!acpi_dev->flags.hardware_id)
> > +	if (!acpi_dev->flags.hardware_id && !acpi_dev->flags.compatible_ids)
> >  		return -ENODEV;
> >  
> > -	len = snprintf(modalias, size, "acpi:%s:",
> > -		       acpi_dev->pnp.hardware_id);
> > -	if (len < 0 || len >= size)
> > -		return -EINVAL;
> > +	len = snprintf(modalias, size, "acpi:");
> >  	size -= len;
> >  
> > +	if (acpi_dev->flags.hardware_id) {
> > +		count = snprintf(&modalias[len], size, "%s:",
> > +				 acpi_dev->pnp.hardware_id);
> > +		if (count < 0 || count >= size)
> > +			return -EINVAL;
> > +		len += count;
> > +		size -= count;
> > +	}
> > +
> >  	if (acpi_dev->flags.compatible_ids) {
> >  		struct acpi_compatible_id_list *cid_list;
> >  		int i;
> > -		int count;
> >  
> >  		cid_list = acpi_dev->pnp.cid_list;
> >  		for (i = 0; i < cid_list->count; i++) {
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


