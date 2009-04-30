From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between
 ACPI video driver and i915 driver
Date: Thu, 30 Apr 2009 13:23:26 -0700
Message-ID: <20090430132326.127e9fb8.akpm@linux-foundation.org>
References: <1239678275.5564.66.camel@localhost.localdomain>
	<20090415205656.GA32509@srcf.ucam.org>
	<alpine.LFD.2.00.0904231552550.15830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45056 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762016AbZD3U3X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2009 16:29:23 -0400
In-Reply-To: <alpine.LFD.2.00.0904231552550.15830@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: mjg59@srcf.ucam.org, yakui.zhao@intel.com, linux-acpi@vger.kernel.org, dri-devel@lists.sourceforge.net, David John <davidjon@xenontk.org>, We La <w.landgraf@yahoo.com>

(cc dri-devel)

On Thu, 23 Apr 2009 15:56:24 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> applied
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> On Wed, 15 Apr 2009, Matthew Garrett wrote:
> 
> > How about we just replace these with the following?
> > 
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 3a22eb9..cf7e7c2 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -71,6 +71,7 @@ config DRM_I915
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> >  	select FB
> > +	select ACPI_VIDEO if ACPI
> >  	tristate "i915 driver"
> >  	help
> >  	  Choose this option if you have a system that has Intel 830M, 845G,

You applied this a week ago, but it isn't in mainline or linux-next.
We La described it as fixing a regression and David John said

: Can you forward this patch to Linus?  This regression breaks quite a
: few configs where ACPI Video is compiled as a module and i915 is built
: in.  This should have been in stable, but I guess it's too late now.

So...  wazzup?
