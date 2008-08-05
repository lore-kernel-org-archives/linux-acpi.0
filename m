From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Tue, 5 Aug 2008 14:00:30 +0200
Message-ID: <20080805120030.GA10775@corsac.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <20080805000151.GJ24927@khazad-dum.debian.net> <1217915753.8381.9.camel@hidalgo> <200808051113.44533.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:53549 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758678AbYHEMAd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Aug 2008 08:00:33 -0400
Content-Disposition: inline
In-Reply-To: <200808051113.44533.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Tue, Aug 05, 2008 at 11:13:42AM +0200, Thomas Renninger wrote:
> On Tuesday 05 August 2008 07:55:53 Yves-Alexis Perez wrote:
> ...
> > Anyway, I wasn't yet able to test Matthew's patches, they're not yet in
> > drm-2.6/master.
> This should definitely be the next step.
> If this fails we should still try to dig there why it is not working.

How can I test (and maybe debug) your patches then?

> 
> I agree, that only if we heavily get stuck there it would make sense
> to look at thinkpad_acpi to enable/workaround backlight switching with
> IGD devices.

Hmhm, I assume that, under vista, IGD and Nvidia ones are managed the
same (as far as I understood it, and using acpi backlight management),
so I guess it would be a "last chance" solution?

Cheers,
-- 
Yves-Alexis
