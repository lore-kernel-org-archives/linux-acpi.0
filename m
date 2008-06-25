From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor register on
	resume
Date: Wed, 25 Jun 2008 19:01:26 +0200
Message-ID: <20080625170126.GA2482@elte.hu>
References: <200806242303.49498.rjw@sisk.pl> <20080624214610.GC18679@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40384 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbYFYRBt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jun 2008 13:01:49 -0400
Content-Disposition: inline
In-Reply-To: <20080624214610.GC18679@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


* Pavel Machek <pavel@suse.cz> wrote:

> Acked-by: Pavel Machek <pavel@suse.cz>
> 
> If this could be sneaked into Ingo's tree for some automated testing, 
> that would be good.

sure - i have applied it to tip/out-of-tree. I'm equally nervous about 
this change - it affects every suspend+resume cycle that people do on 
those boxes which are working just fine currently.

btw., it would get a lot more coverage on my test-systems if this commit 
in tip/out-of-tree:

| commit 01259383c345d13b70efcc549439927ae64dc66d
| Author: David Brownell <david-b@pacbell.net>
| Date:   Fri May 16 10:12:36 2008 +0200
|
|     sleepy linux self-test

was upstream and if it was enabled more prominently, instead of hidden 
behind the rather obscure condition of:

  config PM_TEST_SUSPEND
        bool "Test suspend/resume and wakealarm during bootup"
        depends on SUSPEND && PM_DEBUG && RTC_LIB=y

and even then it needs certain other config options related to RTC_LIB 
to actually work during bootup.

As a result of all this obstruction, the automated testing i do, which 
builds and boots more than 1 random kernel per minute, will only run 
this self-test once every hour or so.

I dont mind if this option breaks boxes (that its purpose: it does the 
same thing that a real suspend+resume does and suspend+resume frequently 
breaks boxes), but right now it's all obscured so heavily which makes 
automated testing a lot harder than it should be.

it would be wonderful if this excellent suspend+resume self-test was 
upstream and was more prominent! :-)

	Ingo
