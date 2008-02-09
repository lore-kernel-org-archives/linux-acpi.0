From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Sat, 9 Feb 2008 21:53:26 -0200
Message-ID: <20080209235326.GA6553@khazad-dum.debian.net>
References: <20080209013157.4895.70128.stgit@pacifica> <200802090412.57945.lenb@kernel.org> <20080209182217.GA23736@khazad-dum.debian.net> <200802092204.32858.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53267 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755923AbYBIXxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Feb 2008 18:53:33 -0500
Content-Disposition: inline
In-Reply-To: <200802092204.32858.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>, Mattia Dongili <malattia@linux.it>

On Sat, 09 Feb 2008, Carlos Corbacho wrote:
> On Saturday 09 February 2008 18:22:17 Henrique de Moraes Holschuh wrote:
> > BTW Carlos, sending a git diff would have resulted in much smaller diffs
> > (since git diff can do renames instead of add/delete) :)  I believe all of
> > us can deal just fine with git diffs, so it makes sense to use them in
> > these cases.
> 
> I don't quite know what you mean here - experimenting in a tree here, git-diff 
> doesn't produce any noticeable difference after using git-mv - unless this is 
> a bug with StackedGit being unable to handle renames/ moves properly?

Randy sent you a much better email than mine about it, but here it goes:

hmh@thorin:/tmp/f$ git init 
Initialized empty Git repository in .git/
hmh@thorin:/tmp/f$ cp /var/log/Xorg.0.log .
hmh@thorin:/tmp/f$ git add .
hmh@thorin:/tmp/f$ git commit -m "initial commit"
Created initial commit 4e5f9c4: initial commit
 1 files changed, 1260 insertions(+), 0 deletions(-)
 create mode 100644 Xorg.0.log
hmh@thorin:/tmp/f$ git mv Xorg.0.log Xorg.1.log
hmh@thorin:/tmp/f$ git commit -m "move commit"
 Created commit ed5f8d0: move commit
 2 files changed, 1260 insertions(+), 1260 deletions(-)
 delete mode 100644 Xorg.0.log
 create mode 100644 Xorg.1.log
hmh@thorin:/tmp/f$ git diff HEAD^.. -M       
diff --git a/Xorg.0.log b/Xorg.1.log
similarity index 100%
rename from Xorg.0.log
rename to Xorg.1.log

The key is that -M (or -C for that matter).  To be even more clear:
hmh@thorin:/tmp/f$ git diff HEAD^.. | wc
   2532   20098  134766
hmh@thorin:/tmp/f$ git diff HEAD^.. -M | wc
   4      13     103

So I really should have mentioned -M when I talked about git diffs :-(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
