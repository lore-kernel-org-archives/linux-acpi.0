From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor register on
	resume
Date: Thu, 26 Jun 2008 10:51:10 +0200
Message-ID: <20080626085110.GA18599@elte.hu>
References: <200806242303.49498.rjw@sisk.pl> <20080626011716.e8c412dd.akpm@linux-foundation.org> <20080626082943.GC10973@elte.hu> <200806261040.00646.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:52334 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYFZIw0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:52:26 -0400
Content-Disposition: inline
In-Reply-To: <200806261040.00646.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Thursday, 26 of June 2008, Ingo Molnar wrote:
> > 
> > * Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > Len seems to think that Rafael seems to think that Ingo seems to think 
> > > that this patch broke one of his boxes.
> > > 
> > > Is it so?
> > 
> > No! :-)
> > 
> > it found a pre-existing suspend+resume breakage on a testbox. (I.e. 
> > the debug patch worked as i'd expect it to work. Every good debug 
> > patch starts its lifetime with a sharp spike of breakages it finds.)
> 
> Does it mean that the $subject patch doesn't break your test box after 
> all?

it doesnt break it - i get the same suspend+resume breakage without that 
patch as well, if i do it manually.

	Ingo
