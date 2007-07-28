From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for
 2.6.23-rc1)
Date: Sat, 28 Jul 2007 09:25:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707280921150.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org> <200707262248.09187.rjw@sisk.pl>
 <alpine.LFD.0.999.0707261351430.3442@woody.linux-foundation.org>
 <200707280330.26991.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34297 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801AbXG1Q0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jul 2007 12:26:08 -0400
In-Reply-To: <200707280330.26991.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>



On Sat, 28 Jul 2007, Len Brown wrote:
> 
> That three-liner will crash ACPI+SMP-HOTPLUG_CPU kernels on resume.

Explain that to me.

There should *be* no resume.

ACPI doesn't suspend/resume on its own, I hope.

It is all done by the top-level suspend/resume code, not by ACPI. ACPI is 
a pure helper, and if you've changed that, then I think we need to revert 
more than a few lines.

And it's the *top*level* code that selects HOTPLUG_CPU. Through 
SUSPEND_SMP (which will select HOTPLUG_CPU) and SOFTWARE_SUSPEND.

This is why it's so *totally* and *utterly* bogus for ACPI to select 
features that it has nothign what-so-ever to do with. 

In other words: ACPI isn't in the driving seat. 

			Linus
