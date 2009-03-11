From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI video: support _BQC/_BCL/_BCM methods
	that use index values
Date: Wed, 11 Mar 2009 09:17:52 +0800
Message-ID: <1236734272.2820.137.camel@rzhang-dt>
References: <1236672214.2820.123.camel@rzhang-dt>
	 <20090310171000.GC2527@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5669 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbZCKBQ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 21:16:58 -0400
In-Reply-To: <20090310171000.GC2527@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, 2009-03-11 at 01:10 +0800, Matthew Garrett wrote:
> On Tue, Mar 10, 2009 at 04:03:34PM +0800, Zhang Rui wrote:
> >  		if (level == device->brightness->levels[state]) {
> > -			device->backlight->props.brightness = state - 2;
> > +			if (device->backlight)
> > +				device->backlight->props.brightness = state - 2;
> 
> This hunk doesn't seem obviously related?
I need to set the backlight in acpi_video_init_brightness, before video
backlight device being registered.

> 
> > +			 * For now, we don't support the _BCL like this:
> > +			 * 16, 15, 0, 1, 2, 3, ..., 14, 15, 16
> > +			 * because we may mess up the index returned by _BQC.
> > +			 * Plus: we have not got a box like this.
> 
> Do we have any bugs that suggest there are boxes like this?
> 
No, we don't have one.
So we should remove this check unless we've one _BCL like this?

thanks,
rui


