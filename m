From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off
 aftersuspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 08:50:04 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802220843560.19896@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802211302.27002.jesse.barnes@intel.com> <b6a2187b0802211620q47f6601fuf7e88395d89b90c8@mail.gmail.com> <200802211623.55450.jesse.barnes@intel.com> <b6a2187b0802211642i17730ccav6744b614c086df72@mail.gmail.com>
 <20080222103727.GA25781@srcf.ucam.org> <20080222130615.GA29123@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760722AbYBVQvn@vger.kernel.org>
In-Reply-To: <20080222130615.GA29123@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jeff Chua <jeff.chua.linux@gmail.com>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Fri, 22 Feb 2008, Ingo Molnar wrote:
> 
> btw., why isnt there an in-kernel whitelist, with perhaps a dynamic, 
> convenient /debug/s2r/whitelist append-API for distros (and testers) to 
> add more entries to the whitelist/blacklist? (for cases where the kernel 
> whitelist has not caught up yet) Which would eventually converge to 
> Utopia: s2ram that just works out of box.

The big problem with that is
 - the people who know about the devices are usually not kernel people
 - the workarounds that the whitelist requires is quite often not a kernel 
   workaround.

In other words, the most common workarounds for the s2ram whitelist is 
usually to do things like running vbetool in user-level to do VGA register 
save/restore (VBE_POST and VGE_SAVE). Sure, the kernel could do that with 
usermodehelper etc, but s2ram also has those things as command line flags 
etc, so...

		Linus
