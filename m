From: Linus Torvalds <torvalds@osdl.org>
Subject: kacpi_notify?
Date: Wed, 12 Jul 2006 12:41:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121232000.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:21444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWGLTlZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 15:41:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org


Hmm.

What's up with this?

 2341 ?        D<     0:00 [kacpid_notify]
 2342 ?        D<     0:00 [kacpid_notify]
 2343 ?        D<     0:00 [kacpid_notify]
 2344 ?        D<     0:00 [kacpid_notify]
 2345 ?        D<     0:00 [kacpid_notify]
 2346 ?        D<     0:00 [kacpid_notify]
 2347 ?        D<     0:00 [kacpid_notify]
 ...

(apparently about 300 of those processes, at which point the machine just 
hangs, because even root cannot start any new processes, and I couldn't 
actually get to debug this at all).

What would it be waiting on, and why?

This machine doesn't have any module support (at all), and I haven't 
booted a new kernel on it in quite a while, so this isn't necessarily new 
behaviour, but the last kernel I tried (which did _not_ have this problem, 
obviously) was in April (commit 6e5882cfa24e1456702e463f6920fc0ca3c3d2b8, 
to be exact).

Now, that's 6000+ commits ago, so I'd rather not even bisect this, if 
somebody can come up with a more obvious explanation of why kacpid_notify 
would be started over and over and over again, only to always get stuck..

		Linus
