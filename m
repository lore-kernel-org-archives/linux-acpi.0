From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH] PM: Introduce PM_EVENT_HIBERNATE (was: Re: i915 hibernation patch (was: Re: 2.6.25-rc2 System no longer ...))
Date: Sun, 24 Feb 2008 23:21:47 +0800
Message-ID: <b6a2187b0802240721t298406a3p62a85b2234eadd76@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
	 <b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09@mail.gmail.com>
	 <200802231913.27592.rjw@sisk.pl>
	 <alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:10669 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYBXPVr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Feb 2008 10:21:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1398526wah.23
        for <linux-acpi@vger.kernel.org>; Sun, 24 Feb 2008 07:21:47 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Alexey Starikovskiy <astarikovskiy@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sun, Feb 24, 2008 at 2:43 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:
>  >
>
> > Thanks for testing.  Below is the final version of the patch with a changelog
>  > etc.
>
>  Thanks, applied.
>
>  With this, I also find that I dislike the use of suspend/resume for
>  freezing for STD a lot less. It's still too easy to get confused, but at
>  least now drivers always have total knowledge about what is really going
>  on. I'd not like this interface as a driver writer, but now it's not
>  fundamentally broken any more, just slightly confusing.

Tested and working.

Thanks again,
Jeff.
