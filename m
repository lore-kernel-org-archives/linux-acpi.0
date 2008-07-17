From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 21:49:31 +0200
Message-ID: <487FA24B.9060803@firstfloor.org>
References: <20080716214516.GA10777@basil.nowhere.org>	 <200807170011.12184.rjw@sisk.pl>	 <200807161633.01375.jbarnes@virtuousgeek.org>	 <487EEAEB.4050009@firstfloor.org>	 <alpine.LFD.1.10.0807170807040.2959@woody.linux-foundation.org>	 <alpine.LFD.1.10.0807170835320.2959@woody.linux-foundation.org>	 <487F71E8.9050705@firstfloor.org> <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:59114 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815AbYGQTtg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 15:49:36 -0400
In-Reply-To: <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


> It matters to us end-testers when we do a git bisect. If you leave the
> history intact 

The whole point of the exercise of cleaning up/rewriting the history is to make
the tree as bisectable as possible.

Otherwise e.g. if I submitted patch + fixup + fixup + revert + fixup etc.
everyone doing a bisect would go crazy or rather hit many points
with various subtle breakages.

and let the merging happen at Linus' end (or, at least
> at merge time), then there is a point in history of your tree that
> someone (or git bisect) can check out and try, validating the patch,
> and therefore fingering a failed merge.

Why would you care about the merge and not about the individual patches?
Note that these quilt merges don't have conflicts.

> It's the difference between having tested patches and an untested
> merge, or untested new patches

The patches are as tested individually as they were before. I don't see
how you can call something that was in linux-next for some time and also
in my test tree "untested". The completely merged tree is not tested
well [1] in both cases (unless after some time of course) as far as I can see,
no difference.

[1] I do some basic testing as in building and test booting on a few
machines on each merge, so calling it completely untested is not
true.

> and an untested merge. 

So when I do a rebase versus Linus doing a merge (end result
the same code base) how is that more untested?

Your point is
> the end result is untested either way. The other way to look at it is
> *how much* untested history ends up in the tree. In Linus' version,
> just the point from the merge onward is untested. In your version,
> everything is new.

Sorry I still don't see the difference. AFAIK the only difference
is that I do the merge vs Linus doing it and that it looks slightly
different in the history, but apart from that (as in what
actually ends up in the source tree) it's all the same.

-Andi


