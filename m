From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Sony laptop battery has odd behavior with 2.6.26-rc3ish build.
Date: Fri, 23 May 2008 09:21:56 +0200
Message-ID: <20080523072156.GA8964@ucw.cz>
References: <20080521115723.GF4287@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2837 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752068AbYEWHW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 May 2008 03:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20080521115723.GF4287@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin Holt <holt@sgi.com>
Cc: astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> A couple days ago, I updated my test build to commit
> 8033c6e9736c29cce5f0d0abbca9a44dffb20c39 and noticed an odd behavior
> with the battery.  If I unplug the power, the battery discharges and
> that is reflected in /proc/acpi/battery/BAT0/state.  I am not certain
> the discharge is continuous and uniform or if it goes in steps.  When I
> plug the power back in, the level stays at a constant value (+-1mAh)
> for a considerable period of time.  It then does a single step back to
> the fully charged value.
> 
> I have not done any searching to see when this began.  I had been running
> the ubuntu 2.6.22-14 kernel before this and the behavior was normal.
> 
> I am not certain what information you will need.  Commit is above.

git bisect would certainly help...

> $ cat /proc/acpi/battery/BAT0/alarm
> alarm:                   unsupported
> $ cat /proc/acpi/battery/BAT0/info
> present:                 yes
> design capacity:         4800 mAh
> last full capacity:      4096 mAh
> battery technology:      non-rechargeable

Because something is clearly wrong here.

						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
