From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Thu, 18 Jul 2013 00:09:16 +0200
Message-ID: <5649055.6Xlqb8sv3m@vostro.rjw.lan>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <4740878.DpcUBhhgIN@linux-5eaq.site> <1454582.aQCRT2GPRY@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47699 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340Ab3GQV7U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jul 2013 17:59:20 -0400
In-Reply-To: <1454582.aQCRT2GPRY@skinner.arch.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Oliver Neukum <oneukum@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lenb@kernel.org, linux-acpi@vger.kernel.org, Joey Lee <JLee@suse.com>

On Wednesday, July 17, 2013 04:58:34 PM Thomas Renninger wrote:
> On Monday, July 15, 2013 05:35:23 PM Oliver Neukum wrote:
> > On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote:
> > > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > > I would not make it too complicated.
> > > > Sticking to the latest Windows version should be enough for this one.
> > > > What bad should happen if we still try to resume and fail...
> > > 
> > > Hmm, why was that check added in the first place?
> > 
> > Safety.
> 
> I expect it is there, because it is stated rather clear in the specs.
>  
> > > If it is useless,
> > > removing it for good is fine.  If it is _not_ useless, we should still do
> > > the checking when not operating in windows-8 firmware mode.
> > 
> > Firmware will only be tested against Windows 8 pretty soon.
> > We'd end up with a gigantic list of exceptions.
> 
> Joey found an interessting paper about Win8 behavior:
> http://bizsupport2.austin.hp.com/bc/docs/support/SupportManual/c03654081/c03654081.pdf
> 
> It looks like Win8 behaves rather different compared to Linux and is providing
> "Hybrid Boot" where the user has to end all his apps. They have no big problem 
> when resume fails as the user will not lose any data or work he had done 
> before.
> 
> Joey also found the rather hidden acpi_sleep=s4_nohwsig boot option
> which helps as well.
> So Linux could do:
>    1) Invalidate suspend image and reboot  (disadvantage: message is gone)
>    2) Panic (current behavior) -> above boot param helps
>    3) Still try to resume with a "not so offending message"
>    4) ?
> 
> 1. seem to be what Win8 is doing
> 3. sounds best to me. It could be ugly if suspend fails and
> it always worked before and all your work/data is gone. So trying
> hard to resume sounds like a good idea

We can also blacklist systems that need acpi_sleep=s4_nohwsig due to idiotic
hardware/BIOS design choices.

In any case, if we remove the panic, we should also drop s4_nohwsig and since
we have that (which I forgot about, by bad), the whole issue isn't so urgent,
so I'm dropping the patch for the time being.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
