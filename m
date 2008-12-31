From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Wed, 31 Dec 2008 09:22:20 +0800
Message-ID: <1230686540.4091.107.camel@yakui_zhao.sh.intel.com>
References: <1230088058.562.219.camel@rzhang-dt>
	 <1230633250.5328.8.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbYLaBMI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 20:12:08 -0500
In-Reply-To: <1230633250.5328.8.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 2008-12-30 at 18:34 +0800, Richard Purdie wrote:
> On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> > bd->props.brightness is a cached value.
> > the current code has some potential problems when poking the
> > backlight I/F.
> > 
> > For example,
> > 1. set the brightness level to 5 via sysfs I/F
> > 2. set the backlight to another level via the procfs,
> > 3. setting it back to 5 doesn't work because bd->props.brightness
> > is still 5.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=12249
> 
> The root of the problem here is that there are two interfaces
> controlling the same piece of hardware. Personally, I'd like to see the
> proc interfaces to backlights depreacated but we do need to make them
> work I guess. The real bug looks like the proc interface should update
> props.brightness for that hardware...
It is also ok that the props.brightness is also updated when the proc
interface is called. But in such case the "brightness" won't display the
user requested value. 

Sometimes the brightness will be changed by BIOS and there is no
notification event. In such case the props.brightness can't be updated.
If we want to update the brightness, the request will have no effect.

So IMO it will be more appropriate that brightness is always updated
when poking "brightness".

  
Thanks.
   Yakui    
> 
> Cheers,
> 
> Richard
> 

