From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 2/4] RFC Thermal: Introduce fair-share thermal governor
Date: Tue, 12 Jun 2012 14:49:46 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5913619B@BGSMSX101.gar.corp.intel.com>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-3-git-send-email-durgadoss.r@intel.com>
 <20120612125508.GC8724@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10737 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab2FLOtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jun 2012 10:49:51 -0400
In-Reply-To: <20120612125508.GC8724@besouro>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>

Hi Eduardo,

> > +	int cur_trip_level = get_trip_level(tz);
> > +
> > +	/* Do not throttle:
> > +	 * if there are no parameters defined for this zone
> > +	 * if current trip level is 0 (for performance reasons)
> > +	 */
> 
> Nip: I suppose the kernel coding for comments should be:

Missed it here :-) Will fix..
Surprised checkpatch did not complain !!

> 
> I think, while merging your work with Rui's, you need to take care of the
> cooling state range bound to the trip point..

Yes Sure. I have not started looking into them yet.
I will Sync up before sending my next set.

Thanks,
Durga
