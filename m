From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [PATCH 2/4] drm/i915: force mode set at lid open
 time
Date: Fri, 17 Jul 2009 09:33:03 -0700
Message-ID: <20090717093303.6a77948e@jbarnes-g45>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	<1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
	<1247708173.4113.35.camel@localhost.localdomain>
	<20090716093045.3cd7123d@jbarnes-g45>
	<1247794481.4113.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-110.bluehost.com ([69.89.22.10]:39443 "HELO
	outbound-mail-110.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964908AbZGQQdI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Jul 2009 12:33:08 -0400
In-Reply-To: <1247794481.4113.67.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 17 Jul 2009 09:34:41 +0800
ykzhao <yakui.zhao@intel.com> wrote:
> > > Is it enough to mark the LVDS as disconnected/connected according
> > > to the LID status? And this is done by user-space tool.
> > 
> > Not sure what you mean here...
> What I said is that we can send the hotplug event to user space. And
> then the user space tool can set the mode for LVDS. 
>     Of course the LVDS status is marked as disconnected/connected in
> course of LVDS detection.

Ah yeah, I see what you mean.  But that won't work in the case where a
display manager isn't running; we want the console to come back too.

> > > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > > index 39b393d..5873865 100644
> > > > --- a/drivers/gpu/drm/Kconfig
> > > > +++ b/drivers/gpu/drm/Kconfig
> > > > @@ -86,6 +86,7 @@ config DRM_I915
> > > >  	select FB_CFB_COPYAREA
> > > >  	select FB_CFB_IMAGEBLIT
> > > >  	select FB
> > > > +	select ACPI_BUTTON
> > > How about 
> > >   +	  select ACPI_BUTTON if ACPI
> > 
> > Yeah I saw your other comments too about non-ACPI configs.  I have a
> > hard time caring about them though; so much depends on ACPI these
> > days that disabling it is just a bad idea.  But I guess it's not
> > too much trouble to make this work w/o.
> If someone disable the CONFIG_ACPI in kernel configuration, maybe it
> will fail in the kernel compilation.
> 
> Sometimes the box will be booted with ACPI disabled. In such case the
> LID device is not initialized. When we call the function of
> acpi_lid_open, we will access the uninitialized variable. It will be
> incorrect.
> 
> In fact it will be very easy to add this check.

Yep, I'll fix it.

-- 
Jesse Barnes, Intel Open Source Technology Center
