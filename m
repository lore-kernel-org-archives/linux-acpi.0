From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 07:31:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912150726510.14385@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <alpine.LFD.2.00.0912141609020.14385@localhost.localdomain> <alpine.LFD.2.00.0912141610460.14385@localhost.localdomain> <200912151214.10980.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754228AbZLOPcZ@vger.kernel.org>
In-Reply-To: <200912151214.10980.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org



On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> 
> What fact?  The only thing that matters is USB?  For resume, it is.  For
> suspend, it clearly isn't.

For suspend, the only other case we've seen has been the keyboard and 
mouse controller, which has exactly the same "we can special case it with 
a single 'let's do _this_ device asynchronously'". Again, it may not be 
pretty, but it sure is simple.

Much simpler than talking about some generic infrastructure changes and 
about doing "let's do leaves of the tree separately" schemes.

And that's why I'm _soo_ unhappy with you, and am insulting you. Because 
you keep on making the same mistake over and over - overdesigning.

Overdesigning is a SIN. It's the archetypal example of what I call "bad 
taste". I get really upset when a subsystem maintainer starts 
overdesigning things.

			Linus
