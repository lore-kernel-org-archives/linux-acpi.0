From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 03/14] Thermal: Add get trend, get instance API's to
 thermal_sys
Date: Mon, 27 Aug 2012 09:24:07 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591AD5A6@BGSMSX101.gar.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-4-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B9092632100DE@SHSMSX101.ccr.corp.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591AD4CC@BGSMSX101.gar.corp.intel.com>
 <744357E9AAD1214791ACBA4B0B9092632101ED@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1316 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2H0JYM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 05:24:12 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092632101ED@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

Hi Rui,

> > index
> > > > 8611e3e..32af124 100644
> > > > --- a/include/linux/thermal.h
> > > > +++ b/include/linux/thermal.h
> > > > @@ -185,6 +185,10 @@ struct thermal_cooling_device
> > > > *thermal_cooling_device_register(char *, void *,
> > > >  		const struct thermal_cooling_device_ops *);  void
> > > > thermal_cooling_device_unregister(struct thermal_cooling_device *);
> > > >
> > > > +int get_tz_trend(struct thermal_zone_device *, int); struct
> > >
> > > Coding style.
> >
> > Not sure what you meant here. Checkpatch did not complain either.
> >
> you should start a new line before "struct".

Agreed :-) But in the actual patch it is that way,
I think it is your mailer which is playing things here :-)
Kindly check..

Thanks,
Durga
