From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 15:07:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601091502200.5588@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
To: Luben Tuikov <ltuikov@yahoo.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>, Martin Langhoff <martin.langhoff@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Mon, 9 Jan 2006, Luben Tuikov wrote:
> 
> Yes.  Ever since I started used git, I never used branch
> switching, but I do have git branches and I do use git branching.
> 
> I basically have a branch per directory, whereby the object db
> is shared as is remotes/refs/etc, HEAD and index are not shared
> of course.
> 
> This allows me to do a simple and fast "cd" to change/go to a
> different branch, since they are in different directories.
> So the time I wait to switch branches is the time the filesystem
> takes to do a "cd".
> 
> This also allows me to build/test/patch/work on branches
> simultaneously.

Yes. It has many advantages, and it's the approach I pushed pretty hard 
originally, but the "many branches in the same tree" approach seems to 
have become the more common one. Using many branches in the same tree is 
definitely the better approach for _distribution_, but that doesn't 
necessarily mean that it's the better one for development.

For example, you can have a git distribution tree with 20 different 
branches on kernel.org, but do development in 20 different trees with just 
one branch active - and when you do a "git push" to push out your branch 
in your development tree, it just updates that one branch on the 
distribution site.

So git certainly supports that kind of behaviour, but nobody I know 
actually does it that way (not even me, but since I tend to just merge 
other peoples code, I don't actually have multiple branches: I create 
temporary branches for one-off things, but don't maintain them that way).

			Linus
