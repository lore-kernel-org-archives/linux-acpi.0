From: Andreas Mohr <andi@lisas.de>
Subject: Re: [git pull?] clocksource: ACPI pmtmr bugfixes [Was: Re: ACPI
	PM-Timer on K6-3 SiS5591: Houston...]
Date: Mon, 18 Aug 2008 22:00:17 +0200
Message-ID: <20080818200017.GA11247@rhlx01.hs-esslingen.de>
References: <20080810101730.GA10024@rhlx01.hs-esslingen.de> <20080810162920.GA9860@comet.dominikbrodowski.net> <20080810190759.GA1879@rhlx01.hs-esslingen.de> <20080818190325.GA12581@comet.dominikbrodowski.net> <20080818121924.6b61f7af.akpm@linux-foundation.org> <20080818193517.GA22097@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:55333 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYHRUAU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2008 16:00:20 -0400
Content-Disposition: inline
In-Reply-To: <20080818193517.GA22097@isilmar.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, johnstul@us.ibm.com, hirofumi@mail

Hi,

On Mon, Aug 18, 2008 at 09:35:17PM +0200, Dominik Brodowski wrote:
> Hi Andrew,
> 
> On Mon, Aug 18, 2008 at 12:19:24PM -0700, Andrew Morton wrote:
> > :     acpi_pm.c: check for monotonicity
> > :     
> > :     Expand the check for monotonicity by doing ten tests instead of one.
> > 
> > Why?
> 
> Indeed: http://lkml.org/lkml/2008/8/10/77 -- quote:
> "Result: catastrophic timer behaviour (a large backwards skip is possible),"
> 
> The current check for monotonicity is way too weak. And at least on one
> system out there PMTMR is unuseable, but the current check fails.

Just want to say thank you for promptly following up on this issue!

I wanted to test your 2nd patch (improved init), but was unable to do so
(currently too busy due to large changes, plus distance to production system,
downtime NOT appreciated ;).

Andreas Mohr
