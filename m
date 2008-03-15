From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Sat, 15 Mar 2008 12:21:53 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803151212180.3020@woody.linux-foundation.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>  <47D86D43.2060108@imap.cc> <1205441216.4971.65.camel@nimitz.home.sr71.net>  <47D9C853.3040701@imap.cc> <1205517802.12763.18.camel@nimitz.home.sr71.net>  <1205525184.12763.32.camel@nimitz.home.sr71.net>
  <47DAE55C.3080506@tremplin-utc.net>  <1205530551.8167.20.camel@nimitz.home.sr71.net>  <47DB013D.3060102@tremplin-utc.net> <1205537395.8167.31.camel@nimitz.home.sr71.net> <47DBC578.7050101@imap.cc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59103 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752291AbYCOTWy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Mar 2008 15:22:54 -0400
In-Reply-To: <47DBC578.7050101@imap.cc>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Dave Hansen <haveblue@us.ibm.com>, Eric Piel <eric.piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>



On Sat, 15 Mar 2008, Tilman Schmidt wrote:
> 
> Sorry to say, it doesn't. That is, it does shut up the warning I
> reported, but there's a new one appearing now instead, three lines
> later.

I've reverted the whole thing. Or rather, since there were various small 
fixup commits over time, and a simple revert doesn't really work, I ended 
up just removing the option and the code that was conditional on it - that 
way, if we really want to fight this out some time (after 2.6.25 is out) 
or some vendor wants to use a known-broken option anyway, there's a simple 
and fairly clean commit to revert the revert.

It's commit 9a9e0d685553af76cb6ae2af93cca4913e7fcd47, see 

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9a9e0d685553af76cb6ae2af93cca4913e7fcd47

for details if you aren't a git person.

But quite frankly I don't think that we even want to re-introduce this in 
that form. If we really want to have a dynamic custom DSDT, I think we 
should do the whole DSDT replacement *much* later by ACPI (like just 
before driver loading or something like that).

If the BIOS-provided DSDT is _so_ broken that we cannot even get core 
stuff like the CPU's going, I think it has more serious issues than any 
custom DSDT will ever fix, but letting ACPI actually switch DSDT's at 
run-time (instead of just replacing it when looking for it very very early 
in the boot sequence) in order to work around some device issues sounds 
reasonably sane.

So how about aiming to make that DSDT-replacement something you can do 
from any kernel module, _after_ the original DSDT has already been parsed? 
And then the whole "load it from initrd" turns into a regular thing that 
we can do pretty early, but that we don't have to do quite _this_ early!

		Linus
