From: malattia@linux.it
Subject: [patch 0/5] iASL patches in Debian
Date: Sun, 04 Jul 2010 13:43:32 +0900
Message-ID: <20100704044332.573836359@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:49574
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab0GDEvA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 00:51:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <Robert.Moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi Robert,

Here is a series of patches that I've been carrying in the iasl Debian
package for some time. They are all refreshed and reworked to apply
cleanly on top of acpica-unix-20100528.
The series consists a couple of trivial patches to fix building on the
FreeBSD and Hurd kernel flavours of Debian and some larger ones to enable
compiling ASL on big endian architectures.
It would be great if you could apply the patches to your source tree and
ship new release with this work included.
Let me know if you want me to run more tests or change something in the
patches.

I tested building tests/misc/grammar.asl (plus a number or other DSDTs I
have here) with the whole set applied and the results were identical on
BE and LE machines as well as being identical to what a clean iasl
produces on x86[1].
You can see build logs for all the architectures supported here:
https://buildd.debian.org/status/package.php?p=acpica-unix

Thanks

[1]: checked with (1) an hex dump of the AML file, (2) the C file
generated with -tc and (3) by decompiling the AML to DSL on x86 and
comparing the results.
As a side note pristine iasl on x86 sefaults when building
test/misc/grammar.asl, with these patches applied it doesn't.

-- 
mattia
