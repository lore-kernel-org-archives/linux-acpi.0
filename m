From: Len Brown <lenb@kernel.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 14:49:04 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807171402110.2965@localhost.localdomain>
References: <20080716214516.GA10777@basil.nowhere.org>
 <200807170011.12184.rjw@sisk.pl> <200807161633.01375.jbarnes@virtuousgeek.org>
 <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org>
 <487EE940.1050007@firstfloor.org>
 <alpine.LFD.1.10.0807170752190.2959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:50080 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbYGQStN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 14:49:13 -0400
In-reply-to: <alpine.LFD.1.10.0807170752190.2959@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Andi, Jesse, Linus,

Thanks for working through this while I'm away.

Patches with cross-tree dependencies happen,
and they continue to be a challenge to our process.
We don't really have an organized way to handle them.
It seems that every time they are a communication challenge
and I'm sorry I wasn't there to hold up my
end of the communication on this merge.

Jesse,

I use Tony Luck's topic-branch scheme, now part of the git manual:

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#maintaining-topic-branches

Re: updating history in git
yes, this is an sort of an oxymoron, but it is necessary
for a "middle-man" maintainer.
On one hand, we need to test exactly what is checked in,
and on the other hand, not every test passes...
So we need to revise what we checked in before it goes upstream
and becomes permanent history.

The alternative would be to check in a lot of reverts
and incremental patches that make the final history
sent to linus really confusing.

I find that the topic branches help a lot with this.
My "test" branch is the merge of a bunch of topic branches.
If a topic branch turns out to be bad, I can re-merge my test
branch from those topics, excluding the bad one.
(or including a revised replacement).

All the branches besides the revised one maintain
their place in history.  So if they used to work,
they shoulds still work.  Of course the merge itself
can go bad...  But my topic branches are as independent
as possible, so this is rare.

Customers of my test branch know that it can be re-based.
mm and linux-next are the main customers, and since
they re-merge from scratch each time, they're immune.
Individual developers simply deal with it as a diff,
say by using the plain-patch I export, or I do something special for them.

Sometimes I re-base topic branches to make
creating a diff of them versus a well known snapshot
(eg an -rc) easy.  This is particularly useful for
topic branches that take a long time to go upstream
b/c sometimes people want to test them, but only
against a recent baseline.

Branches pulled into "release" for linus are frozen,
or course, since Linus' tree is permanent history.
So any reverts/updates after that point have to
be real revert commits and incremental patches.

cheers,
-Len

ps.

One thing I wish I had in git is a way to make this sequence easier...

Say I have a big topic branch with 30 patches in it.
The 3rd patch turns out to have a bug in it, but the
rest of the series is okay.  Today I invoke gitk on
the branch and keep that open.
Then I create a new topic branch at the broken patch.

I always consult ~/src/git/Documentation/git-reset.txt
so I can remember the following sequence...

$ git reset --soft HEAD^
$ edit
$ git commit -a -c ORIG_HEAD

Now I've got the fixed 3rd patch checked in,
but 27 patches in the original branch are hanging
off the original broken 3rd patch.
So I git-cherry-pick 27 patches
I hope I get them in the right order and don't miss any...

It would be nice if we could somehow git rebase those
27 patches in a single command, but if we do,
that pulls with it the broken 3rd patch.

come to think of it, I can probably export 4..27 as
an mbox and then import it on top of the new 3,
maybe that is what others do.


