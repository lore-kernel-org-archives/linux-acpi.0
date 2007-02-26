From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Mon, 26 Feb 2007 17:25:39 +0800
Message-ID: <1172481939.11100.11.camel@localhost.localdomain>
References: <200702071418.51058.lenb@kernel.org>
	 <20070209230928.GD3949@ucw.cz> <200702092327.04237.lenb@kernel.org>
	 <20070222155357.GA4692@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28700 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbXBZJ0q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Feb 2007 04:26:46 -0500
In-Reply-To: <20070222155357.GA4692@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 2007-02-22 at 15:53 +0000, Pavel Machek wrote: 
> Hi!
> 
> > > > the old /proc/acpi/ interfaces with cleaner interfaces in sysfs --
> > > > non-ACPI-specific generic ones whenever possible.  This effort
> > > > is not complete, but it has been in -mm for a long time and
> > > > I believe that it is time to push it upstream to benefit
> > > > from broader exposure and testing.
> > > 
> > > Does it still include completely broken alarm interface? Can't find it
> > > in changelogs, so hopefully not.
> > 
> > No. See discussion on linux-acpi.
> > David Brownell's RTC driver will provide the new RTC interface in sysfs.
> > /proc/acpi/alarm will go away when the rest of /proc/acpi goes away.
> 
> I guess I should say 'sorry for a flame'. I've seen a discussion
> (linux-pm or somewhere), but did not see the decision to drop the
> offending patch.
> 
Hi, Pavel,
Both the patches that duplicate "alarm" and "wakeup" attributes in sysfs
are dropped. "alarm" attribute can be replaced by the new RTC driver.
And the "wakeup" attribute are in the wish list now.
You can get more details from the original mail.

http://marc.theaimsgroup.com/?l=linux-acpi&m=116910315512529&w=2

Thanks,
Rui
