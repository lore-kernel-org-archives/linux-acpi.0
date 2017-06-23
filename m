From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Fri, 23 Jun 2017 09:44:58 +0930
Message-ID: <20170623001458.GE24368@marvin.atrad.com.au>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
 <20170621181543.GB25900@fury>
 <20170621235021.GA32131@marvin.atrad.com.au>
 <20170622024413.GE25900@fury>
 <20170622030120.GF32131@marvin.atrad.com.au>
 <20170622204619.GB4194@kmp-mobile.hq.kempniu.pl>
 <20170622235809.GB27213@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:56568 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWAP6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2017 20:15:58 -0400
Content-Disposition: inline
In-Reply-To: <20170622235809.GB27213@fury>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Micha?? K??pie?? <kernel@kempniu.pl>, Rafael Wysocki <rjw@rjwysocki.net>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 22, 2017 at 04:58:09PM -0700, Darren Hart wrote:
> On Thu, Jun 22, 2017 at 10:46:19PM +0200, Micha?? K??pie?? wrote:
> > > The events seen by userspace with the original code would be "A-press",
> > > "B-press", "A-release", "B-release".  With the revised code the order of the
> > > release events would be reversed compared to the previous behaviour.  That
> > > is, unless I've misunderstood how sparse_keymap_report_event() works.
> > 
> > All you wrote above is correct and this patch does change the order of
> > release events sent to userspace when multiple hotkeys are pressed
> > simultaneously.  The question is: is it relevant for any practical
> > scenario?
> > 
> > Anyway, I find this matter to be of secondary importance.  The primary
> > objective of this patch is to get rid of the kfifo.  If anyone has
> > strong feelings about the change in event ordering, I will be happy to
> > revert to FIFO in v2.
> 
> This all looks reasonable to me, I don't see anything requiring a respin.

I agree it is of seconary importance.  To me, using LIFO release order is
counter-intuitive, but it's the sort of question that if put to 100 people
you'll get a 50/50 split of opinions.

Especially since the whole "multiple buttons held at once" scenario is
rather unusual we can go with switching the order if others don't see a
problem with the behavioural change.

Regards
  jonathan
