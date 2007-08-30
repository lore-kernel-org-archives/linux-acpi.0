From: Danny ter Haar <dth@dth.net>
Subject: Re: [2/4] 2.6.23-rc4: known regressions
Date: Thu, 30 Aug 2007 10:21:38 +0200
Message-ID: <20070830082138.GA32165@dth.net>
References: <46D58CC6.4020605@googlemail.com> <46D59052.6040609@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zaphod.dth.net ([85.159.112.68]:55778 "EHLO zaphod.dth.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbXH3IVl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Aug 2007 04:21:41 -0400
Content-Disposition: inline
In-Reply-To: <46D59052.6040609@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Quoting Michal Piotrowski (michal.k.k.piotrowski@gmail.com):
> Here is a list of some known regressions in 2.6.23-rc4.
> CPUFREQ
> Subject         : ide problems: 2.6.22-git17 working, 2.6.23-rc1* is not
> References      : http://lkml.org/lkml/2007/7/27/298
>                   http://lkml.org/lkml/2007/7/29/371
> Last known good : ?
> Submitter       : dth <dth@dth.net>
> Caused-By       : Len Brown <lenb@kernel.org>
>                   commit f79e3185dd0f8650022518d7624c876d8929061b
> Handled-By      : Len Brown <lenb@kernel.org>
> Status          : problem is being debugged

I just compiled 2.6.23-rc4 on this setup to check if we made any
progress. After reboot i see:

[SNIP]
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 148 freed
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4
input: AT Translated Set 2 keyboard as /devices/platform/i8042/
printk: 7888020 messages suppressed
init[1]: segfault at 85890000 eip 85890000 esp bfcfcb8c error 4

[more of the last 2 lines repeated over and over]

Am i doing something wrong (very possible) or am i bitten by
another/new phenomena ?

Danny
-- 
