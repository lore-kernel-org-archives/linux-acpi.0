From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 04 Sep 2008 17:27:55 +0800
Message-ID: <1220520475.4007.134.camel@yakui_zhao.sh.intel.com>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
	 <200809041010.07058.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14739 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbYIDJNv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 05:13:51 -0400
In-Reply-To: <200809041010.07058.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thu, 2008-09-04 at 10:10 +0200, Rafael J. Wysocki wrote:
> On Thursday, 4 of September 2008, Zhao Yakui wrote:
> > Subject: ACPI : Set 32bit and 64bit waking vector in FCAS table
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> >     On some laptops only the 64bit waking vecotr is set for ACPI 2.0 FACS.
> > But when the system is resumed, BIOS will transfer control directly to 
> > 32bit waking vector. In such case the system can't be resumed correctly.
> >     Maybe it will be more appropriate that both the 32bit and 64bit waking 
> > vector will be set for the ACPI 2.0 FACS when the system enters the S3 
> > sleeping state.
> > 
> >  http://bugzilla.kernel.org/show_bug.cgi?id=11368
> 
> Well, the spec (2.0c) says we should use facs->firmware_waking_vector only
> if facs->xfirmware_waking_vector is zero, so I'm afraid this change may cause
> regressions to happen.
The 32bit and 64bit waking vector are for BIOS. For the ACPI 2.0 FACS
after the system is resumed, firmware will check whether the 64bit
waking vector is zero. If not zero, it will transfer controls to 64 bit
waking vector address. If zero, it will then check whether the 32bit is
zero. If not zero, it will transfer controls to the 32bit waking vector
address. 
If bios can follow above check, it is ok to set only one. And another is
set to zero. But if BIOS can't follow above check and only 64bit waking
vector is set, maybe the system can't be resumed very well.
> 
> Moreover, both 1.0b and 2.0c say that facs->length should be at least 64 bytes,
> so the (facs->length >= 32) check is actually redundant (unless there is a
> quirk setting this value below 32 for some broken systems I'm not aware of).
What you said is right. In ACPI 1.0b FACS the length is also 64 Bytes. 
We should use the facs->version to determine whether 64bit waking vector
needs to be set.
> So, the question is what happens if we ignore the facs->length check on systems
> this patch is supposed to fix.  If they _still_ require
> facs->firmware_waking_vector to be set even if
> facs->xfirmware_waking_vector is non-zero, I'd prefer to add quirks for them
> instead of affecting everybody else.
> 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/hardware/hwsleep.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> > +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> > @@ -80,14 +80,14 @@ acpi_set_firmware_waking_vector(acpi_phy
> >  
> >  	/* Set the vector */
> >  
> > -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> > -		/*
> > -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> > -		 */
> > -		facs->firmware_waking_vector = (u32) physical_address;
> > -	} else {
> > +	/* 32 Bit wakeing vector is always set */
> > +	facs->firmware_waking_vector = (u32) physical_address;
> > +
> > +	if (facs->length >= 32) {
> >  		/*
> > -		 * ACPI 2.0 FACS with valid X_ field
> > +		 * ACPI 2.0 FACS with the valid X_filed. Its length
> > +		 * will be more than 32 bytes. In such case the 64 bit
> > +		 * waking vector is also set.
> >  		 */
> >  		facs->xfirmware_waking_vector = physical_address;
> >  	}
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 

