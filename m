From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 0/5] iASL patches in Debian
Date: Wed, 7 Jul 2010 12:27:20 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858A10EFE10@orsmsx503.amr.corp.intel.com>
References: <20100704044332.573836359@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51677 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab0GGT1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2010 15:27:23 -0400
In-Reply-To: <20100704044332.573836359@linux.it>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "malattia@linux.it" <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

If you'd like to get ambitious, run the ASLTS suite on the big-endian machines.


>-----Original Message-----
>From: malattia@linux.it [mailto:malattia@linux.it]
>Sent: Saturday, July 03, 2010 9:44 PM
>To: Moore, Robert
>Cc: Len Brown; linux-acpi@vger.kernel.org
>Subject: [patch 0/5] iASL patches in Debian
>
>Hi Robert,
>
>Here is a series of patches that I've been carrying in the iasl Debian
>package for some time. They are all refreshed and reworked to apply
>cleanly on top of acpica-unix-20100528.
>The series consists a couple of trivial patches to fix building on the
>FreeBSD and Hurd kernel flavours of Debian and some larger ones to enable
>compiling ASL on big endian architectures.
>It would be great if you could apply the patches to your source tree and
>ship new release with this work included.
>Let me know if you want me to run more tests or change something in the
>patches.
>
>I tested building tests/misc/grammar.asl (plus a number or other DSDTs I
>have here) with the whole set applied and the results were identical on
>BE and LE machines as well as being identical to what a clean iasl
>produces on x86[1].
>You can see build logs for all the architectures supported here:
>https://buildd.debian.org/status/package.php?p=acpica-unix
>
>Thanks
>
>[1]: checked with (1) an hex dump of the AML file, (2) the C file
>generated with -tc and (3) by decompiling the AML to DSL on x86 and
>comparing the results.
>As a side note pristine iasl on x86 sefaults when building
>test/misc/grammar.asl, with these patches applied it doesn't.
>
>--
>mattia
