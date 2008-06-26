From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor register on
	resume
Date: Thu, 26 Jun 2008 10:29:43 +0200
Message-ID: <20080626082943.GC10973@elte.hu>
References: <200806242303.49498.rjw@sisk.pl> <20080624214610.GC18679@elf.ucw.cz> <20080625170126.GA2482@elte.hu> <200806252217.27059.rjw@sisk.pl> <20080626011716.e8c412dd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40541 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbYFZIaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:30:12 -0400
Content-Disposition: inline
In-Reply-To: <20080626011716.e8c412dd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> Len seems to think that Rafael seems to think that Ingo seems to think 
> that this patch broke one of his boxes.
> 
> Is it so?

No! :-)

it found a pre-existing suspend+resume breakage on a testbox. (I.e. the 
debug patch worked as i'd expect it to work. Every good debug patch 
starts its lifetime with a sharp spike of breakages it finds.)

( my kernel test-setup does in excess of 100,000 random kernel bootups 
  per year and me not having to hit the keyboard or close+open the lid a 
  hundred thousand times, day and night, to find the occasional 
  suspend+resume regression is a not to be under-estimated plus. )

	Ingo
