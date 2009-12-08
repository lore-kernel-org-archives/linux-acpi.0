From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 22:52:51 +0100
Message-ID: <200912082252.51916.borntraeger@de.ibm.com>
References: <Pine.LNX.4.44L0.0912081626400.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966523AbZLHVw4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081626400.3046-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

> > Sure they can. Control dependencies are trivial - it's called "branch 
> > prediction", and everybody does it, and data dependencies don't exist on 
> > many CPU architectures (even to the point of reading through a pointer 
> > that you loaded).
> 
> Wait a second.  Are you saying that with code like this:
> 
> 	if (x == 1)
> 		y = 5;
> 
> the CPU may write to y before it has finished reading the value of x?  
> And this write is visible to other CPUs, so that if x was initially 0
> and a second CPU sets x to 1, the second CPU may see y == 5 before it
> executes the write to x (whatever that may mean)?

No, the write really depends on x being 1 at any time before the comparison.
On the other hand x being != 0 during the comparison does not prevent the 
write without proper locking or barriers.


Have a look at

http://www.linuxjournal.com/article/8211
http://www.linuxjournal.com/article/8212

especially at the alpha part what can happen when dealing with pointer accesses.

Christian
