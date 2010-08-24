From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Tue, 24 Aug 2010 18:35:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008241815120.29078@localhost.localdomain>
References: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
 <AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
 <20100815133015.883c7069.akpm@linux-foundation.org>
 <AANLkTi=Ok3NH3k5EF1Da2Z3xA7uahABRtH7pEdOEuZH2@mail.gmail.com>
 <20100815182153.994179c1.akpm@linux-foundation.org>
 <AANLkTinBAgk_Ay4vCcTxTEsq-uwn=RwQpTA6O86JXGCM@mail.gmail.com>
 <20100816124300.e72258c9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20100816124300.e72258c9.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, sedat.dilek@gmail.com, Andi Kleen <ak@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

My bad.

Andrew was right -- I botched a modify/delete
merge conflict of two correct patches.
I did it at the last minute and then fed the wrong branch
("idle-release" instead of "release") to my build test,
send the code, and dropped of the net.  multiple mistakes.

Sorry for the sloppiness, I'll do better.

Upon the git merge conflict, it looks like I resorted to
pulling andi's original patch out of git, pushing it into
quilt on top of rui's delete; and then got fooled
by the refresh.  Should have caught that both by inspection
and by build...

On a positive note, the underlying reason for the conflict
was that we are succeeding in deleting a bunch of crufty code
that should not need to be maintained at all:-)

thanks,
Len Brown, Intel Open Source Technology Center
