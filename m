From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 13:20:57 -0800 (PST)
Message-ID: <20060108212057.79825.qmail@web31815.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0601081141450.3169@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601081141450.3169@g5.osdl.org>
Sender: git-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Martin Langhoff <martin.langhoff@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> So trying out git-rebase and git-cherry-pick just in case you decide to 
> want to use them might be worthwhile. Making it part of your daily routine 
> like David has done? Somewhat questionable, but hey, it seems to be 
> working for David, and it does make some things much easier, so..

How about this usage (branch == tree):

Tree A    (your tree)
  Tree B     (project B, dependent on Tree A)
     Tree C     (project C, dependent on project B)

(i.e. diff(C-A) = diff(C-B) + diff(B-A))

Your tree is pulled into Tree A as often as your tree
changes and it just fast forwards.

If I want to run project B with your latest tree, then
I resolve/merge from tree A to tree B, compile B
and run it.

If I want to run project C and project B with your
latest tree, I resolve/merge from tree A to tree B
and from tree B to tree C, compile C and run it.

In such cases, are you saying that you'd prefer to
pull from Tree B and Tree C (depending on your needs)?

Another question:
Sometimes, a fix for project B finds its way into
tree C (project C) (since C depended on that fix in B).
Now I'd like to pull that particular fix, identified by
its SHA, into project B, and nothing else, for this I can
use git-cherry-pick, right?

And lastly, is there a tool whereby I can "see" changes
between repos, kind of like git-diff but being able to
give URLs too?

    Luben
