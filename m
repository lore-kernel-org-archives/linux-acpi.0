From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] acpi/battery.c: make 2 functions static
Date: Mon, 3 Mar 2008 16:54:13 +0200
Message-ID: <20080303145413.GA26072@cs181133002.pp.htv.fi>
References: <20080303091314.GC4457@cs181133002.pp.htv.fi> <20080303091714.GA18250@elte.hu> <20080303093103.GA23651@uranus.ravnborg.org> <20080303103933.GC21190@elte.hu> <20080303113451.GF4457@cs181133002.pp.htv.fi> <20080303114533.GA4183@elte.hu> <20080303120211.GG4457@cs181133002.pp.htv.fi> <20080303121015.GA12660@elte.hu> <20080303122953.GH4457@cs181133002.pp.htv.fi> <20080303125027.GA21577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:39993 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbYCCOzu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2008 09:55:50 -0500
Content-Disposition: inline
In-Reply-To: <20080303125027.GA21577@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>

On Mon, Mar 03, 2008 at 01:50:27PM +0100, Ingo Molnar wrote:
> 
> * Adrian Bunk <bunk@kernel.org> wrote:
> 
> > I can only repeat that I did state several times on linux-kernel that 
> > it never worked.
> > 
> > If you consider it my fault that noone reads my emails then you are 
> > right that it's my fault...
> 
> well, i'm trying to assume the best, so please explain the following 
> sequence of events to me:
> 
> 1) as you said you knew about this bug - which bug causes more inlining
>    overhead than hundreds of your uninlining patches combined. The bug
>    was introduced ~2 years ago in -mm - before the feature hit mainline
>    in v2.6.16.

I don't remember having ever said this.

Your choices are:
[ ] prove your accusation that I said I
    "knew about this bug before the feature hit mainline"
[ ] apologize
[ ] be the firest person ever in my killfile

>...
> still, while you clearly had interest in this general area of the kernel 
> (for example you wrote hundreds of tiny uninlining patches that work 
> towards a similar goal),

I'm not sure with whom you confuse me on this one.
Perhaps with Ilpo?

I have sending some bigger uninlining patches on my TODO list for quite 
some time (since this is really the right thing to solve these issues), 
but I've not yet gotten there.

> but strangely at the same time you neither 
> fixed, nor properly escallated this _far_ bigger bug that causes +2.3% 
> of text bloat on x86 [more than 120K of kernel text]. In fact:
> 
> - you created bugzillas for far smaller bugs in the past, but you never
>   created a bugzilla for this that i'm aware of.

I'm well aware of the fact that our Bugzilla is mostly a /dev/null for 
the currently at about 1500 open bugs there.

That's why I tend [1] to only open bugs there for getting them into 
Rafael's regression lists.

>...
> - you never said "this is a regression that should be fixed" to any of
>   the regression lists.

This isn't a regression.

>...
> 	Ingo

cu
Adrian

[1] there are a few exceptions when I tried opening some bugs there

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

