From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Wed, 17 Jun 2015 14:42:40 +0200
Message-ID: <1623864.KkKcV5nVxn@vostro.rjw.lan>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com> <CAL1RGDV16N_TngC8gN9ZF9TR-oOu+QkhXp=7rwcM4E_X12BvQw@mail.gmail.com> <2054960.9BJU2lQTPg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53080 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752881AbbFQMQm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2015 08:16:42 -0400
In-Reply-To: <2054960.9BJU2lQTPg@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Tuesday, June 16, 2015 01:00:13 AM Rafael J. Wysocki wrote:
> On Monday, June 15, 2015 07:56:05 AM Roland Dreier wrote:
> > On Sat, Jun 13, 2015 at 9:56 AM, Roland Dreier <roland@purestorage.com> wrote:
> > > Below is a more sophisticated, so to speak, version of it with a changelog and
> > > all.  It works for me, but more testing would be much appreciated.
> > 
> > Yes, the patch works as expected:
> > 
> > Tested-by: Roland Dreier <roland@purestorage.com>
> 
> Awesome, thanks a lot for the confirmation!

During the final review of the patch I noticed that it could be simplified
by dropping the acpi_add_region_after() routine and calling acpi_add_region()
directly instead of it.

I'll send an updated patch to you later today.

Thanks,
Rafael

