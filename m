From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 4/4] RFC Thermal: Platform layer changes to provide
 thermal data
Date: Tue, 12 Jun 2012 14:40:37 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59136173@BGSMSX101.gar.corp.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-5-git-send-email-durgadoss.r@intel.com>
 <20120612130233.GE8724@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27940 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab2FLOkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 10:40:40 -0400
In-Reply-To: <20120612130233.GE8724@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

Hi Eduardo,

> 
> Hello Rui,

I hope you meant Durga :-)

> 
> On Mon, Jun 11, 2012 at 11:09:34PM +0530, Durgadoss R wrote:
> > This patch shows how can we add platform specific thermal data
> > required by the enhanced thermal framework.
> > This is just an example patch, and _not_ for merge.
> 
> Nice! Thanks for sending an example. This makes things a lot easier.

Happy, that it is useful.
I initially thought of dropping it, but luckily did not :-)

[A big cut.]

> > +static int mrst_get_thermal_params(struct thermal_zone_device *tz)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MRST_THERMAL_ZONES; i++) {
> > +		if (!strcmp(tzp[i].thermal_zone_name, tz->type)) {
> > +			tz->tzp = &tzp[i];
> > +			return 0;
> > +		}
> > +	}
> 
> If you send the pdata while registering the zone, and store it in the zone data
> structures,
> you wont need to be iterating on all pdata array and matching strings.
> 

Even if we have this data coming while registering the zone, that platform
specific thermal driver has to fetch the data from a board specific file.
I understand that we can hard code things inside the platform thermal driver
file, but in most cases people use some standard thermal sensor chips
(for which drivers are available in Linux). So, these chips can be used on
different platforms, with different platform data.

So, I would prefer having this inside a platform specific file, and not hard code
inside any thermal driver.

> Besides, I suppose the pdata you are talking about it actually board specifics,
> right?

Yes. It is board specific, but as I mentioned above, the driver may be a generic one.

Thanks,
Durga
