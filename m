From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Date: Mon, 14 May 2007 09:50:45 +0200
Message-ID: <20070514075045.GA10238@suse.de>
References: <200611011323.14830.rjw@sisk.pl> <200705111121.51704.rjw@sisk.pl> <alpine.LFD.0.98.0705110912290.3986@woody.linux-foundation.org> <200705112208.53971.rjw@sisk.pl> <alpine.LFD.0.98.0705111550540.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49567 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbXENHwA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 03:52:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705111550540.3986@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Coywolf Qi Hunt <coywolf@gmail.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org

On Fri, May 11, 2007 at 03:51:38PM -0700, Linus Torvalds wrote:
>=20
>=20
> On Fri, 11 May 2007, Rafael J. Wysocki wrote:
> >=20
> > Just to clarify, the change in question isn't new.  It was introduc=
ed by the
> > commit 9185cfa92507d07ac787bc73d06c42222eec7239 before 2.6.20, at S=
eife's
> > request and with Pavel's acceptance.
>=20
> Ok, if it's that old, we migt as leave it in. Clearly there weren't m=
any=20
> regressions, and this isn't a case of other monsters lurking behind a=
 lack=20
> of testers.

I pushed for this since on ACPI machines, "platform" is the right thing=
 to do,
and i still think it will only break on machines that have a broken ACP=
I BIOS.
(Are there machines with broken ACPI BIOS around? ;-)

Your additional "fall back to shutdown if !(ops)"-fix looks very sane,
however, and is definitely a good idea.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
