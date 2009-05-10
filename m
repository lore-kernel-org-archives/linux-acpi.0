From: Vladimir Zajac <eightgraph@gmail.com>
Subject: Re: [PATCH 2.6.30-rc4] thermal: fix off-by-1 error in trip point trigger condition
Date: Sun, 10 May 2009 11:54:09 +0200
Message-ID: <200905101154.09600.eightgraph@gmail.com>
References: <200905061934.21821.eightgraph@gmail.com> <1241657280.15284.107.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:16268 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbZEJJyS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 May 2009 05:54:18 -0400
In-Reply-To: <1241657280.15284.107.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thursday 07 May 2009 02:48:00 Zhang Rui wrote:
> On Thu, 2009-05-07 at 01:34 +0800, Vladimir Zajac wrote:
> > This patch fixes a regression caused by commit
> > b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
> > "ACPI: move thermal trip handling to generic thermal layer"
> > which accidentally changed trip point trigger condition to
> >   temp > trip_temp
> > 
> > This patch changes the trigger condition back to
> >   temp >= trip_temp
> > 
> > Signed-off-by: Vladimir Zajac <eightgraph@gmail.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
> > ---
> > 
> >  thermal_sys.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > --- linux-2.6.30-rc4/drivers/thermal/thermal_sys.c	2009-04-30 23:52:59.000000000 +0200
> > +++ linux-2.6.30-rc4-p1/drivers/thermal/thermal_sys.c	2009-05-04 19:58:30.000000000 +0200
> > @@ -961,7 +961,7 @@ void thermal_zone_device_update(struct t
> >  
> >  		switch (trip_type) {
> >  		case THERMAL_TRIP_CRITICAL:
> > -			if (temp > trip_temp) {
> > +			if (temp >= trip_temp) {
> >  				if (tz->ops->notify)
> >  					ret = tz->ops->notify(tz, count,
> >  							      trip_type);
> > @@ -974,7 +974,7 @@ void thermal_zone_device_update(struct t
> >  			}
> >  			break;
> >  		case THERMAL_TRIP_HOT:
> > -			if (temp > trip_temp)
> > +			if (temp >= trip_temp)
> >  				if (tz->ops->notify)
> >  					tz->ops->notify(tz, count, trip_type);
> >  			break;
> > @@ -986,14 +986,14 @@ void thermal_zone_device_update(struct t
> >  
> >  				cdev = instance->cdev;
> >  
> > -				if (temp > trip_temp)
> > +				if (temp >= trip_temp)
> >  					cdev->ops->set_cur_state(cdev, 1);
> >  				else
> >  					cdev->ops->set_cur_state(cdev, 0);
> >  			}
> >  			break;
> >  		case THERMAL_TRIP_PASSIVE:
> > -			if (temp > trip_temp || tz->passive)
> > +			if (temp >= trip_temp || tz->passive)
> >  				thermal_zone_device_passive(tz, temp,
> >  							    trip_temp, count);
> >  			break;

Forwarding Matthew Garrett's reply from another thread:
> Looks good. You probably need to resend it with a Signed-off-by: line, 
> but feel free to add
> 
> Acked-by: Matthew Garrett <mjg@redhat.com>
> 	
