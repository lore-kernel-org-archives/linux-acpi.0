From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH] ACPI SBS: Fix intermittent hangs on Apple Macbook
Date: Wed, 29 Apr 2015 21:13:14 +0100
Message-ID: <20150429201314.GA25904@localhost>
References: <20150424012530.GA16763@localhost>
 <4435249.leKkNHm9IZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36244 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbD2UNT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2015 16:13:19 -0400
Received: by wizk4 with SMTP id k4so194112098wiz.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2015 13:13:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4435249.leKkNHm9IZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, Apr 29, 2015 at 02:37:57AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 24, 2015 02:25:30 AM Chris Bainbridge wrote:
> > Commit 7bc5a2b exposed the SBS on Apple hardware, resulting in
> > intermittent hangs of several minutes on boot, and failure to detect or
> > report the battery. We fix this two ways:
> > 
> >  - SMBUS hang should not hang the whole system. Respect the specified
> >    timeout by busy waiting instead of sleeping.
> >    This fix is already used on MSI hardware.
> >  
> >  - Stop the SBS from hanging in the first place by introducing a 5us
> >    delay before each SMBUS transaction. This fix is the result of
> >    experimentation. This particular delay was found to completely fix
> >    the problem on an Ivybridge Macbook Pro 13. Hangs were observed with
> >    3us delay but never with 5us.
> > 
> > Also, pr_warn if SBS communication fails instead of silently ignoring.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=94651
> > Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> 
> Well, this looks like two patches combined to me.  Are the quirks actually
> related except that they are both needed to fix the problem?
> 

Not related, so should have been separate patches. One fixes the problem
of causing the SBS controller to stop responding, which results in a
hang.  The other fixes the problem of the resulting hang - but now I'm
thinking we don't need this, since it should never happen unless we hang
the SBS. I'll resend just the first fix as a new patch.

> 
> Do we really need this for all Apple hardware?
> 

Just MacBooks. I don't know which ones - the hang has been reported on:

    MacBookAir6,1 hsw 11" 2013
    MacBookPro10,2 ivb 13" 2012/2013
    MacBookPro11,1 hsw 15" 2013/2014

But it could affect earlier or later models too. The next patch will
limit this to MacBooks only - I have no way to narrow down the list of
affected hardware further, but since the fix only adds a 5us delay to
each SBS read it shouldn't cause any problems on unaffected hardware.

Thanks for the review.
