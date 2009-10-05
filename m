From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for 2.6.32-rc1
Date: Mon, 5 Oct 2009 23:51:53 +0200
Message-ID: <200910052351.53207.rjw@sisk.pl>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain> <200910052159.24920.rjw@sisk.pl> <alpine.LFD.2.01.0910051354450.3432@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754705AbZJEVvH@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.01.0910051354450.3432@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: balbir@linux.vnet.ibm.com, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On Monday 05 October 2009, Linus Torvalds wrote:
> 
> On Mon, 5 Oct 2009, Rafael J. Wysocki wrote:
> > 
> > This thing has already been merged, it appears: and it looks like a 
> > total breakage of rules to me.
> 
> Well, Len pointed out to me that the NAK is kind of pointless, since it 
> had no constructive alternatives to the issue. So he left it in as 
> documentation, but until the scheduler people can actually _do_ something 
> about the problem, their voice doesn't really matter, does it?

Well, for a patch that was objected to so strongly, I think it didn't get
enough review from other relevant people before being pushed upstream.
It looks like Balbir didn't see it before for one example.

It's been lots of time since the patch was originally posted to send it to
the LKML for discussion and so on and to receive some comments that
might help to improve it.  I have no idea why that wasn't done and I suspect
there was some corporate pressure on Len to push it upstream as quickly as
possible.

Best,
Rafael
