From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Fri, 17 Nov 2006 17:25:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611171719110.3618@woody.osdl.org>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061117204036.GK31879@stusta.de> <Pine.LNX.4.64.0611171552230.3618@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:54187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756123AbWKRB2X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Nov 2006 20:28:23 -0500
In-Reply-To: <Pine.LNX.4.64.0611171552230.3618@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org



On Fri, 17 Nov 2006, Linus Torvalds wrote:
> 
> Total lockup - no sysrq, no messages, no nothing.

Dammit.

It looks like 37605a6900f6b4d886d995751fcfeef88c4e462c, and I should have 
realized that immediately.

That commit re-introduces the bug that we already reverted once.

Why the hell did that idiotic thing go in, when we had to revert it once 
already (see commit 72945b2b90a5554975b8f72673ab7139d232a121 for the 
earlier revert).

It was broken then, it is broken now. Nothing has changed.

Why did you guys try to sneak it in again? Last time this same "use a 
second workqueue" patch went in (in a different form), we had _exactly_ 
the same problems, with total lockups, and way too high CPU usage.

The bugzilla entry that you refer to in that commit is even the same one 
that discussed why the _original_ patch was totally broken.

It's even the same AUTHOR who wrote the original buggy patch, that pushed 
through the same buggy patch AGAIN.

Dammit, this is frustrating.

Why did people expect it to suddenly not be buggy?

		Linus
