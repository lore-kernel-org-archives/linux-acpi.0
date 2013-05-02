From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/4] Driver core: Add offline/online device operations
Date: Thu, 02 May 2013 17:23:26 -0600
Message-ID: <1367537006.16154.180.camel@misato.fc.hp.com>
References: <1576321.HU0tZ4cGWk@vostro.rjw.lan>
	 <1647668.odH0HuOGZ9@vostro.rjw.lan>
	 <1367536287.16154.171.camel@misato.fc.hp.com>
	 <4243991.h6yRePNTyt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:10391 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464Ab3EBXgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 May 2013 19:36:19 -0400
In-Reply-To: <4243991.h6yRePNTyt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, isimatu.yasuaki@jp.fujitsu.com, vasilis.liaskovitis@profitbricks.com, Len Brown <lenb@kernel.org>

On Fri, 2013-05-03 at 01:36 +0200, Rafael J. Wysocki wrote:
> On Thursday, May 02, 2013 05:11:27 PM Toshi Kani wrote:
> > On Thu, 2013-05-02 at 14:27 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 :
> > >  
> > > +static inline bool device_supports_offline(struct device *dev)
> > 
> > Since we renamed "offline" to "hotplug" for the lock interfaces, should
> > this function be renamed to device_supports_hotplug() as well?
> 
> Well, "offline" is more specific, as there may be devices that don't
> support offline/online, but support hotplug otherwise.  That's why I didn't
> change it.

I see.  That makes sense.

Thanks,
-Toshi

