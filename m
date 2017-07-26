From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / watchdog: Fix init failure with overlapping register regions
Date: Wed, 26 Jul 2017 20:57:32 +0200
Message-ID: <4709509.nbVYHvfDrb@aspire.rjw.lan>
References: <20170715214818.24979-1-ryan5544@gmail.com> <20170725093731.GE2369@lahna.fi.intel.com> <20170725131341.GU2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64672 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751365AbdGZTFc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 15:05:32 -0400
In-Reply-To: <20170725131341.GU2369@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Ryan Kennedy <ryan5544@gmail.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tuesday, July 25, 2017 04:13:41 PM Mika Westerberg wrote:
> On Tue, Jul 25, 2017 at 12:37:31PM +0300, Mika Westerberg wrote:
> > I wonder why we need to do this?
> > 
> > +                           if (res.start < rentry->res->start)
> > +                                   rentry->res->start = res.start;
> > +                           if (res.end > rentry->res->end)
> > +                                   rentry->res->end = res.end;
> > 
> > IIRC we don't use rentry for anything else when we go out of the loop.
> > Tuning those limits seems unnecessary.
> 
> OK, Ryan pointed out that the later code then uses the adjusted rentry
> so this is indeed needed.
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

OK, patch applied, thanks!

