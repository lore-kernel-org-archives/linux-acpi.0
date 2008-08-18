From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git pull?] clocksource: ACPI pmtmr bugfixes [Was: Re: ACPI
 PM-Timer on K6-3 SiS5591: Houston...]
Date: Mon, 18 Aug 2008 13:25:46 -0700
Message-ID: <20080818132546.0dfcbf77.akpm@linux-foundation.org>
References: <20080818121924.6b61f7af.akpm@linux-foundation.org>
	<20080818193517.GA22097@isilmar.linta.de>
	<20080818200017.GA11247@rhlx01.hs-esslingen.de>
	<20080810101730.GA10024@rhlx01.hs-esslingen.de>
	<20080810162920.GA9860@comet.dominikbrodowski.net>
	<20080810190759.GA1879@rhlx01.hs-esslingen.de>
	<20080818190325.GA12581@comet.dominikbrodowski.net>
	<20080818121924.6b61f7af.akpm@linux-foundation.org>
	<20080818193517.GA22097@isilmar.linta.de>
	<20080818124755.162f24d1.akpm@linux-foundation.org>
	<20080818200916.GA18209@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37645 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044AbYHRU0w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Aug 2008 16:26:52 -0400
In-Reply-To: <20080818200916.GA18209@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: andi@lisas.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, johnstul@us.ibm.com, hirofumi@mail.parknet.co.jp, alan@lxorguk.ukuu.org.uk, arjan@infradead.org, stable@kernel.org

On Mon, 18 Aug 2008 22:09:16 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Hi,
> 
> > Could I trouble you to resend them as plain-old-patches, with full
> > changelogs along with your thoughts about the suitablity for
> > 2.6.2[5678].x please?
> 
> patches will be sent as replies to this message. Thanks for taking care of
> this; I should have written more meaningful texts. Also, I failed to
> remember the second patch hasn't been tested yet ..
> 
> On Mon, Aug 18, 2008 at 10:00:17PM +0200, Andreas Mohr wrote:
> > I wanted to test your 2nd patch (improved init), but was unable to do so
> > (currently too busy due to large changes, plus distance to production system,
> > downtime NOT appreciated ;).
> 
> .. but still I think this is stuff for 2.6.27; not (yet) suitable for 2.6.26
> and 2.6.25 based on the -stable rules.
> 

(cc stable)

OK, thanks.  I tagged these as

Cc: <stable@kernel.org>         [2.6.26.x, 2.6.25.x but not immediately]

which is a bit rubbery.  What do you think are the criteria for
deciding when these are ready for the backports?  Something like "after
2.6.28-rc1 if nothing blew up"?


