From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI / Battery: Return -ENODATA for unknown values in
 get_property()
Date: Sun, 17 Oct 2010 11:10:16 -0200
Message-ID: <20101017131016.GB13015@khazad-dum.debian.net>
References: <20101016141321.GA11054@sucs.org>
 <201010170105.33274.rjw@sisk.pl>
 <20101017051953.GA3430@khazad-dum.debian.net>
 <20101017095940.GA4077@sucs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45947 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754873Ab0JQNKT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Oct 2010 09:10:19 -0400
Content-Disposition: inline
In-Reply-To: <20101017095940.GA4077@sucs.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, David Zeuthen <davidz@redhat.com>, Richard Hughes <richard@hughsie.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 17 Oct 2010, Sitsofe Wheeler wrote:
> On Sun, Oct 17, 2010 at 03:19:53AM -0200, Henrique de Moraes Holschuh wrote:
> > On Sun, 17 Oct 2010, Rafael J. Wysocki wrote:
> > > In fact, the driver is supposed to return -ENODATA in that case, which will
> > > result in the read from /sys/class/power_supply/BAT0/current_now
> > > fail (I guess upower should be able to cope with that).
> >
> > ENODATA?  Shouldn't it be ENXIO?  There is no non-blocking data stream
> > involved in a sysfs attribute.
> 
> Using ENODATA and ENXIO appears to solve the problem (upower reports a
> rate of 0.0). However when plugging the battery in after previously only
> being on AC power none of the /sys/class/power_supply/BAT0/uevent:*
> files are created so upower never realises a battery has been plugged
> in. A further issue with ENXIO is is the following repeatedly appears in
> dmesg:

You might have broken firmware that does not issue a notify when a battery
is plugged.  But it has been a long time, I don't recall if the battery
driver handles hotplugging without the help of the dock/bay driver (it
should, AFAIK).

> power_supply BAT0: driver failed to report `current_now' property

And it keeps silent if it gets ENODATA?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
