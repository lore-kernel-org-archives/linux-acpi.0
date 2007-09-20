From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Thu, 20 Sep 2007 18:33:38 +0200
Message-ID: <200709201833.38765.elendil@planet.nl>
References: <200709192014.08443.elendil@planet.nl> <20070920105312.GC12157@atrey.karlin.mff.cuni.cz> <200709201437.56431.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml13.kpnxchange.com ([213.75.38.113]:3125 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756210AbXITQdl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 12:33:41 -0400
In-Reply-To: <200709201437.56431.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 20 September 2007, Frans Pop wrote:
> On Thursday 20 September 2007, you wrote:
> > > When compared with 2.6.22-4, dmesg no longer lists S4 and S5 as
> > > supported for my Toshiba Satellite A40 laptop (Mobile Intel Pentium
> > > 4, 2.8GHz).
> > >
> > > -Linux version 2.6.22-2-686 (Debian 2.6.22-4) (waldi@debian.org) ...
> > > +Linux version 2.6.23-rc6 (root@faramir) ...
> > >  [...]
> > > -ACPI: (supports S0 S3 S4 S5)
> > > +ACPI: (supports S0 S3)
> >
> > Unexpected, and potentially pretty serious. Something went wrong with
> > ACPI. Can you try to narrow down when it started happening?
>
> rc1 still had all 4 levels. I'll run a bisect between rc1 and rc6.

I've bisected it down to this trio of changes:
- b0cb1a19d05b8ea8 Replace CONFIG_SOFTWARE_SUSPEND with CONFIG_HIBERNATION
- 296699de6bdc7171 Introduce CONFIG_SUSPEND for suspend-to-Ram and standby
- 673d5b43daa00b42 ACPI: restore CONFIG_ACPI_SLEEP

The actual change is probably in the second of those.

I've seen the comment that the change may just be cosmetic, but I'll leave 
it to others to confirm that (and if so, judge if it is desirable or not).

Cheers,
Frans Pop
