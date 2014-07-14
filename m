From: Julian Wollrath <jwollrath@web.de>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Mon, 14 Jul 2014 20:34:22 +0200
Message-ID: <20140714203422.171a3e58@saldaea>
References: <20140712180636.698e2e4c@saldaea>
	<20140712182452.19ef6a91@saldaea>
	<100384914.3msa0DXJgJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:62134 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbaGNSe2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 14:34:28 -0400
In-Reply-To: <100384914.3msa0DXJgJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

Am Mon, 14 Jul 2014 20:21:19 +0200
schrieb "Rafael J. Wysocki" <rjw@rjwysocki.net>:

> On Saturday, July 12, 2014 06:24:52 PM Julian Wollrath wrote:
> > Hi,
> > 
> > > changing the brightness on my Thinkpad X230 with Intel HD4000
> > > graphics, stopped working after commit 886129a8eebe (ACPI / video:
> > > change acpi-video brightness_switch_enabled default to 0).
> > > Changing it back to 1, fixes the problem, if "acpi_osi=!Windows
> > > 2012" is also set. Before that commit just setting
> > > "acpi_osi=!Windows 2012" was enough to get changing the
> > > brightness working.
> >
> > small correction: It setting "acpi_osi=!Windows 2012" does only help
> > when using a kernel with commit 886129a8eebe as HEAD, with v3.16-rc4
> > setting video.brightness_switch_enabled=1 and acpi_osi=!Windows
> > 2012 or just one of them, does not make changing the brightness
> > work again.
> 
> And reverting commit 751109aad583 (ACPI / video: Change the default
> for video.use_native_backlight to 1) make that last problem go away,
> right?
> 
> We are going to rever commit 886129a8eebe for other reasons, so can
> you please revert it from 3.16-rc5 on your system and report back?
Yes, with both 751109aad583 and 886129a8eebe reverted, changing the
brightness works again.

Cheers,
Julian

> 
> Rafael
> 

