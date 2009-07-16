From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Intel-gfx] [PATCH 2/4] drm/i915: force mode set at lid open
 time
Date: Thu, 16 Jul 2009 09:30:45 -0700
Message-ID: <20090716093045.3cd7123d@jbarnes-g45>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	<1247695886-18432-3-git-send-email-jbarnes@virtuousgeek.org>
	<1247708173.4113.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-24.bluehost.com ([69.89.21.19]:38149 "HELO
	outbound-mail-24.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932569AbZGPQas (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 12:30:48 -0400
In-Reply-To: <1247708173.4113.35.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 16 Jul 2009 09:36:13 +0800
ykzhao <yakui.zhao@intel.com> wrote:

> On Thu, 2009-07-16 at 06:11 +0800, Jesse Barnes wrote:
> > Some laptop platforms will disable pipes and/or planes at lid close
> > time and not restore them when the lid is opened again.  So catch
> > the lid event, and if the lid was opened, force a mode restore.
> Why is it necessary to force a mode restore when the LID is reopened?
> Do you mean that the pipes/planes are disabled automatically by BIOS
> when the LID is closed? 

Yes, maybe I need to make that clearer in the changelog.

> If so, maybe it will be better that this feature is limited to some
> boxes. It is unnecessary to add this feature for all the laptops.

The downside of doing that is that we'll always be playing catch up,
adding quirks for machines as problems are discovered, as opposed to
everything "just working" out of the box.  A whitelist might be better,
but really forcing a mode set at open isn't expensive, and with some
care in our mode setting routines, need not flicker at all.

> Is it enough to mark the LVDS as disconnected/connected according to
> the LID status? And this is done by user-space tool.

Not sure what you mean here...

> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 39b393d..5873865 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -86,6 +86,7 @@ config DRM_I915
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> >  	select FB
> > +	select ACPI_BUTTON
> How about 
>   +	  select ACPI_BUTTON if ACPI

Yeah I saw your other comments too about non-ACPI configs.  I have a
hard time caring about them though; so much depends on ACPI these days
that disabling it is just a bad idea.  But I guess it's not too much
trouble to make this work w/o.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
