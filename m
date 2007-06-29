From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH] CodingStyle: Add information about trailing whitespace.
Date: Fri, 29 Jun 2007 23:31:18 +0400
Message-ID: <20070629193118.GA2108@zarina>
References: <1182967160.8970.108.camel@josh-work.beaverton.ibm.com> <20070627123122.257661e3.akpm@linux-foundation.org> <1183138323.17622.9.camel@shinybook.infradead.org> <20070629175204.GA1341@zarina> <1183142639.1170.371.camel@pmac.infradead.org>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fallback.mail.ru ([194.67.57.14]:11006 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbXF2Tec (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jun 2007 15:34:32 -0400
Received: from mx6.mail.ru (mx6.mail.ru [194.67.23.26])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id AA29D33B6BA
	for <linux-acpi@vger.kernel.org>; Fri, 29 Jun 2007 23:34:30 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <1183142639.1170.371.camel@pmac.infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, vladimir.p.lebedev@intel.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Fri, Jun 29, 2007 at 07:43:59PM +0100, David Woodhouse wrote:
> On Fri, 2007-06-29 at 21:52 +0400, Anton Vorontsov wrote:
> > Andrew, regarding git-battery-vs-git-acpi.patch.. I'll merge it as
> > soon as acpi related changes will hit Linus tree, would that be okay
> > for you? Not that I don't like these changes, I do like them. But
> > they'll break bare battery2-2.6 (based on Linus tree). Though, I can
> > merge it now if that will make your living easier.
> 
> Was anyone working on hooking up APM and ACPI to the new battery class,
> btw?

Don't know of anyone yet. But lets inquire appropriate people, I don't have
x86 hardware with batteries, thus I hardly can help on that matter, nor
following any x86 development.

Henrique de Moraes Holschuh (IBM ACPI EXTRAS maintainer) was involved in
battery class review, Cc'ed. Also Cc'ing ACPI BATTERY maintainer, and
linux-acpi list.

Just reminder: we're talking about power supply class, its git tree
is at git://git.infradead.org/users/cbou/battery2-2.6.git, you may also
find it in recent -mm patchsets. Most interesting directory is
drivers/power/, contains power supply class and drivers, plus header
file at include/linux/power_supply.h. Also,
Documentation/power_supply_class.txt exits.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.org/bd2
