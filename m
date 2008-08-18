From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [git pull?] clocksource: ACPI pmtmr bugfixes [Was: Re: ACPI
	PM-Timer on K6-3 SiS5591: Houston...]
Date: Mon, 18 Aug 2008 22:09:16 +0200
Message-ID: <20080818200916.GA18209@comet.dominikbrodowski.net>
References: <20080818121924.6b61f7af.akpm@linux-foundation.org> <20080818193517.GA22097@isilmar.linta.de> <20080818200017.GA11247@rhlx01.hs-esslingen.de> <20080810101730.GA10024@rhlx01.hs-esslingen.de> <20080810162920.GA9860@comet.dominikbrodowski.net> <20080810190759.GA1879@rhlx01.hs-esslingen.de> <20080818190325.GA12581@comet.dominikbrodowski.net> <20080818121924.6b61f7af.akpm@linux-foundation.org> <20080818193517.GA22097@isilmar.linta.de> <20080818124755.162f24d1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:60662 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752762AbYHRULZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Aug 2008 16:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20080818200017.GA11247@rhlx01.hs-esslingen.de> <20080818124755.162f24d1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, johnstul@us.ibm.com, hirofumi@mail.parknet.co.jp, alan@lxorguk.ukuu.org.uk, arjan@infradead.org

Hi,

> Could I trouble you to resend them as plain-old-patches, with full
> changelogs along with your thoughts about the suitablity for
> 2.6.2[5678].x please?

patches will be sent as replies to this message. Thanks for taking care of
this; I should have written more meaningful texts. Also, I failed to
remember the second patch hasn't been tested yet ..

On Mon, Aug 18, 2008 at 10:00:17PM +0200, Andreas Mohr wrote:
> I wanted to test your 2nd patch (improved init), but was unable to do so
> (currently too busy due to large changes, plus distance to production system,
> downtime NOT appreciated ;).

.. but still I think this is stuff for 2.6.27; not (yet) suitable for 2.6.26
and 2.6.25 based on the -stable rules.

Best,
	Dominik
