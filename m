From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Wed, 17 Jul 2013 16:58:34 +0200
Message-ID: <1454582.aQCRT2GPRY@skinner.arch.suse.de>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <20130715150611.GC1074@khazad-dum.debian.net> <4740878.DpcUBhhgIN@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52337 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab3GQO6k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 10:58:40 -0400
In-Reply-To: <4740878.DpcUBhhgIN@linux-5eaq.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, Joey Lee <JLee@suse.com>

On Monday, July 15, 2013 05:35:23 PM Oliver Neukum wrote:
> On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote:
> > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > I would not make it too complicated.
> > > Sticking to the latest Windows version should be enough for this one.
> > > What bad should happen if we still try to resume and fail...
> > 
> > Hmm, why was that check added in the first place?
> 
> Safety.

I expect it is there, because it is stated rather clear in the specs.
 
> > If it is useless,
> > removing it for good is fine.  If it is _not_ useless, we should still do
> > the checking when not operating in windows-8 firmware mode.
> 
> Firmware will only be tested against Windows 8 pretty soon.
> We'd end up with a gigantic list of exceptions.

Joey found an interessting paper about Win8 behavior:
http://bizsupport2.austin.hp.com/bc/docs/support/SupportManual/c03654081/c03654081.pdf

It looks like Win8 behaves rather different compared to Linux and is providing
"Hybrid Boot" where the user has to end all his apps. They have no big problem 
when resume fails as the user will not lose any data or work he had done 
before.

Joey also found the rather hidden acpi_sleep=s4_nohwsig boot option
which helps as well.
So Linux could do:
   1) Invalidate suspend image and reboot  (disadvantage: message is gone)
   2) Panic (current behavior) -> above boot param helps
   3) Still try to resume with a "not so offending message"
   4) ?

1. seem to be what Win8 is doing
3. sounds best to me. It could be ugly if suspend fails and
it always worked before and all your work/data is gone. So trying
hard to resume sounds like a good idea

I guess this still needs some discussion?

At least some facts came up already and people have an idea what
happens...

       Thomas
