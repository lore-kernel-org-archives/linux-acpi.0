From: Linus Torvalds <torvalds@osdl.org>
Subject: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Fri, 17 Nov 2006 15:58:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611171552230.3618@woody.osdl.org>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061117204036.GK31879@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:54411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756059AbWKRACK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Nov 2006 19:02:10 -0500
In-Reply-To: <20061117204036.GK31879@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org



On Fri, 17 Nov 2006, Adrian Bunk wrote:
> 
> Subject    : nasty ACPI regression, AE_TIME errors
> References : http://lkml.org/lkml/2006/11/15/12
> Submitter  : David Brownell <david-b@pacbell.net>
> Handled-By : Len Brown <len.brown@intel.com>
>              Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> Status     : problem is being debugged

I do not know if this is related, but testing one of my laptops (always a 
good idea to check the week before release) shows that my trusty old 
Compaq N620c locks up rather quickly at boot with the current -git tree. 

Total lockup - no sysrq, no messages, no nothing.

I've mostly bisected it (what the _hell_ did we do before "git bisect"?), 
and right now I know:

commit 9aaed2b42d00d4abb2748d72d599a8033600e2bf is bad (that's Len's "pull 
trivial into test branch") commit.

v2.6.19-rc2 seems all good.

Which leaves a chunk of just a few ACPI commits left to bisect. 

I'll do five or so more reboots, and I should be able to tell exactly 
which commit breaks. It almost always locks up very early during boot 
(generally during the "initializing udev" phase), although sometimes it 
survives a bit further..

		Linus
