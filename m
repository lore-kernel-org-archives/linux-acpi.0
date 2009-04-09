From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Thu, 9 Apr 2009 09:42:05 +0200
Message-ID: <200904090942.06310.trenn@suse.de>
References: <1238737778.3582.163.camel@localhost.localdomain> <200904081217.15667.trenn@suse.de> <1239239539.3635.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41526 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759698AbZDIHlb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Apr 2009 03:41:31 -0400
In-Reply-To: <1239239539.3635.46.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thursday 09 April 2009 03:12:19 am yakui_zhao wrote:
> On Wed, 2009-04-08 at 18:17 +0800, Thomas Renninger wrote:
> > Hi,
> >
> > We have these interfaces:
> >   - vendor specific implementation
> >     (mostly in drivers/platform/x86/vendor-laptop.c)
> >   - ACPI generic backlight only
> >   - Opregion (this is the KMS/i915 interface you are talking about
> >     or is there another abstraction?)
>
> IMO it is unnecessary to consider the Opregion as the interface. In fact
> it is only for the communication between the ACPI and graphics driver.
> We can send the request by using ACPI generic backlight and then the
> brightness is changed in the graphics driver.
>
> What you said is also OK.
> But I don't know whether this will make the problem complex.
> This issue I raised is related with that no backlight can be controlled
> by xrandr tool after using KMS.
>     For example: >http://bugs.freedesktop.org/show_bug.cgi?id=20963
Why should this get a i915 and not a native samsung-laptop driver?
Can someone come up with some example code how the backlight switching
implementation for this one would look like.
This is needed anyway and then it is much easier to think about how to make 
sure backlight drivers do not get double registered.

     Thomas
