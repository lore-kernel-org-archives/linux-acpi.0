From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: ACPI PM-Timer on K6-3 SiS5591: Houston...
Date: Sun, 10 Aug 2008 09:40:38 -0700
Message-ID: <20080810094038.141480b4@infradead.org>
References: <20080810101730.GA10024@rhlx01.hs-esslingen.de>
	<20080810162920.GA9860@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49107 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYHJQkd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Aug 2008 12:40:33 -0400
In-Reply-To: <20080810162920.GA9860@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andreas Mohr <andi@lisas.de>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-acpi@vger.kernel.org

On Sun, 10 Aug 2008 18:29:20 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Hi Andreas,
> 
> On Sun, Aug 10, 2008 at 12:17:30PM +0200, Andreas Mohr wrote:
> > Result: catastrophic timer behaviour (a large backwards skip is
> > possible), even in case we do a triple-read workaround, due to a
> > floating bit at 0x0400 (possibly caused by underclocking from 400
> > to 150, but whatever...).
> 
> this isn't the bug which is handled by the
> read-three-times-workaround. Instead, that handels the following
> PIIX4 errata:
> 
>  * PIIX4 Errata:
>  *
>  * The power management timer may return improper results when read.
>  * Although the timer value settles properly after incrementing,
>  * while incrementing there is a 3 ns window every 69.8 ns where the
>  * timer value is indeterminate (a 4.2% chance that the data will be
>  * incorrect when read). As a result, the ACPI free running count up
>  * timer specification is violated due to erroneous reads.
> 
> > And my system does pass the bootup PM-Timer check quite often
> > despite this severe defect (2 in 4 bootups _did_ register my
> > defective acpi_pm clocksource).
> 
> No surprise there -- it is the first time I see such an error; and it
> might actually be a bug specific to your computer's motherboard. 
> 

if it's really only one board that's faulty... a dmi blacklist might be
appropriate.


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
