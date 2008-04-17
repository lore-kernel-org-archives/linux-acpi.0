From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 7/7] Who controls brightness functionality: vendor
	specific or generic video driver
Date: Thu, 17 Apr 2008 21:32:18 +0200
Message-ID: <1208460739.1784.398.camel@queen.suse.de>
References: <1208372572.1784.352.camel@queen.suse.de>
	 <20080416210108.GB3396@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:60691 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbYDQTcU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2008 15:32:20 -0400
In-Reply-To: <20080416210108.GB3396@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Mattia Dongili <malattia@linux.it>

On Wed, 2008-04-16 at 18:01 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 16 Apr 2008, Thomas Renninger wrote:
> > Index: linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
> > ===================================================================
> > --- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/misc/thinkpad_acpi.c
> > +++ linux-acpi-2.6_video_native_vs_vendor/drivers/misc/thinkpad_acpi.c
> > @@ -4381,6 +4381,13 @@ static int __init brightness_init(struct
> >  			   "module parameter\n");
> >  		return 1;
> >  	} else if (brightness_enable > 1) {
> > +		if ((acpi_video_support & ACPI_VIDEO_BRIGHTNESS) &&
> > +		    !(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC)) {
> > +			printk(TPACPI_INFO "Brightness ignored, must be "
> > +			       "controlled by ACPI video driver\n");
> > +			return 1;
> > +		}
> > +		/* Above, generic approach should make this check obsolete */
> >  		if (brightness_check_std_acpi_support()) {
> >  			printk(TPACPI_NOTICE
> >  			       "standard ACPI backlight interface "
> 
> Ack.  But I am sure I will have to change this hunk a bit on
> thinkpad-acpi 0.20.  This is not a big issue, and if you prefer, I can
> handle adding the above support for thinkpad-acpi 0.20 since it is
> likely going to be merged late due to its dependency on some stuff for
> the LED class that needs to be in mainline first...

I need to post another version, I hope to find some time over the
week-end.
I also need to go through and disable output switching also where
supported.

Thanks,

   Thomas


