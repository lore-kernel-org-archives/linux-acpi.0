From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Wed, 15 Jul 2009 10:11:29 +0100
Message-ID: <1247649089.20241.5.camel@dax.rpnet.com>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
	 <1247574573.23871.8.camel@dax.rpnet.com>
	 <1247644518.26272.88.camel@rzhang-dt>
	 <1247646153.6248.3.camel@dax.rpnet.com>
	 <1247647105.26272.99.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dan.rpsys.net ([93.97.175.187]:53551 "EHLO dan.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZGOJPP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 05:15:15 -0400
In-Reply-To: <1247647105.26272.99.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "corentincj@iksaif.net" <corentincj@iksaif.net>

On Wed, 2009-07-15 at 16:38 +0800, Zhang Rui wrote: 
> On Wed, 2009-07-15 at 16:22 +0800, Richard Purdie wrote:
> > We don't have one that I'm aware of.
> > 
> > The first question is what information and configuration options are we
> > likely to have with ALS sensors? If its just a light level reading, the
> > input subsystem is ideally suited for sharing that. Is there
> > configuration we need to expose?
> > 
> For an ACPI ALS device, only these two are mandatory
> 1. the current ambient light illuminance.
> 2. A list of luminance mappings, including the "display luminance
> adjustment" and "ambient light illuminance", which can be used by OS to
> determine the ambient light policy.

So there are basically two values we're ever interested in at a given
point in time. The current ambient light reading and the corresponding
display luminance adjustment. Both of those could just be exposed as an
input device really?

> IMO, the ALS driver should just export these info to user space, and we
> can do the display backlight adjustment in user space,
> via /sys/class/backlight.

Agreed, userspace should be where policy is decided. Having a standalone
module which connected the two together with a "default" policy might be
acceptable too though? If userspace then wants to handle things it just
makes sure the module is not loaded.

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre

