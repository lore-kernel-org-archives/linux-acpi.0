From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 13:01:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807171259010.2959@woody.linux-foundation.org>
References: <20080716214516.GA10777@basil.nowhere.org>  <200807170011.12184.rjw@sisk.pl>  <200807161633.01375.jbarnes@virtuousgeek.org>  <487EEAEB.4050009@firstfloor.org>  <alpine.LFD.1.10.0807170807040.2959@woody.linux-foundation.org>
 <alpine.LFD.1.10.0807170835320.2959@woody.linux-foundation.org>  <487F71E8.9050705@firstfloor.org> <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com> <487FA24B.9060803@firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932572AbYGQUBl@vger.kernel.org>
In-Reply-To: <487FA24B.9060803@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ray Lee <ray-lk@madrabbit.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On Thu, 17 Jul 2008, Andi Kleen wrote:
> 
> The whole point of the exercise of cleaning up/rewriting the history is to make
> the tree as bisectable as possible.

No.

"git bisect" is perfetly able to handle merges. They are _fine_.

The problem with rebasing is that it *changes* something that was already 
tested (and possibly merged into somebody elses tree) into SOMETHING ELSE.

And that means that a large portion of the previous testing is basically 
thrown away.

In particular, if something worked for somebody before, it also removes 
the "known good state" from a bisection standpoint, so rebasing actually 
makes things _harder_ to bisect - because now you cannot sanely bisect 
between two versions of the tree (when you mark the old tree "good", it 
has no relevance to the new tree that had all the old history rewritten).

So no, rebasing does _not_ make bisection easier. It makes it easier to 
understand, perhaps, but it actually makes many things much much harder, 
and removes all trace of any testing coverage that the old commit had.

			Linus
