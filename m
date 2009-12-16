From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 12:59:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912161255080.3556@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912160311.05915.rjw@sisk.pl> <alpine.LFD.2.00.0912160737350.7454@localhost.localdomain> <200912162027.16574.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964807AbZLPU71@vger.kernel.org>
In-Reply-To: <200912162027.16574.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org



On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > Do you have any sample timing output with devices listed?
> 
> I'm going to generate one shortly.

>From my bootup timings, I have this memory of SATA link bringup being 
noticeable. I wonder if that is the case on resume too...

		Linus
