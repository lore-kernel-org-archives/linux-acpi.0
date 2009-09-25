From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Linux acpi compatibility / iasl compiler
Date: Thu, 24 Sep 2009 19:18:38 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308583AE9A6C6@orsmsx503.amr.corp.intel.com>
References: <7AF83C134DEA3240992E8EF512F61B7903C21AC51E@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54835 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbZIYCSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2009 22:18:36 -0400
In-Reply-To: <7AF83C134DEA3240992E8EF512F61B7903C21AC51E@pdsmsx502.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, "joshuacov@googlemail.com" <joshuacov@googlemail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


1. Can I substitute the original dsdt (compiled with ms asl 2) with
the one compiled and optimazed with Intel iasl?


Yes. It should work the same as the original.

2. Is there such a "big" diffference between the code produced by
these apps?

iASL is an optimizing compiler. It will optimize all namepaths to their minimum lengths, it will minimize integer sizes, and will perform constant folding. These optimizations can shrink the code considerably.


3. How should windows react to the new dsdt recompiled with intel's
iasl?

The DSDT should perform identically. It has simply been optimized by iASL.
I can't speak to the other ACPI tables on your machine (although, usually any other ASL/AML tables are SSDTs)


4) You should let the kernel override the DSDT with your DSDT before you even think about flashing the bios.



-----Original Message-----

From: Joshua C. <joshuacov@googlemail.com>
Date: Fri, Sep 25, 2009 at 5:34 AM
Subject: Linux acpi compatibility / iasl compiler
To: linux-acpi@vger.kernel.org


I had a problem with the linux acpi almost a year ago. The problem was
a bug in the dsdt table which was later fixed and the fix ended in the
main kernel tree. Now it is fine. Windows had no problems at all.

However I found a way to recompile the dsdt table and put the right
one back in the bios file. There is a "small" problem. The original
dsdt was recompiled with the microsoft asl compiler v2.0.2 Beta. After
fixing it and recompiling it back, the new acpi modul doesn't fit in
the bios file. Therefore I used the latest intel asl compiler -
acpica-unix-20090903 (no errors, no wanrings after fixing it). I used
the optimazation option and the resulted aml file fits in the bios.
Without the optimazation, it is with 4 bytes longer than the available
space.
This is a 2006-2007 acer notebook with phoenix bios, which means being
designed sometime in 2005. After dumping the original dsdt iasl says
"acpi 1.0 support". here is linux kernel bug report
http://bugzilla.kernel.org/show_bug.cgi?id=10237 Here are my
questions:

1. Can I substitute the original dsdt (compiled with ms asl 2) with
the one compiled and optimazed with Intel iasl? How will the hardware
react? Will there be any problems  that can make the notebook
unbootable (not connected to the flashing process and checksums)?

2. Is there such a "big" diffference between the code produced by
these apps? I know that ms doesn't stick to any standards and their
compiler compiles almost anything without checking anything. On the
other side the iasl asked me to correct 4-5 things. I've tested the
recompiled dsdt with linux (inserted in the kernel) and it works fine.
I know that linux sticks to standards and uses the code that comes
from acpica.org therefore there shouldn't be any compatibility
problems with linux.

3. How should windows react to the new dsdt recompiled with intel's
iasl? will it be incompatible? Is it possible that the microsft asl is
somehow even deeper rooted in the original bios, not just in the dsdt?
What about the other apci tables and code? Should they also me
recompiled with iasl? Possible HARDWARE incompatibility issues?

4. Any experiences with such bios-dsdt substitution?

I know that some peoplewho read this list and have much greater
knowledge about the linux/microsft implementation of the bios code.
Therefore I need some advise (appart from "don't do it, you'll break
everything") before trying this.

Please help me with any possible problems before flashing my modified bios.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
