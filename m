From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: 2.6.30-rc6: i915: Xserver crash - oops after rmmod
Date: Fri, 12 Jun 2009 08:49:12 +0800
Message-ID: <1244767752.3618.13.camel@localhost.localdomain>
References: <4A11B52E.7080808@gmail.com>
	 <20090527171414.108710cf.akpm@linux-foundation.org>
	 <4A1E1D95.5060409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbZFLAr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2009 20:47:56 -0400
In-Reply-To: <4A1E1D95.5060409@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eric@anholt.net" <eric@anholt.net>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-05-28 at 13:13 +0800, Niel Lambrechts wrote:
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
> > If it's reproducible at all, please raise a (non-wordwrapped!) report
> > against acpi at bugzilla.kernel.org, thanks.
> >   
> Ugh, Thunderbird doesn't format it like this when you preview - but when
> I save it to a file it looks horrible...
> 
> I don't think I would easily be able to reproduce this, but I still had
> a copy of my kernel log for that date. The bug is filed at:
> http://bugzilla.kernel.org/show_bug.cgi?id=13396
> 
> Also, if you do have a moment, I'd love to hear your opinion on my post
> "2.6.29.4: hibernation fails with large kernel trace"!
> 
> Thanks for the response!
Yes. This bug can be reproduced very easily. 
I attach one patch in bug
http://bugzilla.kernel.org/show_bug.cgi?id=13396#C5.
And the issue should be fixed by the patch.

In the patch the reference count is added to avoid loading/unloading the
ACPI video bus twice.

Thanks.
> 
> Niel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

