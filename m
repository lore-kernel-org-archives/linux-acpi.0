From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: do not use kfifo for
 storing hotkey scancodes
Date: Tue, 27 Jun 2017 21:46:47 +0930
Message-ID: <20170627121647.GA28877@marvin.atrad.com.au>
References: <20170616044058.30443-1-kernel@kempniu.pl>
 <20170616044058.30443-2-kernel@kempniu.pl>
 <20170621181543.GB25900@fury>
 <40512901.HXkrFCdsVg@aspire.rjw.lan>
 <20170627000718.GA11146@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:60526 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdF0MSE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2017 08:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20170627000718.GA11146@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Micha?? K??pie?? <kernel@kempniu.pl>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 26, 2017 at 05:07:18PM -0700, Darren Hart wrote:
> On Sat, Jun 24, 2017 at 02:25:46AM +0200, Rafael Wysocki wrote:
> > > Rafael, the above rationale appears sound to me. Do you have any concerns?
> > 
> > I actually do.
> > 
> > While this is the case today, making the driver code depend on it in a hard way
> > sort of makes it difficult to change in the future if need be.
> 
> OK, if we aren't guaranteed for this to run on CPU 0 in the future, and
> this will be annoying to debug if it does changes, let's skip the kfifo
> change.
> 
> I have removed this patch, and fixed up the merge conflicts of the
> remaining 6 patches here:
> 
> http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/fujitsu
> 
> Michal / Jonathan, would you please review and let me know if this is what
> you would have done / approve the rebase?

The rebase looks reasonable to me.

Regards
  jonathan
