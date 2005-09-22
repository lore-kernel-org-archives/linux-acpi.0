From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ACPI] Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Thu, 22 Sep 2005 10:10:32 +0200
Message-ID: <200509221010.33643.rjw@sisk.pl>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921194306.GC13246@flint.arm.linux.org.uk> <43325A02.90208@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751443AbVIVIKZ@vger.kernel.org>
In-Reply-To: <43325A02.90208@drzeus.cx>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: acpi-devel@lists.sourceforge.net
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Russell King <rmk+lkml@arm.linux.org.uk>, Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com, ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thursday, 22 of September 2005 09:15, Pierre Ossman wrote:
> Russell King wrote:
> 
> >So, before trying to get the "underworked" bug system used more,
> >please try to get more developers signed up to it so that we have
> >the necessary folk behind the bug system to handle the increased
> >work load.
> >
> >  
> >
> 
> What we probably need then is an official policy that maintainers need
> to have an account in the bugzilla. Start with the subsystem maintainers
> and leave it to them to get each driver maintainer in line. Having only
> a handful of parts of the kernel in the bugzilla is just confusing.
> 
> Personally I think the mailing lists are a great way for general
> discussion. But once we have a confirmed bug (or difficult new feature)
> it is better off being tracked in bugzilla. And this is my opinion both
> as a user and as a developer. Bugzilla is the de facto standard of
> reporting bugs so some users might find it troublesome dealing with
> mailing lists such as LKML.

Generally, I think, all bugs fall into one of two categories.  Namely, there
are bugs that get fixed immediately as soon as someone with a clue sees
the report, compilation problems and the like, and there are bugs that
require much time to be handled.  IMHO, it doesn't make sense to litter
bugzilla with bugs of the first kind, but all bugs of the second kind
should be tracked in it, at least for the record.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
