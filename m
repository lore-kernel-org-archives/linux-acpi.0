From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc0
Date: Thu, 1 May 2008 02:39:47 -0400
Message-ID: <200805010239.48789.lenb@kernel.org>
References: <200804301420.11696.lenb@kernel.org> <alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43529 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbYEAGkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2008 02:40:09 -0400
In-Reply-To: <alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Wednesday 30 April 2008, Linus Torvalds wrote:
> 
> On Wed, 30 Apr 2008, Len Brown wrote:
> > 
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> Ok, this clashed in some nasty ways in drivers/acpi/video.c due to the 
> non-racy /proc file creation changes that came through Andrew. I fixed up 
> the result, and it *looks* sane (and compiles), but I didn't actually test 
> it, and I don't know the code well. Can you double-check.

Thanks for merging video.c
When I did my builds, andrew had not yet scribbled on video.c.
I usually do a "last minute" pull to make sure you are not faced
with any merges, but this time when I did I got some version of your
tree that wouldn't build so I figured it was still moving and didn't
bother merging with it.

Anyway, I looked over this file and the things I looked for seemed okay,
but to be sure I'll repeat your merge tomorrow and see if I come
up with the same thing.

> There were some (smaller) rejects in drivers/misc/intel_menlow.c due to 
> two different versions of the same patch from Julia Lawall (again, the 
> other came through Andrew), and I picked the one from Andrew because it 
> had the later date. But again, you should double-check.

You picked the right one.
Indeed, it looks like the other files touched in Julia's earlier
patch (9030062f3d61f87c1e787b3aa134fa3a8e4b2d25)
don't handle the failure case quite right --
Rui and I will follow-up.

thanks,
-Len

