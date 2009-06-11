From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: 2.6.30-rc6: i915: Xserver crash - oops after rmmod
Date: Thu, 11 Jun 2009 09:37:07 -0700
Message-ID: <20090611093707.5d20af25@jbarnes-g45>
References: <4A11B52E.7080808@gmail.com>
	<20090527171414.108710cf.akpm@linux-foundation.org>
	<4A1E1D95.5060409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-24.bluehost.com ([69.89.21.19]:46865 "HELO
	outbound-mail-24.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754438AbZFKQhx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2009 12:37:53 -0400
In-Reply-To: <4A1E1D95.5060409@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, eric@anholt.net, linux-acpi@vger.kernel.org

On Thu, 28 May 2009 07:13:57 +0200
Niel Lambrechts <niel.lambrechts@gmail.com> wrote:

> Hi Andrew,
> 
> On 05/28/2009 02:14 AM, Andrew Morton wrote:
> > On Mon, 18 May 2009 21:21:18 +0200
> > Niel Lambrechts <niel.lambrechts@gmail.com> wrote:
> >
> >   
> >> Hi,
> >>     
> > Huge response, huh?
> >   
> Yeah, no one fell for the humour coating... ;-)
> 
> > The wordwrapping makes this painful to read.
> >
> > rmmod crashed under drivers/acpi/video.c:acpi_video_exit()'s call to
> > acpi_bus_unregister_driver().  So it might be an acpi-related bug.
> >
> > If it's reproducible at all, please raise a (non-wordwrapped!)
> > report against acpi at bugzilla.kernel.org, thanks.
> >   
> Ugh, Thunderbird doesn't format it like this when you preview - but
> when I save it to a file it looks horrible...
> 
> I don't think I would easily be able to reproduce this, but I still
> had a copy of my kernel log for that date. The bug is filed at:
> http://bugzilla.kernel.org/show_bug.cgi?id=13396
> 
> Also, if you do have a moment, I'd love to hear your opinion on my
> post "2.6.29.4: hibernation fails with large kernel trace"!
> 
> Thanks for the response!

Btw I think this is fixed now (I noticed it recently but it's gone
now).  IIRC it was a bug caused by trying to uninit the ACPI video
portion of the driver twice at unload time.

-- 
Jesse Barnes, Intel Open Source Technology Center
