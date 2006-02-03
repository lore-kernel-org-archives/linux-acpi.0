From: Joerg Sommrey <jo@sommrey.de>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 08:03:30 +0100
Message-ID: <20060203070329.GA5414@sommrey.de>
References: <20060202222407.GB896@sommrey.de> <20060202143725.46d218dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bender.bawue.de ([193.7.176.20]:53171 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1750967AbWBCHEQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 02:04:16 -0500
Content-Disposition: inline
In-Reply-To: <20060202143725.46d218dc.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com, len.brown@intel.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk

On Thu, Feb 02, 2006 at 02:37:25PM -0800, Andrew Morton wrote:
> Joerg Sommrey <jo@sommrey.de> wrote:
> >
> > This is a processor idle module for AMD SMP 760MP(X) based systems.
> >
> 
> Len's comments about loss of cache coherency on some machines possibly
> causing corruption made me drop this patch.   Was I wrong to do so?
> 
You maintain -mm, so it's your decision.  I don't think it is a question
of right or wrong.  If you regard this stuff as too risky, dropping
it is ok.

However, I disagree with Len in two points:
- I cannot see a problem witch cache snooping.  The AMD-768 docs clearly
  states that trying to snoop the cache while in C3 is a resume event.
- Enabling C2/C3 in the BIOS would be a very bad thing IMHO.  From all
  the testing with amd76x_pm I found that is very tricky to go into
  C2/C3 "the right way".  Simply reading the PM register without a
  suitable logic around leads to all kinds of instabilities.  You need
  to implement this logic and then enable the hardware.  The BIOS cannot
  do this.

-jo

-- 
-rw-r--r--  1 jo users 63 2006-02-03 07:43 /home/jo/.signature
