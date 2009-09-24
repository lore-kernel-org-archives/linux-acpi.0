From: "Joshua C." <joshuacov@googlemail.com>
Subject: Linux acpi compatibility / intel iasl compiler
Date: Thu, 24 Sep 2009 23:41:27 +0200
Message-ID: <5f6f8c5f0909241441s683a228fifb9add8e736fddf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f183.google.com ([209.85.210.183]:52684 "EHLO
	mail-yx0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZIXVlX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2009 17:41:23 -0400
Received: by yxe13 with SMTP id 13so2460040yxe.23
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2009 14:41:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
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
"acpi 1.0 support". here is linux kernel bug report kernelbug #10237.
Here are my questions:

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
from the acpica project therefore there shouldn't be any compatibility
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

--joshua
