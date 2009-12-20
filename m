From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 12:12:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912201210300.24162-100000@netrider.rowland.org>
References: <200912201352.07689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755629AbZLTRMX@vger.kernel.org>
In-Reply-To: <200912201352.07689.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:

> > It's too early to come to this sort of conclusion (i.e., that suspend
> > and resume react very differently to an asynchronous approach).  Unless
> > you have some definite _reason_ for thinking that resume will benefit
> > more than suspend, you shouldn't try to generalize so much from tests
> > on only two systems.
> 
> In fact I have one reason.  Namely, the things that drivers do on suspend and
> resume are evidently quite different and on these two systems I was able to
> test they apparently took different amounts of time to complete.
> 
> The very fact that on both systems resume is substantially longer than suspend,
> even if all devices are suspended and resumed synchronously, is quite
> interesting.

Yes, it is.  But it doesn't mean that suspend won't benefit from 
asynchronicity; it just means that the benefits might not be as large 
as they are for resume.

Alan Stern
