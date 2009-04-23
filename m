From: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.30-rc2 soft lockups: ACPI?  clock source problem?
Date: Thu, 23 Apr 2009 12:10:27 -0700
Message-ID: <1240513827.7224.2.camel@localhost.localdomain>
References: <1240335038.11194.11.camel@nimitz>
	 <20090422204557.10c3cc37.akpm@linux-foundation.org>
	 <1240511508.10627.159.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:55014 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbZDWTKe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 15:10:34 -0400
In-Reply-To: <1240511508.10627.159.camel@nimitz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lenb@kernel.org

On Thu, 2009-04-23 at 11:31 -0700, Dave Hansen wrote:
> On Wed, 2009-04-22 at 20:45 -0700, Andrew Morton wrote:
> > (Is jstultz@us.ibm.com correct?)
> 
> Only I want it to go to the black hole which is Lotus Notes. :)
> 
> > On Tue, 21 Apr 2009 10:30:38 -0700 Dave Hansen <dave@sr71.net> wrote:
> > > This was during my first boot of 2.6.30-rc2.
> > 
> > Did it ever happen again?
> 
> I've seen it on three different boots, but the stack traces were a bit
> different each time.  So, I assume it is a true timekeeping thing
> instead of something *actually* locking up.
> 
> > I assume this is a post-2.6.29 regression?  (Yet another.  We've been
> > extra bad this time)
> 
> This laptop has been quite good to me and I haven't rebooted since the
> late 2.6.28 days.  It isn't anything special, though.  Just a Lenovo
> T61.  I wonder if my .config is a bit different.

I've got a T61 at home, so I'll try to test it out. Dave, can you send
me your .config? Also any chance you can bisect this down a tiny bit?

thanks
-john

