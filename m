From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 15:47:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912191546250.3712@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org> <200912200010.19899.rjw@sisk.pl> <alpine.LFD.2.00.0912191521180.3712@localhost.localdomain> <200912200040.18944.rjw@sisk.pl>
 <alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53113 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753828AbZLSXrM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Dec 2009 18:47:12 -0500
In-Reply-To: <alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Sat, 19 Dec 2009, Linus Torvalds wrote:
> 
> I suggest you try to treat the i8042 controller async, and see if it is 
> problematic. If it isn't, don't do that then.

I obviously meant: "If it _is_ problematic, don't do that then". "Is", not 
"isn't".

		Linus
