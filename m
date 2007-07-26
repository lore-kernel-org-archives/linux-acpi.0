From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for
 2.6.23-rc1)
Date: Thu, 26 Jul 2007 12:57:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707261255380.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org>
 <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
 <200707261345.29902.lenb@kernel.org> <200707262117.26353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52032 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569AbXGZT6W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 15:58:22 -0400
In-Reply-To: <200707262117.26353.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>



On Thu, 26 Jul 2007, Rafael J. Wysocki wrote:
> 
> Hmm, perhaps we should introduce a CONFIG_SUSPEND and change
> CONFIG_SOFTWARE_SUSPEND into CONFIG_HIBERNATION, both depending on
> CONFIG_PM?
> 
> There's quite some code needed only for suspend compiled in when CONFIG_PM is
> set ...

Sounds like a good idea, although I suspect that CONFIG_PM really *is* 
fairly close to CONFIG_SUSPEND. The thing is, all the stuff it enabled is 
largely useless without at least STR.

(Yes, I realize that you can do per-driver suspend events etc, but I 
suspect not a lot of people have used it).

But from a logical standpoint, it does make sense to have a separate 
config option for the STR support.

		Linus
