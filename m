From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Date: Fri, 11 May 2007 15:51:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705111550540.3986@woody.linux-foundation.org>
References: <200611011323.14830.rjw@sisk.pl> <200705111121.51704.rjw@sisk.pl>
 <alpine.LFD.0.98.0705110912290.3986@woody.linux-foundation.org>
 <200705112208.53971.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:55386 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752988AbXEKWxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2007 18:53:17 -0400
In-Reply-To: <200705112208.53971.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>



On Fri, 11 May 2007, Rafael J. Wysocki wrote:
> 
> Just to clarify, the change in question isn't new.  It was introduced by the
> commit 9185cfa92507d07ac787bc73d06c42222eec7239 before 2.6.20, at Seife's
> request and with Pavel's acceptance.

Ok, if it's that old, we migt as leave it in. Clearly there weren't many 
regressions, and this isn't a case of other monsters lurking behind a lack 
of testers.

		Linus
