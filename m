From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Fan not working after hibernate but ok after s2ram?
Date: Sat, 13 Oct 2007 12:06:34 +0200
Message-ID: <200710131206.34890.rjw@sisk.pl>
References: <1192224624.7038.9.camel@rukbat> <200710130007.34842.rjw@sisk.pl> <470FF758.40106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51321 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbXJMJux (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 05:50:53 -0400
In-Reply-To: <470FF758.40106@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Romano Giannetti <romanol@upcomillas.es>, suspend-devel@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday, 13 October 2007 00:38, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > Greetings,
> > 
> > On Friday, 12 October 2007 23:30, Romano Giannetti wrote:
> >> Hi,
> >>
> >> 	I have a strange problem. I am running 2.6.23 on a toshiba satellite
> >> 2.6.23, I use s2ram to suspend and echo disk > ... to hibernate. System
> >> is ubuntu Feisty.
> >>
> >> 	Now, both s2ram -f -p -m and hibernte works ok, but after resuming from
> >> hibernation, the fan of the laptop seems never to start again (it is ok
> >> after resuming from s2ram). I rebooted the system now (it arrived at 80
> >> celsius without starting the fan, normally it starts at 60) because I do
> >> not want to have a fried laptop...
> > 
> > Sure.
> > 
> >> 	Any hints? I tried to rmmod/insmod again fan.ko but it didn't help.
> There is 3 patch series in linux-acpi mail list, which might be related:
> [PATCH 1/3] ACPI: power: don't cache power resource state
> [PATCH 2/3] ACPI: Fan: fan device does not need own structure
> [PATCH 3/3] ACPI: Fan: Drop force_power_state acpi_device option

Do they apply on top of vanilla 2.6.23?
