From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 08/13] Thermal: Introduce fair_share thermal governor
Date: Tue, 21 Aug 2012 05:59:00 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591AA858@BGSMSX101.gar.corp.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-9-git-send-email-durgadoss.r@intel.com>
 <20120821053313.GY9833@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57480 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300Ab2HUF71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2012 01:59:27 -0400
In-Reply-To: <20120821053313.GY9833@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hi Eduardo,

> > +static long get_target_state(struct thermal_zone_device *tz,
> > +		struct thermal_cooling_device *cdev, int weight, int level)
> > +{
> > +	unsigned long max_state;
> > +
> > +	cdev->ops->get_max_state(cdev, &max_state);
> > +
> > +	return (long)(weight * level * max_state) / (100 * tz->trips);
> > +}
> > +
> > +static void thermal_cdev_update(struct thermal_cooling_device *cdev)
> > +{
> > +	struct thermal_instance *instance;
> > +	unsigned long target = 0;
> > +
> > +	mutex_lock(&cdev->lock);
> > +
> > +	/* Make sure cdev enters the deepest cooling state */
> > +	list_for_each_entry(instance, &cdev->thermal_instances,
> cdev_node) {
> > +		if (instance->target > target)
> > +			target = instance->target;
> > +	}
> > +
> > +	mutex_unlock(&cdev->lock);
> > +
> > +	cdev->ops->set_cur_state(cdev, target);
> > +}
> 
> I believe Rui has already provided an arbitrator, can we reuse it here as well?

I thought about this. I was of the opinion a governor can choose to do arbitration
in its own specific way. For example, The fair_share does not check 'cdev->updated'
value whenever it tries to update the state of a cooling device.

Thanks,
Durga
