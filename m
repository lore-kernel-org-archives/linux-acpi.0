From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 0/4] x86: pmc_atom: Add Cherrytrail support
Date: Tue, 31 Mar 2015 12:59:21 +0200
Message-ID: <20150331105921.GB25180@gmail.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1424695552.14897.7.camel@linux.intel.com>
 <1427720699.14897.448.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35102 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbCaK7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2015 06:59:25 -0400
Content-Disposition: inline
In-Reply-To: <1427720699.14897.448.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>


* Shevchenko, Andriy <andriy.shevchenko@intel.com> wrote:

> On Mon, 2015-02-23 at 14:45 +0200, Andy Shevchenko wrote:
> > On Tue, 2015-01-20 at 23:49 +0200, Andy Shevchenko wrote:
> > > This is the reworked patch series which had been sent earlier [1] to support
> > > Intel CherryTrail SoC.
> > > 
> > > The patches were tested on both BayTrail and CherryTrail SoCs.
> > > 
> > > [1] https://patchwork.kernel.org/patch/5235891/
> > 
> > Aubrey, is everything is clear for you now? Can I send v3 with your
> > Ack's?
> 
> So, what is the status of the review then? Do I have anything to
> improve / comment?

So the last review pass pointed out a few minor problems (and also 
generated a few acks), please propagate those into the series and 
resend the latestest so I can have a fresh look.

Thanks,

	Ingo
