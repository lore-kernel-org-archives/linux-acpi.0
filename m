From: "Qi Yong" <qiiyoong@gmail.com>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Date: Wed, 17 Oct 2007 10:35:58 +0800
Message-ID: <2cd57c900710161935l2121bffex78475ca33f0574ca@mail.gmail.com>
References: <200611011323.14830.rjw@sisk.pl> <200705111121.51704.rjw@sisk.pl>
	 <alpine.LFD.0.98.0705110912290.3986@woody.linux-foundation.org>
	 <200705112208.53971.rjw@sisk.pl>
	 <alpine.LFD.0.98.0705111550540.3986@woody.linux-foundation.org>
	 <20070514075045.GA10238@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:42202 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758291AbXJQCf7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Oct 2007 22:35:59 -0400
Received: by py-out-1112.google.com with SMTP id u77so4055739pyb
        for <linux-acpi@vger.kernel.org>; Tue, 16 Oct 2007 19:35:58 -0700 (PDT)
In-Reply-To: <20070514075045.GA10238@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org

On 14/05/2007, Stefan Seyfried <seife@suse.de> wrote:
> On Fri, May 11, 2007 at 03:51:38PM -0700, Linus Torvalds wrote:
> >
> >
> > On Fri, 11 May 2007, Rafael J. Wysocki wrote:
> > >
> > > Just to clarify, the change in question isn't new.  It was introduced by the
> > > commit 9185cfa92507d07ac787bc73d06c42222eec7239 before 2.6.20, at Seife's
> > > request and with Pavel's acceptance.
> >
> > Ok, if it's that old, we migt as leave it in. Clearly there weren't many
> > regressions, and this isn't a case of other monsters lurking behind a lack
> > of testers.
>
> I pushed for this since on ACPI machines, "platform" is the right thing to do,
> and i still think it will only break on machines that have a broken ACPI BIOS.
> (Are there machines with broken ACPI BIOS around? ;-)
>
> Your additional "fall back to shutdown if !(ops)"-fix looks very sane,
> however, and is definitely a good idea.

The key point is "fall back to shutdown _only_ if !ops, otherwise
don't touch hibernation_mode". And that solves my problem.
-- 
Qi Yong
