From: Mattia Dongili <malattia@linux.it>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately resumes after STR
Date: Sun, 20 May 2007 15:59:48 +0900
Message-ID: <20070520065947.GA4880@inferi.kami.home>
References: <20070518071523.GA3195@inferi.kami.home> <20070518002240.bc08e811.akpm@linux-foundation.org> <20070519064829.GA15518@inferi.kami.home> <20070519000413.75badb6f.akpm@linux-foundation.org> <20070520061408.GA3325@inferi.kami.home> <20070519234723.5200a8b4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:53068 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763896AbXETHDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 May 2007 03:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20070519234723.5200a8b4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, David Brownell <dbrownell@users.sourceforge.net>, Len Brown <lenb@kernel.org>, Greg KH <greg@kroah.com>

On Sat, May 19, 2007 at 11:47:23PM -0700, Andrew Morton wrote:
> On Sun, 20 May 2007 15:14:08 +0900 Mattia Dongili <malattia@linux.it> wrote:
> 
> > On Sat, May 19, 2007 at 12:04:13AM -0700, Andrew Morton wrote:
> > > On Sat, 19 May 2007 15:48:29 +0900 Mattia Dongili <malattia@linux.it> wrote:
...
> > > > ok, git-acpi.patch is not the bad boy :)
> > 
> > but very very close:
> > acpi-driver-model-flags-and-platform_enable_wake.patch
> > 
> 
> Thanks very much for working that out - it saves lots of people heaps of
> pain.  I dropped the patch.

oh dear... and now, with the full series applied, I hit the
immediately-resuspend-after-resume someone already reported...

aargh
-- 
mattia
:wq!
