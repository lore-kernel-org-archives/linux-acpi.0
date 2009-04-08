From: Richard Purdie <rpurdie@linux.intel.com>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Wed, 08 Apr 2009 11:50:03 +0100
Message-ID: <1239187803.5339.13.camel@dax.rpnet.com>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090407073845.GA15635@srcf.ucam.org>
	 <1239152179.3635.8.camel@localhost.localdomain>
	 <200904081217.15667.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24059 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751399AbZDHKuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 06:50:08 -0400
In-Reply-To: <200904081217.15667.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: yakui_zhao <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2009-04-08 at 12:17 +0200, Thomas Renninger wrote:
> Matthew and Jesse are looking for following approach:
> Let all drivers try to register for the generic backlight interface.
> As we do not know which driver will get loaded first, you want to 
> detect whether another driver already registered the backlight
> interface and implement a priority to eventually let the newly
> loaded driver unregister the other driver's backlight device, notify
> this driver via a notifier chain and then register the own backlight
> interface (is that correct?).
> 
> Priority could look like:
> 1) vendor specific drivers
> 2) ACPI generic drivers
> 3) Graphics card's specific kernel drivers (IGD/Opregion and possibly
>    others)
> 3 has highest prio.
> 
> If I got that right, I do not like:
>   - the complexity that has to be added to the generic backlight
>     interface and each backlight driver.

I'm not arguing for or against any approach here but if we need to have
this priority handoff system, I'd like to see it as a wrapper around the
backlight class and the class itself is unlikely to need changes. The
wrapper would register one backlight device with the generic class and
then redirect the function calls as needed.

Cheers,

Richard

