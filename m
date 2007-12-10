From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Mon, 10 Dec 2007 11:20:15 +0900
Message-ID: <475CA25F.5000103@gmail.com>
References: <fa.qQhD8aJpiTOFaZqjRYwoaG7YT1c@ifi.uio.no> <fa.yaP86AixGhz5Q7eXSu04pIQp6ho@ifi.uio.no> <fa.c3k8VKWAx4HIo9zXWbL5Ek0oSBw@ifi.uio.no> <fa.C8ACnOhs8bXB++vmugf5F34JcJg@ifi.uio.no> <fa.5o6E6S0UWnARbQPxLe30TvLQIiY@ifi.uio.no> <475AE150.9050306@shaw.ca> <20071209213642.GA27096@rhlx01.hs-esslingen.de> <20071210000429.GA3916@rhlx01.hs-esslingen.de> <20071210004959.GA23280@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20071210004959.GA23280@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andreas Mohr wrote:
> As such one can conclude that this BIOS is rather very confused when being called for _GTM on an entirely
> unused controller port. And this is either because the BIOS is dumb or because ACPI doesn't really
> expect anyone to call _GTM on an unused physical port. I'd bet on the latter...
> (however I haven't found ACPI 3.0b explicitly mentioning this somewhere yet)

Thanks a lot for finding this out.  One of the two reports in bug 9320
seems to be the same problem although the other doesn't seem to be.  So,
it seems we'll have to check that both primary and secondary slots are
empty and skip _GTM if so.  :-(

Also, right, there's no need to fail suspend on _GTM failure whatever
the error is.  That was me being anal again.  Will incorporate both into
the ACPI fixes patchset.

Thanks.

-- 
tejun
