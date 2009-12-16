From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 14:11:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912161410120.3556@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912162027.16574.rjw@sisk.pl> <alpine.LFD.2.00.0912161255080.3556@localhost.localdomain> <200912162257.00771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42215 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935801AbZLPWLu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2009 17:11:50 -0500
In-Reply-To: <200912162257.00771.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



Btw, what are the timings if you just force everything async? I think that 
worked on yur laptops, no?

It would be interestign to know - if only to see what the asymptotic upper 
bound is for all of this is..

		Linus
