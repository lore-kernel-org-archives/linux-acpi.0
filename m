From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 18:54:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081852320.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912082125410.26994-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755975AbZLICyw@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0912082125410.26994-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org



On Tue, 8 Dec 2009, Alan Stern wrote:
> 
> You mean, if A comes before B in the list and A must suspend after B?  

But if they are not topologically ordered, then A wouldn't necessarily be 
before B on the list in the first place.

Of course, if we've mucked with the list by hand and made sure the 
ordering is ok, then that's a different issue. But your whole point seemed 
to be that the device could impose its own ordering in its suspend 
callback, which is not true on its own without external ordering.

		Linus
