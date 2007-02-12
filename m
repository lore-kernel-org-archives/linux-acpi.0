From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: git backlight tree
Date: Mon, 12 Feb 2007 13:43:27 +0000
Message-ID: <1171287807.5898.122.camel@localhost.localdomain>
References: <1171153985.5836.66.camel@localhost.localdomain>
	 <200702102345.39855.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:41394 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964919AbXBLNqE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Feb 2007 08:46:04 -0500
In-Reply-To: <200702102345.39855.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jsimmons@infradead.org, linux-kernel@hansmi.ch, openembedded@hrw.one.pl, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sat, 2007-02-10 at 23:45 -0500, Len Brown wrote:
> On Saturday 10 February 2007 19:33, Richard Purdie wrote:
> > As mentioned previously, I've setup a backlight git tree at:
> > 
> > http://git.o-hand.com/?p=linux-rpurdie-backlight;a=shortlog;h=for-mm
> > (git://git.o-hand.com/linux-rpurdie-backlight)
> > 
> > A patch of the combined changes to mainline is:
> > 
> > http://www.rpsys.net/openzaurus/patches/git_backlight-r1.patch.gz
> 
> The changes under drivers/acpi/ and drivers/misc/ look fine to me.
> Acked-by: Len Brown <len.brown@intel.com>
> if you need that to send those bits upstream.
> 
> Note that there is a new sony-laptop driver under drivers/misc/ in my tree
> that I expect to send upstream next week -- and it will need
> the analogous updates.

I'd noticed it and had sent Andrew a patch to keep things happy in -mm.
Now I know the timescales, I'll wait until after its gone in and fixup
the backlight tree accordingly before submitting.

Thanks,

Richard

