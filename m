From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Thu, 22 Sep 2005 12:54:58 +0200
Message-ID: <43328D82.5020505@drzeus.cx>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>	<20050921173630.GA2477@localhost.localdomain>	<20050921194306.GC13246@flint.arm.linux.org.uk>	<43325A02.90208@drzeus.cx> <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030253AbVIVKy7@vger.kernel.org>
In-Reply-To: <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, len.brown@intel.com, acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Eric W. Biederman wrote:

>But the definition of a maintainer is whoever takes responsibility for
>part X.  The are many pieces of the kernel that don't easily break
>up into the taxonomy of subsystem and driver.  There are many people
>to reluctantly take responsibility because there is no one else,
>and so aren't even mentioned in MAINTAINERS much less the rest of it.
>
>  
>

Setting up an account for a mailing list and linking unmaintained parts
to it would be a solution to that. Either set up a specific list for
this or use when of the current ones (like LKML). The big problem I see
at the moment is that not all parts of the kernel are represented in the
bugzilla.

>One problem I have with a system like bugzilla is that frequently bug
>reports are not complete, and bugzilla sets the expectation that
>once you file a bug the reporters part is complete.  Frequently it takes
>several round trips via email to even understand the bug that is being
>reported. 
>  
>

I agree that most bug reports are incomplete. But I still think that a
bugzilla is the way to go. We need to educate the users in filing bug
reports no matter which forum is used. Russell's point about having a
wizard would probably help a lot. A bugzilla also gives the option of
marking bugs with NEEDINFO, INVALID and similar, clearly expressing to
the user how the maintainer sees this bug.

>So either we need a two level bug tracking system where there
>is a place to capture bugs that users see, and a place to track
>bugs that developers understand.  Or we need something that is
>much more interactive than bugzilla.
>
>  
>

I think that the categories NEW/ASSIGNED/CONFIRMED suffices. Although
discussions on mailing lists are more natural for the people here I
don't agree that bugzilla is less interactive than lists.

Rgds
Pierre
