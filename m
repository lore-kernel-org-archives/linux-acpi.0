From: Vladimir Zajac <eightgraph@gmail.com>
Subject: Re: PROBLEM: (regression) thermal zone - fan is turned on at higher temperature than it should
Date: Wed, 6 May 2009 07:50:21 +0200
Message-ID: <200905060750.21416.eightgraph@gmail.com>
References: <200905052105.07316.eightgraph@gmail.com> <1241570812.3773.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:47442 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZEFFuX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2009 01:50:23 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1619588fgg.17
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2009 22:50:22 -0700 (PDT)
In-Reply-To: <1241570812.3773.72.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 06 May 2009 02:46:52 you wrote:
> On Wed, 2009-05-06 at 03:05 +0800, Vladimir Zajac wrote:
> > [1.] One line summary of the problem:
> > (regression) thermal zone - fan is turned on at higher temperature than it should
> > 
> > [2.] Full description of the problem/report:
> > After upgrade to 2.6.30-rc4 I noticed that my laptop's fan sometimes runs at lower speed than it used to.
> > 2.6.29 does not have the bug.
> > 
> > The laptop (HP Compaq 6710b) has 5 ACPI cooling devices which correspond to different fan speeds. They are not turned on when I expect them to be.
> > 
> > Expected behavior: 
> > Each active cooling device should be turned on when current temperature is equal or higher than its trip point.
> > (This is how it worked in 2.6.29 and earlier versions and also how it is defined by ACPI specification.)
> > 
> > Actual behavior in 2.6.30-rc4: 
> > Each cooling device is turned on only when current temperature is strictly greater than the corresponding trip point but not when current temperature is equal to the trip point.
> > 
> > It is caused by commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e:
> > 
> > author	Matthew Garrett <mjg59@srcf.ucam.org>
> > 	Wed, 3 Dec 2008 17:55:32 +0000 (17:55 +0000)
> > committer	Len Brown <len.brown@intel.com>
> > 	Fri, 20 Feb 2009 23:41:56 +0000 (18:41 -0500)
> > commit	b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
> > ACPI: move thermal trip handling to generic thermal layer
> > 
> > 
> > This commit (probably unintentionally) also changed how kernel determines if a cooling device has to be activated:
> >  before the commit: cooling device is activated if current temperature >= trip point temperature
> >   after the commit: cooling device is activated if current temperature > trip point temperature
> Do you mean that the issue can be fixed by changing the "temperature >
> trip point" to "temperature >= trip point"?
> If so, what you have done is reasonable.
> 
> Thanks.

Yes, it can be fixed by changing the "temperature > trip point" to "temperature >= trip point".

> > 
> > I tried to change the trip point test back to "temp >= trip_temp" in drivers/thermal/termal_sys.c (attached patch). It fixes the issue on my laptop.
> > 
> > [3.] Keywords (i.e., modules, networking, kernel):
> > acpi, thermal zone
> > 
> > [4.] Kernel information
> > [4.1.] Kernel version (from /proc/version):
> > Linux version 2.6.30-rc4-64v01kms (root@V2G64) (gcc version 4.3.2 (Gentoo 4.3.2-r3 p1.6, pie-10.1.5) ) #2 SMP PREEMPT Fri May 1 00:11:41 CEST 2009
> > 
> > [5.] Most recent kernel version which did not have the bug:
> > 2.6.29
> > 
> > [X.] Other notes, patches, fixes, workarounds:
> > 
> > patch which should fix the issue(for 2.6.30-rc4):
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
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


