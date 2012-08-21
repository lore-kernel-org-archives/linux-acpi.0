From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 08/13] Thermal: Introduce fair_share thermal governor
Date: Tue, 21 Aug 2012 17:16:03 +0300
Message-ID: <20120821141508.GA5030@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-9-git-send-email-durgadoss.r@intel.com>
 <20120821053313.GY9833@besouro>
 <4D68720C2E767A4AA6A8796D42C8EB591AA858@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:57914 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab2HUOQU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 10:16:20 -0400
Received: by obhx4 with SMTP id x4so13086150obh.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Aug 2012 07:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AA858@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

hello,

On Tue, Aug 21, 2012 at 05:59:00AM +0000, R, Durgadoss wrote:
> Hi Eduardo,
> 
> > > +static long get_target_state(struct thermal_zone_device *tz,
> > > +		struct thermal_cooling_device *cdev, int weight, int level)
> > > +{
> > > +	unsigned long max_state;
> > > +
> > > +	cdev->ops->get_max_state(cdev, &max_state);
> > > +
> > > +	return (long)(weight * level * max_state) / (100 * tz->trips);
> > > +}
> > > +
> > > +static void thermal_cdev_update(struct thermal_cooling_device *cdev)
> > > +{
> > > +	struct thermal_instance *instance;
> > > +	unsigned long target = 0;
> > > +
> > > +	mutex_lock(&cdev->lock);
> > > +
> > > +	/* Make sure cdev enters the deepest cooling state */
> > > +	list_for_each_entry(instance, &cdev->thermal_instances,
> > cdev_node) {
> > > +		if (instance->target > target)
> > > +			target = instance->target;
> > > +	}
> > > +
> > > +	mutex_unlock(&cdev->lock);
> > > +
> > > +	cdev->ops->set_cur_state(cdev, target);
> > > +}
> > 
> > I believe Rui has already provided an arbitrator, can we reuse it here as well?
> 
> I thought about this. I was of the opinion a governor can choose to do arbitration
> in its own specific way. For example, The fair_share does not check 'cdev->updated'
> value whenever it tries to update the state of a cooling device.

I see. the arbitration starts to get more and more complex. not to talk about constraints
coming from performance domain and not thermal.

I'd still try to find a central point for doing the arbitration, this way we grow the code
in a scalable way...

> 
> Thanks,
> Durga
