From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] ACPI suspend: Always use the 32-bit waking vector
Date: Wed, 17 Sep 2008 09:29:38 +0200
Message-ID: <20080917072938.GB2659@elf.ucw.cz>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809061313.02088.rjw@sisk.pl> <20080915095001.GA2015@elf.ucw.cz> <200809170746.43548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41460 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYIQH2T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2008 03:28:19 -0400
Content-Disposition: inline
In-Reply-To: <200809170746.43548.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Wed 2008-09-17 07:46:42, Rafael J. Wysocki wrote:
> On Monday, 15 of September 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > Well, I read this part of the spec (2.0c, 3.0b) more carefully and it matches
> > > what you're saying.  Moreover, my understanding of it is that we should
> > > actually _clear_ the 64-bit vector on systems that support it, because
> > > otherwise the BIOS is supposed to use it and call the wake-up code in protected
> > > mode.
> > > 
> > > The appended patch is based on this observation.
> > > 
> > > Thanks,
> > > Rafael
> > > 
> > > ---
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > ACPI suspend: Always use the 32-bit waking vector
> > > 
> > > According to the ACPI specification 2.0c and later, the 64-bit waking vector
> > > should be cleared and the 32-bit waking vector should be used, unless we want
> > > the wake-up code to be called by the BIOS in Protected Mode.  Moreover, some
> > > systems (for example HP dv5-1004nr) are known to fail to resume if the 64-bit
> > > waking vector is used.  Therefore, modify the code to clear the 64-bit waking
> > > vector, for FACS version 1 or greater, and set the 32-bit one before suspend.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/acpi/hardware/hwsleep.c |   37 +++++++++++--------------------------
> > >  1 file changed, 11 insertions(+), 26 deletions(-)
> > > 
> > > @@ -134,20 +132,7 @@ acpi_get_firmware_waking_vector(acpi_phy
> > >  	}
> > >  
> > >  	/* Get the vector */
> > > -
> > > -	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
> > > -		/*
> > > -		 * ACPI 1.0 FACS or short table or optional X_ field is zero
> > > -		 */
> > > -		*physical_address =
> > > -		    (acpi_physical_address) facs->firmware_waking_vector;
> > > -	} else {
> > > -		/*
> > > -		 * ACPI 2.0 FACS with valid X_ field
> > > -		 */
> > > -		*physical_address =
> > > -		    (acpi_physical_address) facs->xfirmware_waking_vector;
> > > -	}
> > > +	*physical_address = (acpi_physical_address)facs->firmware_waking_vector;
> > >  
> > >  	return_ACPI_STATUS(AE_OK);
> > >  }
> > 
> > Actually, I guess we should kill acpi_get_firmware_waking_vector: It
> > is completely useless, and it is indeed never used in whole Linux...
> 
> Well, it's under '#ifdef 0' anyway, but I wanted it to be consistent with the
> code we actually use. :-)

Yes, removing dead code is separate battle, I see.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
