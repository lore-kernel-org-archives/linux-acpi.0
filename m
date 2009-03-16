From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] thinkpad-acpi: fix module autoloading for older models
Date: Sun, 15 Mar 2009 22:51:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152250450.30317@localhost.localdomain>
References: <20090314104204.GA11226@mobydick>
 <ac3eb2510903140814t26954869m4f07623c25b5948f@mail.gmail.com>
 <20090314153526.GA13084@mobydick>
 <20090314175538.GA27278@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752303AbZCPCvk@vger.kernel.org>
In-reply-to: <20090314175538.GA27278@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, Kay Sievers <kay.sievers@vrfy.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org


On Sat, 14 Mar 2009, Henrique de Moraes Holschuh wrote:

> On Sat, 14 Mar 2009, Mathieu Chouquet-Stringer wrote:
> > On Sat, Mar 14, 2009 at 04:14:19PM +0100, Kay Sievers wrote:
> > > On Sat, Mar 14, 2009 at 11:42, Mathieu Chouquet-Stringer
> > > <mchouque@free.fr> wrote:
> > > 
> > > > While for older Thinkpads, you do this (for instance):
> > > > IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
> > > 
> > > Aliases are shell-style globs. Any idea what the ',' are doing in a
> > > character class? Confused ...
> > 
> > Good point...  I guess it's a typo: perhaps the original authors thought
> > of it as a brace expansion?  Something like 1{0,3,6,...}?
> 
> I bet that's exactly what happened...  it was a long time ago, so I don't
> recall exactly what I was (not) thinking about when I did it.
> 
> Thanks for noticing this, and the revised patch looks good.

revised patch (with commit log from 1st patch) applied.

thanks,
Len Brown, Intel Open Source Technology Center
