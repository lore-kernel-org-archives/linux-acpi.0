From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in IO resource allocation
Date: Wed, 01 Jun 2016 22:20:46 +0200
Message-ID: <1704084.KTCCUKyIjI@vostro.rjw.lan>
References: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com> <CAJZ5v0jOg-oTDEZodhLHD5iz039kKP-UCQoB92nZ8=_qhSa-HA@mail.gmail.com> <CAL1RGDU+rMotA4XzBmnnS9GhZWu7v9LQ9NeL=jqVXtP40yfvYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46186 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750784AbcFAUQz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jun 2016 16:16:55 -0400
In-Reply-To: <CAL1RGDU+rMotA4XzBmnnS9GhZWu7v9LQ9NeL=jqVXtP40yfvYw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, June 01, 2016 10:08:59 AM Roland Dreier wrote:
> On Tue, May 31, 2016 at 3:31 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > It may not be called at all if _PTC is used on that system, for example.
> 
> Yes, that's exactly the case on my system.
> 
> So from my POV:
> 
> Tested-by: Roland Dreier <roland@purestorage.com>
> 
> Thanks!

OK, I'll queue it up, then.

