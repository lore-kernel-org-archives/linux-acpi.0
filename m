From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Subject: RE: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Sat, 18 Nov 2006 19:23:30 +0300
Message-ID: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17936 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1755150AbWKRQXg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 11:23:36 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org

May because it does not have a single common line with the previous
patch?
Or may be because it fixes all the current AMD-HP notebooks? 
Or may be because it did not fail while being in -mm?

I will not "sneak it in" again, I promise. 

Regards,
	Alex. 

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Saturday, November 18, 2006 4:25 AM
To: Brown, Len; Starikovskiy, Alexey Y; Adrian Bunk; Andrew Morton
Cc: David Brownell; linux-acpi@vger.kernel.org
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))



On Fri, 17 Nov 2006, Linus Torvalds wrote:
> 
> Total lockup - no sysrq, no messages, no nothing.

Dammit.

It looks like 37605a6900f6b4d886d995751fcfeef88c4e462c, and I should
have 
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

It's even the same AUTHOR who wrote the original buggy patch, that
pushed 
through the same buggy patch AGAIN.

Dammit, this is frustrating.

Why did people expect it to suddenly not be buggy?

		Linus
