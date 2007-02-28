From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: bugzilla.kernel.org bug 7988: Resume from RAM on Toshiba A100 fails
Date: Wed, 28 Feb 2007 01:20:45 +0100
Message-ID: <200702280120.46036.rjw@sisk.pl>
References: <8956d4ca0702210648v43f99a5el53f5a15b2b99a8d1@mail.gmail.com> <8956d4ca0702271604u39a734k408184477ade88f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38858 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbXB1ASg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Feb 2007 19:18:36 -0500
In-Reply-To: <8956d4ca0702271604u39a734k408184477ade88f0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mitch Davis <mjd-kernel-org@afork.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, 28 February 2007 01:04, Mitch Davis wrote:
> On 2/22/07, Mitch Davis <mjd-kernel-org@afork.com> wrote:
> > Hello,
> >
> > I was inspired by Matthew Garrett's talk at LCA to find out why my
> > Toshiba laptop doesn't resume after a suspend.  I did what I could to
> > diagnose it, and logged the problem here:
> >
> >  http://bugzilla.kernel.org/show_bug.cgi?id=7988
> 
> In the bug, Rafael J. Wysocki suggested:
> >
> > Can you try the latest -mm kernel (but please do not compile it with
> > CONFIG_PREEMPT set)?
> 
> I have now tried 2.6.20-mm2, and the result is exactly the same: The laptop
> suspends but never gets to first base on resume.
> 
> Please, any ideas?

No, sorry. :-(

I was hoping that the fix might go into -mm.

The hardware configuration of your system is very similar to one and the only
substantial difference I can see is

00:00.0 Host bridge: ATI Technologies Inc Unknown device 5a31 (rev 01)

but I haven't tried the STR yet.

Does your system suspend to disk?

Rafael
-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
